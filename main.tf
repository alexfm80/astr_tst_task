terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


provider "yandex" {
  zone = var.zone
  cloud_id = var.cloud_id
  folder_id = var.folder_id
  service_account_key_file = var.service_account_key_file 
}


resource "yandex_vpc_address" "my_pub_ip" {
  name = "my_pub_ip"
  folder_id = var.folder_id
  deletion_protection = false
  external_ipv4_address {
    zone_id = var.zone
    
  }
}  


output "public_ip" {
  value = yandex_vpc_address.my_pub_ip.external_ipv4_address[0].address
}

output "instance_public_ip" {
  value = yandex_compute_instance.vm1.network_interface[0].nat_ip_address
}

resource "yandex_compute_instance" "vm1" {
  name = var.vm_name

  resources {
    cores  = 2
    memory = 2
  }


  boot_disk {
    initialize_params {
      image_id = var.image_id 
    }
  }

  network_interface {
    subnet_id = var.subnet_id 
    nat_ip_address = "${yandex_vpc_address.my_pub_ip.external_ipv4_address[0].address}"
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.ssh_key_pub)}" 
  }
  
  provisioner "remote-exec" {
    connection {
      type = "ssh"
      user = "astra"
      private_key = "${file(var.ssh_key_priv)}" 
      host = yandex_compute_instance.vm1.network_interface[0].nat_ip_address     
  }

  
    inline = [ 
      "sudo apt update -y",
      "sudo apt install ansible -y",
      "sudo apt update -y", 
      "sudo apt install git -y",
      "git clone https://github.com/alexfm80/ast-ans.git  ~/ast-ans",
      "sudo ansible-playbook /home/astra/ast-ans/ast_ans.yaml -l localhost"
     ]
   }
}
