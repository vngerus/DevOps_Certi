terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "2.22.0"
    }
  }
}

provider "docker" {
  host = "npipe:////./pipe/docker_engine" # Usa npipe en Windows
}

resource "docker_image" "my_app_image" {
  name = "myapp:latest"
  build {
    path      = "."          # Asegúrate de que el contexto esté apuntando al directorio correcto
    dockerfile = "Dockerfile" # Nombre del archivo Dockerfile
    remove     = true         # Eliminar imágenes intermedias
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
