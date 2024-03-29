resource "openstack_networking_secgroup_rule_v2" "ssh_home" {
  direction         = "ingress"
  description       = "Allow ssh from my IP"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.remote_ip_prefix
}

resource "openstack_networking_secgroup_rule_v2" "ssh_runner" {
  direction         = "ingress"
  description       = "Allow ssh from GitHub runner IP"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = var.runner_ip_prefix
}

resource "openstack_networking_secgroup_rule_v2" "postgresql" {
  direction         = "ingress"
  description       = "Only allow PostgreSQL management from my IP"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  port_range_min    = 5432
  port_range_max    = 5432
  remote_ip_prefix  = var.remote_ip_prefix
}

resource "openstack_networking_secgroup_rule_v2" "http" {
  direction         = "ingress"
  description       = "Inbound HTTP traffic"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  port_range_min    = 80
  port_range_max    = 80
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "https" {
  direction         = "ingress"
  description       = "Inbound HTTPS traffic"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  port_range_min    = 443
  port_range_max    = 443
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "egress_tcp" {
  direction         = "egress"
  description       = "Allow list for outbound TCP"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "tcp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "egress_udp" {
  direction         = "egress"
  description       = "Allow list for outbound udp"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "udp"
  remote_ip_prefix  = "0.0.0.0/0"
}

resource "openstack_networking_secgroup_rule_v2" "egress_icmp" {
  direction         = "egress"
  description       = "Allow list for outbound icmp"
  ethertype         = "IPv4"
  security_group_id = data.openstack_networking_secgroup_v2.default.id
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
}