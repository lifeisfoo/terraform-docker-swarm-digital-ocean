# Docker swarm with terraform on Digital Ocean

from: https://knpw.rs/blog/docker-swarm-terraform/

## Install terraform

    brew install terraform
    
## Create a ssh key

    ssh-keygen -o -a 100 -t ed25519 -C dockerswarm@digitalocean
    ssh-add ~/.ssh/id_ed25519

## Run

    terraform init
    terraform plan
    terraform apply
    
## Deploy a service

    ssh root@$(terraform output manager_public_ip)
    docker service create -d --name nginx -p 80:80 --replicas 2 nginx
