resource "local_file" "ansible_inventory" {
  content = templatefile("${path.module}/templates/inventory.tmpl", {
    master_ip         = module.ec2_instance[0].public_ip
    slave_ip          = module.ec2_instance[1].public_ip
    master_internal_ip = module.ec2_instance[0].private_ip
    slave_internal_ip = module.ec2_instance[1].private_ip
    ssh_key_path      = "~/Desktop/test.pem"
  })
  filename = "${path.module}/../ansible+sql/inventory/hosts.yml"
}