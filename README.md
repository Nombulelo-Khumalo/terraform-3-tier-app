### Terraform 3-tier app project:

```markdown
# Terraform 3-Tier Application

This Terraform project provisions a 3-tier application architecture on AWS. It includes a VPC, subnets, security groups, EC2 instances, an Application Load Balancer (ALB), an Auto Scaling Group (ASG), and a PostgreSQL RDS instance.

## Architecture Overview

The architecture consists of:

1. **Presentation Layer**: ALB distributing incoming traffic to EC2 instances.
2. **Application Layer**: EC2 instances running the application behind an Auto Scaling Group.
3. **Data Layer**: PostgreSQL RDS instance for data storage.

## Prerequisites

- Terraform >= 1.0
- AWS CLI configured with appropriate permissions
- AWS account

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/Nombulelo-Khumalo/terraform-3-tier-app.git
cd terraform-3-tier-app
```

### 2. Configure Terraform Variables

Create a `terraform.tfvars` file with the following variables:

```hcl
db_instance_class = "db.t3.micro"
db_name           = "appdb"
db_username       = "your_db_username"
db_password       = "your_secure_password"
```

Ensure sensitive values like `db_password` are securely managed.

### 3. Initialize Terraform

```bash
terraform init
```

### 4. Plan Terraform Deployment

```bash
terraform plan
```

Review the plan output to ensure resources will be created as expected.

### 5. Apply Terraform Configuration

```bash
terraform apply
```

Type `yes` to confirm resource creation.

### 6. Destroy Terraform Resources

When the infrastructure is no longer needed:

```bash
terraform destroy
```

## Project Structure

- `main.tf` – Terraform provider configuration.
- `vpc.tf` – VPC, subnets, route tables, and gateway resources.
- `ec2.tf` – EC2 launch template and Auto Scaling Group configuration.
- `alb.tf` – Application Load Balancer and target group setup.
- `rds.tf` – RDS PostgreSQL instance and subnet group configuration.
- `outputs.tf` – Output important information like ALB DNS name.
- `variables.tf` – Input variables for the project.

## Outputs

- **ALB DNS Name**: The DNS name of the Application Load Balancer.

## Troubleshooting

- Ensure AWS credentials are correctly set up and have necessary permissions.
- Verify AWS region settings if encountering resource availability issues.
- Check Terraform and AWS CLI versions for compatibility.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Contributing

Contributions are welcome! Please submit a pull request or open an issue for improvements or bugs.

---

Created with ❤️ by Nombulelo Khumalo
```

Feel free to customize any sections to better reflect your project or personal style! Would you like to add or modify any details?
