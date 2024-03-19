data "openstack_networking_secgroup_v2" "default" {
  name              = "default"
}

data "openstack_images_image_v2" "ubuntu" {
  name              = "Ubuntu-22.04"
  most_recent       = true
}