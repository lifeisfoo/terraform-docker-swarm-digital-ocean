# Docker swarm with terraform on Digital Ocean

from: https://knpw.rs/blog/docker-swarm-terraform/

## Install terraform

    brew install terraform
    
## Create a ssh key

    ssh-keygen -o -a 100 -t ed25519 -C dockerswarm@digitalocean
    ssh-add ~/.ssh/id_ed25519

## Create a Token on Digital Ocean

And add it inside `terraform.tfvars`

Now follow every readme.

## Docs

https://www.terraform.io/docs/providers/do/
