output "vpc_name" { value = google_compute_network.vpc.name }
output "subnet_name" { value = google_compute_subnetwork.subnet.name }
output "bucket_name" { value = google_storage_bucket.bucket.name }
