# puzl.cloud Terraform module for GitHub Runner Claim

## Overview

This Terraform module is a way of requesting a GitHub runner within [Cloud Pipelines Service](https://puzl.cloud/products/run-my-job) by Puzl.

`GitHubRunnerClaim` resources can be created only in the Claim Namespace created by `GitHubActionsIntegration`, which is used to provide isolation between GitHub runners of different organization units. Administrator (owner of Puzl account) always has full permissions on all `GitHubRunnerClaim` resources within the Puzl account. The detailed description of the fields used in this module can be found in the related [GitHub Runner Claim documentation](https://docs.puzl.cloud/api/run-my-job/github-actions/github-runner-claim).

## Features

- Management of GitHub Runner Claims.
- Support for custom GitHub Runner docker images.
- Configurable shared persistent storage across jobs.

## Requirements

- Terraform v1.3.0 or higher.
- [Puzl kubernetes provider](https://registry.terraform.io/providers/puzl-cloud/kubernetes) v2.38.0 or higher.
- Puzl application installed in your GitHub organization(s).

## Usage

To use this module in your Terraform environment, add the following configuration:

```hcl
locals {
  integration_name = "github-team-integration"
  root_namespace   = "root-cysexkwsk57xtlabdkyn3zpybzslt2l7frtwj5arfodtz"
  claim_name       = "github-runner"
}

module "integration" {
  source     = "puzl-cloud/githubactionsintegration/puzl"

  name       = local.integration_name
  namespace  = local.root_namespace
  github_url = local.github_url
}

module "github_runner_claim" {
  source = "puzl-cloud/githubrunnerclaim/puzl"

  name      = local.claim_name
  namespace = module.integration.claim_namespace_ref

  github_runner_claim = {
    jobs = {
      waitForDockerOnStart         = true
      ultimateJobTimeout           = 3600
    }
  }
}
```
