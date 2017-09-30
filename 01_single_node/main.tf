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
  image = "ubuntu-16-04-x64"
  ssh_keys = ["${digitalocean_ssh_key.default.id}"]
  private_networking = true

  provisioner "remote-exec" {
    script = "install-docker.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "docker swarm init --advertise-addr ${digitalocean_droplet.docker_swarm_manager.ipv4_address_private}"
    ]
  }
}
