resource "kubernetes_cron_job" "mongo-backup" {
  metadata {
    name = "mangodb-backup"
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
              name    = "mongodbbackup"
              image   = "public.ecr.aws/p5j3z0i6/mongo:latest"
              command = ["/bin/sh", "-c", "sh /usr/local/bin/script.sh"]
            }
          }
        }
      }
    }
  }
}