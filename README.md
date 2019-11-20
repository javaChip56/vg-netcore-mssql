# DotNet Core Demo
- This project is a work in progress. It aims to demonstrate basic dotnet core WebAPI hosted on an Ubuntu VM (Bionic).
- This project loads everything using a Vagrantfile which installs all the pre-requisites.

# Current State:
- Runs Ubuntu Bionic in Virtualbox provisioned via Vagrant.
- Installs Docker inside the guest VM. Then pulls and builds the MSSQL database.
- Sets up the sample databases and tables.
- Runs 1 containerized .NET Core API called ClientAPI with basic get functions to fetch data from MSSQL database.

# Prerequisites
These are required to be installed on your development machine in  order to host the MSSQL database and Docker engine in this demo:
- Vagrant v2.2.5 from [Vagrant's website](https://www.vagrantup.com/)
- Virtualbox v6.0.12 from [Oracle Virtualbox Older Builds](https://www.virtualbox.org/wiki/Download_Old_Builds_6_0)

# Todos
- Other CRUD functionality.

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
