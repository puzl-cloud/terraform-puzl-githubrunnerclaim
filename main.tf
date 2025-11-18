resource "kubernetes_manifest" "githubrunnerclaim" {
  manifest = {
    apiVersion = "github-actions.svcs.puzl.cloud/v1"
    kind       = "GitHubRunnerClaim"
    metadata = {
      name      = var.name
      namespace = var.namespace
    }
    spec = {
      jobProvider = {
        baseLabel   = var.github_runner_claim.jobProvider.baseLabel
        extraLabels = var.github_runner_claim.jobProvider.extraLabels
      }
      jobs = {
        ultimateJobTimeout           = try(var.github_runner_claim.jobs.ultimateJobTimeout, null)
        waitForDockerOnStart         = try(var.github_runner_claim.jobs.waitForDockerOnStart, true)
        customImage                  = try(var.github_runner_claim.jobs.customImage, null)
        runnerDirectory              = try(var.github_runner_claim.jobs.runnerDirectory, null)
        sharedPersistentMountPoints  = try(var.github_runner_claim.jobs.sharedPersistentMountPoints, [])
      }
    }
  }

  computed_fields = ["spec.jobProvider", "spec.jobs", "spec.runner"]

  wait {
    fields = {
      "status.phase" = "Ready"
    }
  }

  timeouts {
    create = "5m"
    update = "5m"
    delete = "5m"
  }
}