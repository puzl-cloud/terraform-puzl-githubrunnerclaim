output "job_namespace_ref" {
  value       = try(kubernetes_manifest.githubrunnerclaim.object.spec.runner.jobNamespaceRef, null)
  description = "The namespace where the GitHub Action jobs are executed by this runner."
}
