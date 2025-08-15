# Project settings
project_name   = "vulnscan"
network_name   = "vulnscan-net"
db_volume_name = "vulnscan-db-data"

# Database settings
db_image    = "postgres:15"
db_name     = "vulnscan_db"
db_user     = "vulnuser"
db_password = "mr.looser37"
db_port     = 5432

# Backend settings
backend_image = "vulnscanner-backend:latest"  # corrected
backend_port  = 5000

# Frontend settings
frontend_image = "vulnscan-frontend:latest"
frontend_port  = 3000
