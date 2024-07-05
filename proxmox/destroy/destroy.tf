resource "null_resource" "shutdown_delete" {
  provisioner "local-exec" {
    command = <<EOT

      #!/bin/env bash

      if [ "${var.resource_type}" = "vm" ]; then
        ssh root@${var.PM_HOST} "qm shutdown ${var.vm_id} && sleep 10 && qm destroy ${var.vm_id}"
      elif [ "${var.resource_type}" = "lxc" ]; then
        ssh root@${var.PM_HOST} "pct shutdown ${var.vm_id} && sleep 10 && pct destroy ${var.vm_id}"
      else
        echo "Invalid resource type specified."
        exit 1
      fi
    EOT
  }
}

output "deletion_result" {
  value = "Resource ${var.vm_id} of type ${var.resource_type} has been deleted."
}
