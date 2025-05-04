variable "vpc-cidr" {
  default = "10.0.0.0/16"
}

variable "public-subnet" {
  default = "10.0.0.0/24"
}

variable "private-subnet" {
  default = "10.0.1.0/24"
}

variable "igw-cidr" {
  default = "0.0.0.0/0"
}

variable "nat-cidr" {
  default = "0.0.0.0/0"
}