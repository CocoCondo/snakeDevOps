# Infraestructura con Terraform + Docker

Este módulo levanta 3 contenedores con Terraform:
- **Nginx** (página estática en `localhost:8080`)
- **notes-api** (build local desde `API-Docker/Dockerfile`, expuesta en `localhost:8081`)
- **snake-app** (build local desde `snake-app/Dockerfile`, expuesta en `localhost:8082`)

Todos conectados a una red Docker dedicada.

---

## 🚀 Requisitos

- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ 1.6
- [Docker Desktop](https://www.docker.com/products/docker-desktop) en ejecución
- Acceso al socket de Docker (`docker ps` debe funcionar)

---

## 📂 Estructura de archivos

```

infra/terraform/
├── backend.tf      # configuración backend remoto (comentado)
├── local.tf        # variables locales (labels, paths)
├── main.tf         # recursos principales (contenedores, imágenes, red)
├── outputs.tf      # outputs de Terraform
├── providers.tf    # configuración de proveedor Docker
├── terraform.tf    # versión y proveedores requeridos
├── variables.tf    # variables parametrizables
└── index.html      # página estática para Nginx (opcional)

````

---

## ▶️ Uso

### 1. Inicializar
```bash
cd infra/terraform
terraform init
````

### 2. Ver plan de ejecución

```bash
terraform plan
```

### 3. Aplicar

```bash
terraform apply -auto-approve
```

Al finalizar:

* Nginx → [http://localhost:8080](http://localhost:8080)
* notes-api → [http://localhost:8081](http://localhost:8081)
* snake-app → [http://localhost:8082](http://localhost:8082)

### 4. Inspeccionar estado

```bash
terraform state list
docker ps
```

### 5. Destruir infraestructura

```bash
terraform destroy -auto-approve
```

---

## ⚙️ Variables principales

| Variable          | Default         | Descripción                  |
| ----------------- | --------------- | ---------------------------- |
| `network_name`    | `devnet`        | Nombre de la red Docker      |
| `nginx_host_port` | `8080`          | Puerto host para Nginx       |
| `notes_host_port` | `8081`          | Puerto host para notes-api   |
| `snake_host_port` | `8082`          | Puerto host para snake-app   |
| `notes_image_tag` | `notes-api:dev` | Tag de imagen para notes-api |
| `snake_image_tag` | `snake-app:dev` | Tag de imagen para snake-app |

---

## 📤 Outputs

| Output          | Ejemplo                 |
| --------------- | ----------------------- |
| `nginx_url`     | `http://localhost:8080` |
| `notes_api_url` | `http://localhost:8081` |
| `snake_app_url` | `http://localhost:8082` |

---

## ☁️ Backend remoto (opcional)

El archivo `backend.tf` ya está preparado para usar S3 + DynamoDB en AWS.
Para activarlo:

1. Configura bucket, región y tabla DynamoDB.
2. Descomenta el bloque en `backend.tf`.
3. Ejecuta:

   ```bash
   terraform init -migrate-state
   ```

---
