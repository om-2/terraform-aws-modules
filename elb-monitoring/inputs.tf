variable "elb_name" {
    description = "Name of ELB to monitor"
}

variable "snslog_topic" {
    description = "topic output of the snslog module"
    type = "map"
}

variable "healthy_host_warn" {
    description = "Send a warning when we reach this number of healthy backends"
    default = "2"
}

variable "healthy_host_crit" {
    description = "Send a critical when we reach this number of healthy backends"
    default = "1"
}

variable "unhealthy_host_warn" {
    description = "Send a warning when this number of backends are unhealthy"
    default = "1"
}

variable "unhealthy_host_crit" {
    description = "Send a critical when this number of backends are unhealthy"
    default = "2"
}

variable "latency_max_warn" {
    description = "Warn when max latency is >="
    default = "30" # Default ELB timeout
}

variable "latency_max_crit" {
    description = "Crit when max latency is >="
    default = "60"
}

variable "latency_p99_warn" {
    description = "Warn when p99 latency is >="
    default = "0.3"
}

variable "latency_p99_crit" {
    description = "Crit when p99 latency is >="
    default = "0.5"
}

variable "latency_p95_warn" {
    description = "Warn when p95 latency is >="
    default = "0.2"
}

variable "latency_p95_crit" {
    description = "Crit when p95 latency is >="
    default = "0.1"
}
