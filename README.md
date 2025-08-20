# GCP Infra via Jenkins + Terraform (Local Demo)

This repo lets you run a local Jenkins pipeline that provisions basic GCP infra using Terraform.

### Steps
1. Create GCP Service Account with IAM roles:
   - roles/viewer
   - roles/storage.admin
   - roles/compute.networkAdmin
   - roles/serviceusage.serviceUsageAdmin
2. Download service account key as `gcp-sa-key.json`.
3. Run Jenkins in Docker, install Pipeline + Git + Credentials Binding plugins.
4. Add service account JSON as Jenkins credential ID `gcp-creds`.
5. Create pipeline job pointing to Jenkinsfile. Parameters: PROJECT_ID, REGION, DO_DESTROY.
6. Build with parameters → approve → infra created (VPC, subnet, bucket).
7. To clean up, set DO_DESTROY=true and rebuild.
