variable "project_name" {
  description = "Prefix used for all Docker resources"
  type        = string
}

variable "network_name" {
  description = "Private internal Docker network for app tiers"
  type        = string
}

variable "db_volume_name" {
  description = "Persistent Docker volume for the database data"
  type        = string
}

# --- Database variables ---
variable "db_image" {
  description = "PostgreSQL image to use"
  type        = string
  default     = "postgres:15"
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_user" {
  description = "Database user"
  type        = string
}

variable "db_password" {
  description = "Database password"
  type        = string
  sensitive   = true
}

variable "db_port" {
  description = "Host port to map Postgres (optional; for local access)"
  type        = number
  default     = 5432
}

# --- Backend variables ---
variable "backend_image" {
  description = "Docker image for the backend API"
  type        = string
}

variable "backend_port" {
  description = "Backend API port exposed on host"
  type        = number
  default     = 5000
}

# --- Frontend variables ---
variable "frontend_image" {
  description = "Docker image for the frontend app"
  type        = string
}

variable "frontend_port" {
  description = "Frontend port exposed on host"
  type        = number
  default     = 3000
}
