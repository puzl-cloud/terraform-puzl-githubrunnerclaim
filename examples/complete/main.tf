locals {
  integration_name = "tf-github-integration"
  root_namespace   = "root-c44117ek97c4a1w3jg2h88rqf3cjxcitye4md856g1x8z"
  claim_name       = "tf-github-runner"
}

module "integration" {
  source     = "puzl-cloud/githubactionsintegration/puzl"

  name       = local.integration_name
  namespace  = local.root_namespace

  resources = {
    persistentStorage = {
      cacheRetentionTime = 15
    }
  }
}

module "github_runner_claim" {
  source = "../../"

  name      = local.claim_name
  namespace = module.integration.claim_namespace_ref

  github_runner_claim = {
    jobs = {
      ultimateJobTimeout   = 1800
      waitForDockerOnStart = false
    }
  }
}