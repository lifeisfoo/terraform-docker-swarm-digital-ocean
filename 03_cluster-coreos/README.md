## Run

    terraform init
    terraform plan
    terraform apply
    terraform output manager_public_ip
    
## Deploy a service

WARNING: core is the user!

    ssh core@$(terraform output manager_public_ip)
    docker service create -d --name nginx -p 80:80 --replicas 2 nginx

## Notes

CoreOS includes Docker, so no installation is required.
