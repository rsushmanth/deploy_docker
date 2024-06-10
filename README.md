## Project Overview
This project demonstrates the deployment of a Dockerized web application on AWS using Terraform. The infrastructure is designed to ensure high availability and scalability by leveraging AWS services like EC2, Auto Scaling Groups, and Elastic Load Balancers.
Project Components
### 1.Infrastructure as Code (IaC):
* Utilized Terraform to automate the provisioning of the AWS infrastructure.
### 2.VPC Setup:
* Created a Virtual Private Cloud (VPC) with a CIDR block of 10.0.0.0/16.
* Configured public and private subnets within the VPC.
### 3.Networking:
* Configured an Internet Gateway for the VPC to allow internet access.
* Set up route tables and associated them with the subnets to manage traffic.
* Implemented security groups to allow HTTP traffic on port 80.
### 4.IAM Role and Instance Profile:
* Created an IAM role with AmazonEC2FullAccess policy.
* Associated the IAM role with an instance profile for EC2 instances.
### 5.EC2 Instances and Launch Configuration:
* Configured a launch configuration for EC2 instances to use a specified AMI and instance type (t2.micro).
* Included a user data script to install Docker and run the provided Docker image (yeasy/simple-web).
### 6.Auto Scaling Group:
* Set up an Auto Scaling Group with a desired capacity of 2 instances, minimum size of 1, and maximum size of 3.
* Configured health checks and tags for the instances.
### 7.Elastic Load Balancer (ELB):
* Created an ELB to distribute incoming HTTP traffic across the EC2 instances in the Auto Scaling Group.
* Configured health checks to ensure only healthy instances receive traffic.
## Deployment Steps
### 1.Set Up the Project Directory:
* Create a directory for the Terraform project and navigate to it.
### 2.Create and Populate the terraform files:
* Define the entire infrastructure setup in the tf files.
### 3.Initialize Terraform:
* Run terraform init to initialize the project.
### 4.Apply the Terraform Configuration:
* Run terraform apply and confirm the action to deploy the infrastructure.
## Assumptions
* The provided AMI (ami-00beae93a2d981137) is available in the chosen AWS region.
* The Docker image (yeasy/simple-web) is correctly configured and accessible on Docker Hub.
## Troubleshooting
* Instance Not Launching: Verify the AMI ID, instance type, IAM role, and instance profile configuration.
* Docker Not Installed: Check the user data script for correctness and formatting.
* Application Not Accessible: Ensure security group rules allow HTTP traffic on port 80, and check Docker container logs for errors.

_This project showcases the essential components and steps required to deploy a scalable and highly available Dockerized application on AWS using Terraform._
