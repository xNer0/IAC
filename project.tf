resource "google_compute_network" "my_network" {
  name = "my-network"
}

resource "google_compute_subnetwork" "my_subnetwork" {
  name          = "my-subnetwork"
  region        = "us-west1-b"
  network       = google_compute_network.my_network.self_link
  ip_cidr_range = "10.0.1.0/24"
}

resource "google_compute_instance" "my_instance" {
  name         = "my-instance"
  machine_type = "e2-micro"
  zone         = "your_zone"
  tags         = ["http-server", "ssh-server"]

  boot_disk {
    initialize_params {
      image = "your_image"
    }
  }

  network_interface {
    subnetwork = google_compute_subnetwork.my_subnetwork.self_link
    access_config {
      // Using a fixed public IP
      nat_ip = "your_static_ip_address"
    }
  }

  scheduling {
    preemptible = true
  }

  service_account {
    email  = "your_service_account_email@your_project_id.iam.gserviceaccount.com"
    scopes = ["cloud-platform"]
  }
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "allow_ssh" {
  name    = "allow-ssh"
  network = google_compute_network.my_network.name

  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

# Activer les API nécessaires
resource "google_project_service" "compute" {
  service = "compute.googleapis.com"
}

resource "google_project_service" "cloudresourcemanager" {
  service = "cloudresourcemanager.googleapis.com"
}

resource "google_project_service" "servicenetworking" {
  service = "servicenetworking.googleapis.com"
}

resource "google_project_service" "iam" {
  service = "iam.googleapis.com"
}

# Ajoutez d'autres services selon vos besoins
