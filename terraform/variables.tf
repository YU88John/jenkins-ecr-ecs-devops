variable "ami_id" {
    type = string
    description = "The AMI ID to use for servers"
    default = "ami-0fa1ca9559f1892ec"
}

variable "instance_size" {
    type = string
    description = "The instance type to use for servers"
    default = "t2.medium"
}



