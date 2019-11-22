# DotNet Core Demo
- This project is a work in progress. It aims to demonstrate basic dotnet core WebAPI hosted on an Ubuntu VM (Xenial).
- This project loads everything using a Vagrantfile which installs all the pre-requisites.

# Optional Installs
These applications are fully optional to be installed on your development machine.
These are only required in order to host the MSSQL database and Docker engine used in this demo.
- Vagrant v2.2.5 from [Vagrant's website](https://www.vagrantup.com/)
- Virtualbox v6.0.12 from [Oracle Virtualbox Older Builds](https://www.virtualbox.org/wiki/Download_Old_Builds_6_0)

# Running this Demo with Vagrant
- Ensure that Vagrant and VirtualBox are already installed on your development machine.
- Once confirmed, open VSCode and navigate to the root of the Project Folder ```%Local_Directory%\vg-netcore-mssql\```.
- Launch the terminal then type ```vagrant up``` or ```vagrant up --provision```. This command will bring up the guest VM and call the provision shell scripts to setup the database and the project.

# Running this Demo without Vagrant
To run this demo without installing the above applications, these are required to be on the developer machine.
- MSSQL Server. Developer version will do.
- .Net Core 2.2 Runtime, SDK and Hosting. .Net 3.0 will work as well but requires some changes on the application.
- Run the database create script found in ```%Local_Directory%\vg-netcore-mssql\db_scripts\db_init.sql``` against your Dev SQL Server.
- Then either change your database password for SA user or change the username and password in the connection string found in ```%Local_Directory%\vg-netcore-mssql\api\ClientAPI\appsettings.Development.json```.
- In VS Code, got to File menu then select ```Add Folder to Workspace```, then select the vg-netcore-mssql folder.
- Once added, click on the Debug icon then hit the play button to run the application.


# Verify if the app is running
- Open a browser and navigate to http://localhost:8090/sweagger. This will bring you to the Swagger UI documentation which will allow you to test the API endpoints.

# Current State:
- Runs Ubuntu Xenial in Virtualbox provisioned via Vagrant.
- Installs Docker inside the guest VM. Then pulls and builds the MSSQL database.
- Sets up the sample databases and tables. The database will be exposed to the host machine on port 1444.
- Runs 1 containerized .NET Core API called ClientAPI with basic get functions to fetch data from MSSQL database.

# Todos
- Centralized Logging.
- Upgrade to dotNetCore 3.0.

# Important Information!
Vagrant conflicts with Hyper-V
----
If you have Docker installed on your Development machine, you'll need to disable Hyper-V for Vagrant to work. 

In some cases, you may still encounter VT-x error even when you've already enable Virtualization in your BIOS. To deal with this, run the code below on an Administrator command prompt. Then reboot your computer. Note: This setting may be reset by Group Policies.

```
bcdedit /set hypervisorlaunchtype off
```

Vagrant SSH: Permission denied (publickey)
----
Running ```vagrant ssh -- -vv``` will show you that this error pertains to Windows SSH thinking the Vagrant private is not secured or "too open".

To work around this, locate the private_key file generated when you run ```vagrant up```, then only grant your current Windows user account and remove any inherited permissions by going to the files ```Properties > Security > Advanced Security Settings (using the Edit button)```.
