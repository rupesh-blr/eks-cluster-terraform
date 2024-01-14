resource "kubernetes_cron_job" "db-backup" {
  metadata {
    name = "store-ebs-snapshot-to-s3"
    namespace = "${var.namespace_names[0]}"
  }
  spec {
    concurrency_policy            = "Replace"
    failed_jobs_history_limit     = 5
    schedule                      = "1 0 * * *"
    starting_deadline_seconds     = 10
    successful_jobs_history_limit = 10
    job_template {
      metadata {}
      spec {
        backoff_limit              = 2
        ttl_seconds_after_finished = 10
        template {
          metadata {}
          spec {
            container {
              name    = "hello"
              image   = "ubuntu:20.04"
              command = ["/bin/sh", "-c", "date; echo Hello from the Kubernetes cluster"]
            }
          }
        }
      }
    }
  }
}

# Note: inside busybox container we are runnning mongo dump command to take dump of db and aws cli command to copy dump in s3 bucket.
# mongodump --username admin --password password --authenticationDatabase admin --host host-endpoint --port 27017 --db DB_name --out .
# aws s3 cp <dump path> s3://<s3-bucket-name>/ --recursive