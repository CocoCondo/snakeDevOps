locals {
  labels = {
    project = "snake-devops"
    managed = "terraform"
  }

  # Archivo estático para Nginx (se monta como bind)
  nginx_index_html = abspath("${path.module}/index.html")
}