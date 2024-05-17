resource "google_compute_instance" "default" {
  name         = "terraform-instance"
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  metadata = {
    ssh-keys = "your-username:${file(var.public_ssh_key_path)}"
  }
}

resource "google_compute_firewall" "allow-ssh" {
  name    = "allow-ssh"
  network = "default"

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

output "instance_ip" {
  value = google_compute_instance.default.network_interface.0.access_config.0.nat_ip
}

