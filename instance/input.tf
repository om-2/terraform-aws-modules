## Inputs

# Required (no default specified, will throw plan error)
variable "ami_id" {
  description = "ID of the AMI to launch"
  type = "string"
}

variable "fqdn" {
  description = "FQDN of the new instance. Passed to hostnamectl and used as ec2 Tag"
  type = "string"
}

variable "instance_type" {
  description = "Instance size"
  type = "string"
}

variable "key_name" {
  description = "Initial SSH Key to seed instance with"
  type = "string"
}

variable "subnet_id" {
  description = "Subnet in which to place the new instance"
}

variable "security_group_ids" {
  description = "List of security groups to associate with the instance"
  type = "list"
}

variable "assign_public_ip" {
  description = "Associate a public IP address with instance"
  type = "string"
}

# There's a chicken and egg problem here. To make this instance we require
# another instance with a public IP. But how do we create it?
variable "bastion_host" {
  description = "Bastion hostname to use for provisioning"
}

variable "bastion_user" {
  description = "Username to use for bastion host during provisioning. Key must be in agent"
}


# Optional parameters (default specified, not needed when requiring module)
variable "root_volume_size" {
  description = "Size in GB of root volume (default 20gb)"
  default = "20"
}

variable "ami_user" {
  description = "Default username to use to access instance. Used for provisioning"
  default = "centos"
}

variable "placement_group" {
  description = "Name of placement group where instance is created"
  type = "string"
  default = ""
}

variable "source_dest_check" {
  description = "Enable or disable EC2 source and destination checking of packets"
  default = "true"
}

variable "ebs_optimized" {
  description = "EBS optimized instance"
  default = "false"
}

variable "iam_instance_profile" {
  description = "(Optional) The IAM Instance Profile to launch the instance with."
  default = ""
}
