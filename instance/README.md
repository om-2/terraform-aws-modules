# Instance

## Required Inputs
 - ami_id
 - fqdn
 - instance_type
 - key_name
 - subnet_id
 - security_group_ids
 - assign_public_ip

This is a work in progress. It's cribbed from a private terraform modules repository I maintain and the code is based on
a private instance module. There is also a public instance module. I want to combine both of them with some conditional
logic to provision with the appropriate method (via a bastion host or not).

It is build and tested with CentOS 7. Amazon Linux should work. Ubuntu will not work without changing the default
username.


## TODO
 - Implement CentOS7 region->AMI map for selection of default AMI
 - Better handle conditional public/private provisioning
