variable "project" {
  type        = string
  description = "The project that this service account should be created in"
}

variable "namespace" {
  type        = string
  description = "Kubernetes namespace of the service account to grant permissions to"
}

variable "service_account" {
  type        = string
  description = "Kubernetes service account to grant permissions to"
}

variable "roles" {
  type        = list(string)
  description = "List of roles to grant to the service account"
}
