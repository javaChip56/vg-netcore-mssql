#!/bin/bash
VAGRANT_HOST_DIR=$1
BUILD_CLIENT_API=$2
SQL_PASSWORD=$3

echo_parameters()
{
    echo "Parameters received from Vagrantfile: $VAGRANT_HOST_DIR $BUILD_CLIENT_API $SQL_PASSWORD"  
}

img_pull_sqlserver()
{
    docker rm -f docker-mssql
    echo "Pulling SQL server 2017 from remote Docker registry."
    # Pulling the image from remote docker registry may take a while. Wait for this command to finish.
    docker pull mcr.microsoft.com/mssql/server:2017-latest &
    wait $!
    echo "Successfully pulled SQL Server 2017 Docker image."
}

img_build_sqlserver_nonroot()
{
    echo "Building Non-root SQL Server 2017."
    docker build $VAGRANT_HOST_DIR/docker/sql-nonroot -t sqlserver-2017-nonroot &
    wait $!
}

container_run_sqlserver()
{
    echo "Running Non-root SQL Server 2017 container."
    docker run -d --restart unless-stopped -p 1433:1433 -v sqlvolume:/var/opt/mssql -e SA_PASSWORD=D0cker123 -e ACCEPT_EULA=Y --name docker-mssql sqlserver-2017-nonroot &
    wait $!
    sudo usermod -aG docker mssql
}

db_setup()
{
    echo "Setting up Client database."
    # Copy the DB initialization scripts from host to the container scripts directory.
    docker cp /mnt/host/db_scripts/db_init.sql docker-mssql:/var/opt/mssql-scripts/db_init.sql
    # Run the DB initilization script.
    docker exec docker-mssql /bin/sh -c '/opt/mssql-tools/bin/sqlcmd -S localhost -U SA -P '"$SQL_PASSWORD"' -i /var/opt/mssql-scripts/db_init.sql' &
    wait $!
    echo "SQL Server is ready."
}

reset_database_data()
{
    rm -rf $VAGRANT_HOST_DIR/mssql_data/
}

########################
# Update OS
########################
update_os()
{
    apt-get update
    apt-get -y install emacs
    apt-get -y install apt-transport-https ca-certificates
    apt-key adv --keyserver  hkp://keyserver.ubuntu.com:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D
}

########################
# Docker
########################
install_docker_engine()
{
    echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list
    sudo apt-get update
    sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
    sudo apt-get update
    sudo apt-get -y install linux-image-generic-lts-xenial
    sudo apt-get -y install apache2-utils
    # sudo -- sh -c -e "echo '52.84.227.108   subdomain.domain.com' >> /etc/hosts"
    # apt-get -y install docker-engine
    apt-get -y install docker.io
    # required to prevent masking of docker services.
    sudo systemctl unmask docker.service
    sudo systemctl unmask docker.socket
    sudo systemctl start docker.service
    #
    sudo systemctl enable docker
    sudo usermod -aG docker vagrant
    # 
}

build_client_api()
{
    docker rm -f /docker-client-api
    docker build $VAGRANT_HOST_DIR/api/clientapi -t img-client-api
    docker run -d --name docker-client-api -p 8090:8090 img-client-api:latest
}

########################
# Install NGINX
########################
install_nginx()
{
    docker pull nginx
    docker run -d -p 80:8080 --name docker-nginx nginx
    docker start docker-nginx
}

########################
# Start Provisioning
########################

echo_parameters

echo "Updating OS."
update_os
echo "OS successfully updated."

echo "Installing Docker Engine."
install_docker_engine
echo "Docker Engine successfully installed."

img_pull_sqlserver
img_build_sqlserver_nonroot
container_run_sqlserver
db_setup

# echo "Resetting the database."
# reset_database_data

if ($BUILD_CLIENT_API = true)
    then
        echo "Build Client API."
        build_client_api
        echo "Successfully built client API in Docker."
    else
        echo "User skipped building Client API."
fi
