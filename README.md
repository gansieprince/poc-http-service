# My Project
# AWS Three-Tier Architecture with ECS, ALB, RDS, and SQS

This project provisions a secure, scalable three-tier AWS infrastructure using Terraform. It includes a VPC with public and private subnets, ECS Fargate tasks, an Application Load Balancer (ALB), NAT Gateway, RDS PostgreSQL database, and integrations with DynamoDB, Amazon SQS, and ECR.

---

## 📐 Architecture Overview

### 🏗️ VPC and Subnets
- **VPC** with 4 subnets:
  - 2 **Public Subnets**: For the Application Load Balancer, NAT Gateway, and ECS tasks.
  - 2 **Private Subnets**: For RDS PostgreSQL and internal routing.

### 🌐 Networking
- **Internet Gateway (IGW)** attached to the VPC for outbound internet access from public subnets.
- **NAT Gateway** deployed in a public subnet to allow private subnets to reach the internet securely.
- **Route Tables**:
  - Public route table routes `0.0.0.0/0` traffic to the Internet Gateway.
  - Private route table routes `0.0.0.0/0` to the NAT Gateway.

### ⚙️ Load Balancing
- **Application Load Balancer (ALB)** deployed in public subnets to handle external traffic.
- Routes incoming HTTP requests to an ECS **Target Group**.

### 🐳 ECS Fargate Service
- ECS service runs **Fargate tasks** in public subnets.
- Tasks are configured with **least-privilege IAM roles** to:
  - Pull container images from **Amazon ECR**.
  - Read/write session or metadata from **DynamoDB**.
  - Communicate with **Amazon SQS** for asynchronous processing.

### 🛢️ RDS Database
- **Amazon RDS PostgreSQL** deployed in private subnets.
- Secured via **security groups**, allowing access only from ECS tasks in public subnets on port `5432`.

---

## 🔒 Security
- ECS tasks and RDS use tightly-scoped **IAM roles** and **security groups** to enforce the principle of least privilege.
- All traffic is segmented by subnet and routing logic to control data flow.

---

## 🚀 Usage
Provision with Terraform:

```bash
terraform init
terraform plan
terraform apply
