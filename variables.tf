variable "project" {
  description = "The GCP project to deploy to"
  type        = string
}

variable "region" {
  description = "The GCP region to deploy to"
  type        = string
  default     = "us-west1"
}

variable "zone" {
  description = "The GCP zone to deploy to"
  type        = string
  default     = "us-west1-b"
}

variable "machine_type" {
  description = "The type of machine to create"
  type        = string
  default     = "e2-micro"
}

variable "image" {
  description = "The image to use for the boot disk"
  type        = string
  default     = "debian-cloud/debian-11"
}

variable "public_ssh_key_path" {
  description = "Path to the SSH public key"
  type        = string
}

