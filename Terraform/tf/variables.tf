variable "app_name" {
  type    = string
  default = "miapp"
}

variable "app_port" {
  type    = number
  default = 8000
}

variable "host_port" {
  type    = number
  default = 5000
}

variable "image_tag" {
  type    = string
  default = "miapp:latest"
}
