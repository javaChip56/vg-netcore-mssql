#!/bin/bash
VAGRANT_HOST_DIR=$1
BUILD_CLIENT_API=$2

echo_parameters()
{
    echo "Parameters received from Vagrantfile: $VAGRANT_HOST_DIR $BUILD_CLIENT_API"  
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
    echo "deb https://apt.dockerproject.org/repo bionic main" | sudo tee /etc/apt/sources.list.d/docker.list
    apt-get update
    apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual
    apt-get update
    apt-get -y install linux-image-generic-lts-bionic
    apt-get -y install apache2-utils
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
    sudo usermod -aG docker mssql
}

########################
# Docker Compose
########################
install_docker_compose()
{
    echo "Pulling Docker Compose from source."
    sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
}

init_docker_compose()
{
    docker rm -f /docker-mssql
    docker-compose rm -v
    docker-compose -f $VAGRANT_HOST_DIR/docker/compose/docker-compose.yml up -d
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

echo "Installing Docker Compose."
install_docker_compose
echo "Docker Compose successfully installed."

# echo "Resetting the database."
# reset_database_data

echo "Setting up database."
init_docker_compose

if ($BUILD_CLIENT_API = true)
    then
        echo "Build Client API."
        build_client_api
        echo "Successfully built client API in Docker."
    else
        echo "User skipped building Client API."
fi



