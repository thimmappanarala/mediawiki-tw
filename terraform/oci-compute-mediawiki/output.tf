output "public_ip" {
      description = "public ip of created mediawki VM. "
      value       = oci_core_instance.mediawiki_vm.public_ip
    }
