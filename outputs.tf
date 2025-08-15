output "internal_network" {
  description = "Name of the private Docker network"
  value       = docker_network.internal.name
}

output "db_volume" {
  description = "Name of the DB data volume"
  value       = docker_volume.db_data.name
}
output "db_container_name" {
  description = "Database container name"
  value       = docker_container.db.name
}

output "db_connection_info" {
  description = "DB connection details (host refers to internal network name for app containers)"
  value = {
    host_internal = docker_container.db.name
    db_name       = var.db_name
    db_user       = var.db_user
    port_internal = 5432
    port_host     = var.db_port
  }
  sensitive = true
}
output "backend_api_url" {
  description = "Backend API endpoint (host URL)"
  value       = "http://localhost:${var.backend_port}"
}
output "frontend_url" {
  description = "Frontend URL (host)"
  value       = "http://localhost:${var.frontend_port}"
}
