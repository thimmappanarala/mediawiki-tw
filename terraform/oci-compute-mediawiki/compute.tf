resource "oci_core_instance" "mediawiki_vm" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "mediawiki-vm"
  availability_domain = "${local.ad_1_name}"

  source_details {
    source_id = "${local.oracle_linux_image_ocid}"
    source_type = "image"
  }
  shape = "VM.Standard2.1"
  create_vnic_details {
    subnet_id = "${oci_core_subnet.mediawiki_subnet.id}"
    display_name = "primary-vnic"
    assign_public_ip = true
    private_ip = "192.168.10.2"
    hostname_label = "mediawiki"
  }
  metadata = {
    ssh_authorized_keys = "${file(".ssh/id_rsa.pub")}"
    user_data = "${base64encode(file("vm.cloud-config"))}"
  }
  timeouts {
    create = "5m"
  }
}
