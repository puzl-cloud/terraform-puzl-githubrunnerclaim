variable "github_runner_claim" {
  description = "Configuration for GitHub runner claim"

  type = object({
    jobProvider = optional(object({
      baseLabel   = optional(string, "puzl-any")
      extraLabels = optional(list(string), [])
    }), {
      baseLabel   = "puzl-any"
      extraLabels = []
    })

    jobs = optional(object({
      ultimateJobTimeout          = optional(number)
      waitForDockerOnStart        = optional(bool)
      customImage                 = optional(string)
      runnerDirectory             = optional(string)
      sharedPersistentMountPoints = optional(list(string))
    }))
  })

  # baseLabel ENUM
  validation {
    condition = contains(
      [
        "puzl-any",
        "puzl-ubuntu-22.04",
        "puzl-ubuntu-24.04",
        "puzl-ubuntu-latest",
        "puzl-custom-image"
      ],
      var.github_runner_claim.jobProvider.baseLabel
    )
    error_message = "jobProvider.baseLabel must be one of: puzl-any, puzl-ubuntu-22.04, puzl-ubuntu-24.04, puzl-ubuntu-latest, puzl-custom-image."
  }

  # extraLabels only if baseLabel != puzl-any
  validation {
    condition = (
      var.github_runner_claim.jobProvider.baseLabel == "puzl-any"
      ? length(var.github_runner_claim.jobProvider.extraLabels) == 0
      : true
    )
    error_message = "extraLabels may only be set when baseLabel != puzl-any."
  }

  # customImage → runnerDirectory required
  validation {
    condition = (
      var.github_runner_claim.jobs == null
      || var.github_runner_claim.jobs.customImage == null
      || (
        var.github_runner_claim.jobs.customImage != null
        && var.github_runner_claim.jobs.runnerDirectory != null
      )
    )
    error_message = "runnerDirectory must be specified when using a customImage."
  }

  # runnerDirectory only allowed when customImage is set
  validation {
    condition = (
      var.github_runner_claim.jobs == null
      || var.github_runner_claim.jobs.runnerDirectory == null
      || (
        var.github_runner_claim.jobs.runnerDirectory != null
        && var.github_runner_claim.jobs.customImage != null
      )
    )
    error_message = "runnerDirectory should only be used together with customImage."
  }

  # customImage + runnerDirectory only allowed when baseLabel = puzl-custom-image
  validation {
    condition = (
      var.github_runner_claim.jobs == null
      || var.github_runner_claim.jobProvider.baseLabel == "puzl-custom-image"
      || (
        var.github_runner_claim.jobs.customImage == null
        && var.github_runner_claim.jobs.runnerDirectory == null
      )
    )
    error_message = "customImage and runnerDirectory may only be set when baseLabel = puzl-custom-image."
  }
}

variable "name" {
  description = "The name for the GitHubRunnerClaim resource."
  type        = string
}

variable "namespace" {
  description = "Reference to the namespace for GitHubRunnerClaim resources"
  type        = string
}