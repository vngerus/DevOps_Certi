terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine"  # Conexión a Docker en Windows a través de npipe
}

resource "docker_image" "my_app_image" {
  name = "myapp:latest"
  build {
    dockerfile = "Dockerfile"
    path       = "/mnt/c/Archivos/Proyectos/DevOps/myapp"  # Ruta correcta en WSL 2
    remove     = true
    tag        = []
  }
}

resource "docker_container" "my_app_container" {
  name  = "myapp-container"
  image = docker_image.my_app_image.name
  ports {
    internal = 8081
    external = 8081
  }
}
