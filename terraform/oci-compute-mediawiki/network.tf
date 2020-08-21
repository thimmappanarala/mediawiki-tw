##VCN Creation####
resource "oci_core_virtual_network" "mediawiki_vcn" {
  compartment_id = "${var.compartment_ocid}"
  display_name = "mediawiki-vcn"
  cidr_block = "192.168.10.0/24"
  dns_label = "mediawiki"
}
##Internet Gateway Creation for accessing internet###
resource "oci_core_internet_gateway" "mediawiki_igw" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.mediawiki_vcn.id}"
  display_name = "mediawiki-igw"
  enabled = "true"
}
#Route table for mediawki Subnet#
resource "oci_core_route_table" "mediawiki_rt" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.mediawiki_vcn.id}"
  display_name = "mediawiki-rt"
  route_rules {
    destination = "0.0.0.0/0"
    network_entity_id = "${oci_core_internet_gateway.mediawiki_igw.id}"
  }
}
#Security Rules for Mediawiki Subnet#
resource "oci_core_security_list" "mediawiki_sl" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.mediawiki_vcn.id}"
  display_name = "mediawiki-sl"
  egress_security_rules { 
	destination = "0.0.0.0/0"
	protocol = "all"
	}
  ingress_security_rules {
	protocol = "6"
	source = "0.0.0.0/0"
	}
}
#Subnet Creation for mediawiki#
resource "oci_core_subnet" "mediawiki_subnet" {
  compartment_id = "${var.compartment_ocid}"
  vcn_id = "${oci_core_virtual_network.mediawiki_vcn.id}"
  display_name = "mediawiki-subnet"
  availability_domain = "${local.ad_1_name}"
  cidr_block = "192.168.10.0/30"
  route_table_id = "${oci_core_route_table.mediawiki_rt.id}"
  security_list_ids = ["${oci_core_security_list.mediawiki_sl.id}"]
  dhcp_options_id = "${oci_core_virtual_network.mediawiki_vcn.default_dhcp_options_id}"
  dns_label = "mediawikisubnet"
}
