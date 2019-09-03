# PowerShell - Ansible Fact Report for Tower Hosts

# Summary

This script allows the ability to report on the tower hosts and their facts. This requires that fact cache be enabled on the Tower Job Templates. The output is a PowerShell hash and can be output to PowerShell Out-GridView, Export-CSV or other formats. All properties are accessible as object.property.
Enable Fact Cache on your jobs
In the Job Template editor on the Tower UI check the box in the corner to enable “USE FACT CACHE”
 
# Command line parameters

-twr_user
•	User with ability to read the Tower API

-twr_server
•	Tower server with the inventory to report on

-twr_pass
•	Tower user password as securestring

# Command line syntax

# An example of and adhoc job

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver 

# An example of calling the script with a plain text password

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver -twr_pass $( 'password' | ConvertTo-SecureString -AsPlainText -Force)

# An example of grid view output

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver  | Out-GridView -Title “Ansible Facts”


DISCLAIMER: Try not to type passwords in the shell
