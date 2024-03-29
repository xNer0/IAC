provider "google" {
  project     = "crucial-matter-418016"
  region      = "YOUR_REGION"
}

resource "google_compute_instance" "apache_instance" {
  name         = "apache-instance"
  machine_type = "n1-standard-1"
  zone         = "YOUR_ZONE"

  boot_disk {
    initialize_params {
      image = "ubuntu-2004-focal-v20220124"
    }
  }

  network_interface {
    network = "default"
    access_config {
      // Include this section to give the instance a public IP address
    }
  }

  metadata_startup_script = <<-EOF
    #!/bin/bash
    apt-get update
    apt-get install -y apache2
    systemctl enable apache2
    systemctl start apache2
  EOF
}

output "instance_ip" {
  value = google_compute_instance.apache_instance.network_interface.0.access_config.0.assigned_nat_ip
}