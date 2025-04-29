variable "app_name" {
  description = "application name"
  type        = string
  default     = "todoapp"
}

variable "location" {
  description = "location"
  type        = string
  default     = "Japan East"
}

variable "subscription_id" {
  type = string
}

variable "vm_size" {
  description = "仮想マシンのサイズ"
  type        = string
  default     = "Standard_B1s"
}

variable "admin_username" {
  description = "VMの管理者ユーザー名"
  type        = string
  default     = "adminuser"
}

variable "vm_name" {
  description = "仮想マシン名"
  type        = string
  default     = "web-server"
}
