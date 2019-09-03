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

# Examples and Command line syntax

# <h6> An example of and adhoc job

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver 

# <h6> An example of calling the script with a plain text password

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver -twr_pass $( 'password' | ConvertTo-SecureString -AsPlainText -Force)

# <h6> An example of grid view output

ansible_gather_facts.ps1 -twr_user toweruser -twr_server towerserver  | Out-GridView -Title “Ansible Facts”

# Conclusion
Now that you have control of the fact data from your Tower hosts you can now use it to populate CMDB, report on the facts or just show your friends how cool you are.


DISCLAIMER: Try not to type passwords in the shell
