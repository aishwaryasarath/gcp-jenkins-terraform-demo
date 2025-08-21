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

<img width="1390" height="850" alt="image" src="https://github.com/user-attachments/assets/e4f14f9c-6055-421d-adcd-5199719c57d2" />

### how to
<img width="830" height="338" alt="image" src="https://github.com/user-attachments/assets/08e83dbd-4b6e-4170-ae89-05b8f0f2ffc5" />

```
cd gcp-jenkins-terraform-demo
git init
git add .
git commit -m "Initial Jenkins GCP Terraform demo"
git branch -M main
git remote add origin https://github.com/<your-username>/gcp-jenkins-terraform-demo.git
git push -u origin main
```
<img width="812" height="317" alt="image" src="https://github.com/user-attachments/assets/b74ff093-cb34-4db5-8bb7-a35fab731178" />
