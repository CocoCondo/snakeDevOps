provider "docker" {
  # Con el socket montado, no hace falta DOCKER_HOST.
  # Si lo necesitás (entorno raro), podrías setear env DOCKER_HOST.
}

# Red "tipo VPC" para aislar
resource "docker_network" "app_net" {
  name = "${var.app_name}-net"
}

# Construye la imagen desde la raíz del repo (usa Dockerfile)
resource "docker_image" "app_image" {
  name = var.image_tag
  build {
    # Contexto EXACTO donde están Dockerfile y requirements.txt
    context    = abspath("${path.module}/../app")
    dockerfile = "Dockerfile"
  }
}


# Contenedor de la app
resource "docker_container" "app" {
  name  = var.app_name
  image = docker_image.app_image.image_id

  networks_advanced {
    name = docker_network.app_net.name
  }

volumes {
    host_path      = abspath("${path.module}/../app/data")
    container_path = "/app/data"
    read_only      = false
}

  # Exponer puerto (host → contenedor)
  ports {
    internal = var.app_port
    external = var.host_port
  }

  # Ejemplo de variables de entorno
  env = [
    "PYTHONDONTWRITEBYTECODE=1",
    "PYTHONUNBUFFERED=1",
  ]

  # Opcional: healthcheck simple
  healthcheck {
    test     = ["CMD", "wget", "-qO-", "http://localhost:${var.app_port}/"]
    interval = "10s"
    timeout  = "2s"
    retries  = 5
  }

  # Auto-restart si se cae
  restart = "unless-stopped"
}