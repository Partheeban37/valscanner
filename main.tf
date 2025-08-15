# Docker Network
resource "docker_network" "internal" {
  name = "vulnscan-net"
}

# Docker Volume for DB
resource "docker_volume" "db_data" {
  name = "vulnscan-db-data"
}

# Postgres Database Container
resource "docker_container" "db" {
  name  = "vulnscan-db"
  image = "postgres:15"

  networks_advanced {
    name = docker_network.internal.name
  }

  volumes {
    container_path = "/var/lib/postgresql/data"
    volume_name    = docker_volume.db_data.name
  }

  env = [
    "POSTGRES_USER=${var.db_user}",
    "POSTGRES_PASSWORD=${var.db_password}",
    "POSTGRES_DB=${var.db_name}"
  ]

  ports {
    internal = 5432
    external = 5432
  }
}

# Backend Container
resource "docker_container" "backend" {
  name  = "vulnscan-backend"
  image = "vulnscanner-backend:latest"

  networks_advanced {
    name = docker_network.internal.name
  }

  ports {
    internal = 5000  # <-- matches Flask app
    external = 5000
  }

  env = [
    "DB_HOST=${docker_container.db.name}",
    "DB_PORT=5432",
    "DB_USER=${var.db_user}",
    "DB_PASSWORD=${var.db_password}",
    "DB_NAME=${var.db_name}"
  ]

  depends_on = [docker_container.db]  # ensure DB starts first
}

# Frontend Container
resource "docker_container" "frontend" {
  name  = "vulnscan-frontend"
  image = "vulnscan-frontend:latest"

  networks_advanced {
    name = docker_network.internal.name
  }

  ports {
    internal = 3000
    external = 3000
  }

  depends_on = [docker_container.backend]  # ensure backend starts first
}
