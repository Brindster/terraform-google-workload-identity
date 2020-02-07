locals {
  roles_map = zipmap(
    var.roles,
    [for role in var.roles : {}]
  )
}

resource "random_string" "sa_account_suffix" {
  upper   = false
  lower   = true
  special = false
  length  = 4
}

resource "google_service_account" "wi-service-account" {
  account_id   = "wi-${substr("${var.namespace}-${var.service_account}", 0, 22)}-${random_string.sa_account_suffix.result}"
  display_name = "Workload Identity service account [${var.namespace}/${var.service_account}]"
  description  = "Terraform managed service account granting permissions to the Kubernetes service account ${var.service_account} in the ${var.namespace} namespace via Workload Identity"
}

resource "google_service_account_iam_binding" "wi-service-account-binding" {
  service_account_id = google_service_account.wi-service-account.name
  role               = "roles/iam.workloadIdentityUser"

  members = [
    "serviceAccount:${var.project}.svc.id.goog[${var.namespace}/${var.service_account}]"
  ]
}

resource "google_project_iam_member" "wi-service-account-role" {
  for_each = local.roles_map

  role   = each.key
  member = "serviceAccount:${google_service_account.wi-service-account.email}"
}
