output "service_account_email" {
  value       = google_service_account.wi-service-account.email
  description = "The email of the created service account"
}

output "service_account_name" {
  value       = google_service_account.wi-service-account.name
  description = "The name of the created service account"
}
