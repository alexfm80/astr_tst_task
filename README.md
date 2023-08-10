Test task.
This terraform script does:
 - creates a small(2CPU 2 GB RAM) VM instance in Yandex Cloud with static IP 
 - installs ansible and git 
 - pulls repo with ansible playbook
       - ansible playbook:
            - updates the OS
            - installs docker
            - creates self-signed certificate
            - runs nginx docker container 
            - configures nginx to use the certificate

In oder to apply terraform it is required to enter nessesery variables into variables.tf


