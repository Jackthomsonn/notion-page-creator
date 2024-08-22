variable "binary_path" {
  type = string
  description = "Path of compiled binary"
}

variable "src_path" {
  type = string
  description = "Source directory for the lambda"
}

variable "binary_name" {
  type = string
  description = "Name of the final binary"
}

variable "archive_path" {
  type = string
  description = "Path where the final archive will be"
}

variable "function_name" {
  type = string
  description = "The name of the function"
}