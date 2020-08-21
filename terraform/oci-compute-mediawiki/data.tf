data "oci_core_images" "OEL_images" {
  compartment_id = "${var.tenancy_ocid}"
  operating_system =  "Oracle Linux"
}
output "OEL_images" {
  value = "${data.oci_core_images.OEL_images.images}"
}
