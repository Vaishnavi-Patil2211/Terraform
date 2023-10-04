# main.tf

resource "null_resource" "virtualbox_vm" {
  provisioner "local-exec" {
    command = "VBoxManage createvm --name my_vm --ostype Ubuntu_64 --register"
  }

  provisioner "local-exec" {
    when    = "destroy"
    command = "VBoxManage unregistervm my_vm --delete"
  }
}

# Trigger the null_resource to create the VM
resource "null_resource" "trigger_vm_creation" {
  triggers = {
    always_run = "${timestamp()}"
  }

  depends_on = [null_resource.virtualbox_vm]
}
