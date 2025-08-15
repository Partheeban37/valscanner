provider "docker" {
  host = "unix:///var/run/docker.sock" # Linux/macOS default
  # On Windows with Docker Desktop, comment the above and use:
  # host = "npipe:////./pipe/docker_engine"
}
