variable "prefix" {
    description = "Prefix of S3 bucket for global namespace"
    default = "parrable"
}

variable "service_name" {
  description = "Name of the service"
}

variable "expiration_days" {
    description = "Number of days after which S3 deletes objects"
    default = "365"
}
