resource "openstack_compute_instance_v2" "webserver" {
  name            = "webserver"
  key_pair        = openstack_compute_keypair_v2.keypair.id
  security_groups = ["default"]
  flavor_name     = "gp1.lightspeed"
  image_id        = data.openstack_images_image_v2.ubuntu.id
  user_data       = file("setup.sh")
  network {
    name = "public"
  }
}

resource "openstack_compute_volume_attach_v2" "webserver" {
  instance_id = openstack_compute_instance_v2.webserver.id
  volume_id   = openstack_blockstorage_volume_v3.web_data.id
  depends_on = [
    openstack_compute_instance_v2.webserver
  ]
}

resource "null_resource" "cloud-init" {
  triggers = {
    default_instance_id = openstack_compute_instance_v2.webserver.id
  }
  provisioner "file" {
    source      = "wait.sh"
    destination = "/tmp/wait.sh"
    connection {
      host        = openstack_compute_instance_v2.webserver.access_ip_v4
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/wait.sh",
      "/tmp/wait.sh"
    ]
    connection {
      host        = openstack_compute_instance_v2.webserver.access_ip_v4
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
      timeout     = "20m"
    }
  }
  depends_on = [
    openstack_compute_instance_v2.webserver,
    openstack_compute_volume_attach_v2.webserver
  ]
}

resource "null_resource" "ansible" {
  triggers = {
    default_instance_id = openstack_compute_instance_v2.webserver.id
  }
  provisioner "file" {
    source      = "setup.yaml"
    destination = "/tmp/setup.yaml"
    connection {
      host        = openstack_compute_instance_v2.webserver.access_ip_v4
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("~/.ssh/id_rsa")
    }
  }
  # provisioner "local-exec" {
  #   inline = [
  #     "ANSIBLE_SHELL_ALLOW_WORLD_READABLE_TEMP=true ANSIBLE_PIPELINING=true ansible-playbook ./setup.yaml -i ${openstack_compute_instance_v2.webserver.access_ip_v4}"
  #   ]
  #  connection {
  #    host        = openstack_compute_instance_v2.webserver.access_ip_v4
  #    type        = "ssh"
  #    user        = "ubuntu"
  #    private_key = file("~/.ssh/id_rsa")
  #    timeout     = "20m"
  #  }
  # }
  depends_on = [
    openstack_compute_instance_v2.webserver,
    openstack_compute_volume_attach_v2.webserver,
    null_resource.cloud-init
  ]
}