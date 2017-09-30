provider "digitalocean" {
  token = "${var.do_token}"
}

resource "digitalocean_ssh_key" "default" {
  name = "${var.do_key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "digitalocean_droplet" "docker_swarm_manager" {
  name = "docker-swarm-manager"
  region = "ams3"
  size = "512mb"
  image = "coreos-alpha"
  ssh_keys = ["${digitalocean_ssh_key.default.id}"]
  private_networking = true

  connection {
    user = "core"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm init --advertise-addr ${digitalocean_droplet.docker_swarm_manager.ipv4_address_private}"
    ]
  }
}

resource "digitalocean_droplet" "docker_swarm_worker" {
  count = 3
  name = "docker-swarm-worker-${count.index}"
  region = "ams3"
  size = "512mb"
  image = "coreos-alpha"
  ssh_keys = ["${digitalocean_ssh_key.default.id}"]
  private_networking = true

  connection {
    user = "core"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm join --token ${data.external.swarm_join_token.result.worker} ${digitalocean_droplet.docker_swarm_manager.ipv4_address_private}:2377"
    ]
  }
}

data "external" "swarm_join_token" {
  program = ["./get-join-tokens.sh"]
  query = {
    host = "${digitalocean_droplet.docker_swarm_manager.ipv4_address}"
  }
}
