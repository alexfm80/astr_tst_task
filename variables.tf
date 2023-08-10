variable "zone" {
  description = "availability zone name"
  default = ""
}

variable "cloud_id" {
  description = "Cloud ID"
  default = ""
}

variable "folder_id" {
   description = " Folder ID"
   default = ""
}

variable "subnet_id" {
  description = " Subnet ID"
  default = ""
}

variable "image_id" {
  description = "OS image id"
  default = ""
}

variable "service_account_key_file" {
  description = "Path to your account key file (json)"	
  default = ""
  sensitive = true
}

variable "vm_name" {
  description = "VM name"
  default = ""
}

variable "ssh_key_pub" {
  description = "Path to public ssh key"
  default = ""
  sensitive = true
}

variable "ssh_key_priv" {
  description = "Path to private ssh key(in order to connect and run bash commands on the target VM)"
  default = ""
  sensitive = true
}

