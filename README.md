# DevOps Terraform Project

This repository contains:
- Terraform infrastructure code to create AWS EC2 instances and a security group.
- A simple Node.js backend service.
- A Jenkins pipeline to provision infrastructure and run a backend smoke test.

## Project Structure

- `Terraform/` - Terraform configuration files.
- `backend/` - Node.js Express backend.
- `Jenkinsfile` - CI/CD pipeline definition.

## Prerequisites

### Local machine
- Git
- Node.js 18+ and npm
- Terraform 1.x
- AWS account and credentials configured (for example via `aws configure`)

### Jenkins agent
- Linux agent with shell support (`sh`), `git`, `terraform`, `node`, `npm`, and `curl` available in PATH.
- Pipeline plugins installed:
  - Pipeline
  - Pipeline: Groovy
  - Pipeline: Stage Step
  - Pipeline: Declarative
  - Pipeline: Declarative Extension Points API

## Terraform Configuration

Terraform files are in `Terraform/`.

Current variables in `Terraform/terraform.tfvars`:
- `region`
- `instance_type`
- `instance_count`
- `ami_id`
- `project_name`
- `environment`
- `allowed_ssh_cidr`

Outputs:
- `instance_ips`
- `instance_ip`

### Run Terraform locally

```bash
cd Terraform
terraform init
terraform plan
terraform apply -auto-approve
```

To destroy resources:

```bash
terraform destroy -auto-approve
```

## Backend Service

The backend is in `backend/` and uses Express.

### Run backend locally

```bash
cd backend
npm ci
npm start
```

Health endpoint:
- `GET /` -> confirms service is running.

## Jenkins Pipeline

`Jenkinsfile` stages:
1. Checkout
2. Terraform Init
3. Terraform Plan
4. Terraform Apply
5. Install backend
6. Smoke test backend

### Jenkins job configuration

Use a **Pipeline** job with:
- Definition: `Pipeline script from SCM`
- SCM: `Git`
- Repository URL: your GitHub repository URL
- Branch Specifier: `*/main`
- Script Path: `Jenkinsfile`

Then run **Build Now**.

## Troubleshooting

### Pipeline shows only Start/End with no stages
Check the following:
- You are building the correct job/branch.
- `Script Path` is exactly `Jenkinsfile`.
- Declarative Pipeline plugins are installed and enabled.
- No shared library global variable named `pipeline` is shadowing declarative syntax.

### Terraform command not found
Install Terraform on local machine or Jenkins agent and ensure it is available in PATH.

### Git tool warning in Jenkins
If you see "Selected Git installation does not exist. Using Default", configure a valid Git installation in Jenkins global tools.

## Security Notes

- `.env` and `.env.*` are ignored by `.gitignore`.
- `node_modules/` is ignored by `.gitignore`.
- If secrets were previously committed, rotate them and clean git history if required.
