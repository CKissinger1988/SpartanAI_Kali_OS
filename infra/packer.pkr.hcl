packer {
  required_plugins {
    ansible = {
      version = "~> 1"
      source  = "github.com/hashicorp/ansible"
    }
  }
}

source "qemu" "hardened_kali" {
  iso_url      = "kali-linux-live.iso"
  iso_checksum = "file:kali-checksum.txt"
  output_directory = "output-kali"
  shutdown_command = "echo 'packer' | sudo -S shutdown -P now"
  ssh_username     = "kali"
  ssh_password     = "kali"
  ssh_timeout      = "20m"
}

build {
  sources = ["source.qemu.hardened_kali"]
  
  provisioner "ansible" {
    playbook_file = "./playbook.yml"
  }
}
