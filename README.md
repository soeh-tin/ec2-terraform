# 🚀 Deploy AWS EC2 Instance with Terraform

This project demonstrates how to deploy an **AWS EC2 instance** using **Terraform**.  
It includes creating a key pair, a security group, and launching an EC2 instance in AWS.

---

## 📋 Prerequisites

- [Terraform](https://youtu.be/12p3s0gtN_U) installed
- [AWS CLI](https://youtu.be/A1wZ3DeKX8g) installed
- [TeraTerm](https://youtu.be/CyiuLCB2SBU) installed
- AWS credentials configured with `aws configure`
- IAM user with **EC2 permissions** (`AmazonEC2FullAccess`)

---

## ⚙️ Configuration

The `main.tf` file contains:

- **AWS Provider** configuration (region)  
- **TLS Private Key** resource (generates a new SSH key pair)  
- **AWS Key Pair** resource (uploads public key to AWS)  
- **Local File** resource (saves private key as `ec2-one-key-pair.pem`)
- **Security Group** allowing SSH (port 22)  
- **EC2 Instance** using Amazon Linux 2023 

Update the following before running:
- `region` → your preferred AWS region  
- `ami` → valid AMI ID for your region  
- `public_key` path → change your folder path in your local PC.

---

## 🚀 Deployment Steps

**Step 1: Initialize Terraform**

```
terraform init
```

**Step 2: Preview Infrastructure**

```
terraform plan
```

**Step 3: Apply Changes**

```
terraform apply
```
Type yes when prompted.

## ⚙️ Clean Up (optional if you wanna remain the following configurations.)

**To remove all created resources:**

```
terraform destroy
```