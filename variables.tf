variable "key_name" {
  type        = string
  description = "The name for ssh key, used for aws_launch_configuration"
  default     = "nimble-key"
}

variable "cluster_name" {
  type        = string
  description = "The name of AWS ECS cluster"
  default     = "nimble-cluster"
}

variable "az_count" {
  default     = "2"
  description = "number of availability zones in above region"
}

variable "aws_region" {
  default     = "us-east-2"
  description = "aws region where our resources going to create choose"
  #replace the region as suits for your requirement
}

variable "app_count" {
  default     = "2" #choose 2 bcz i have choosen 2 AZ
  description = "numer of docker containers to run"
}