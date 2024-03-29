resource "openstack_blockstorage_volume_v3" "web_data" {
  name        = "webdata"
  description = "map to /var/www"
  size        = 10
}
