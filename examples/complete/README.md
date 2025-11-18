# Example Usage of puzl.cloud module for GitHub Runner Claim

This example demonstrates how to use Puzl's modules for GitHub runner orchestration within the integration.

## Usage

### Apply

1. Create credetials in your Puzl dashboard https://console.puzl.cloud.
2. Update the `main.tf` file with your specific details, such as GitHub settings and your Puzl root namespace name.
3. Set `KUBE_HOST` and `KUBE_TOKEN` environment variables.
4. Initialize the Terraform environment:

```bash
terraform init
terraform plan
```

5. Apply the Terraform configuration:

```bash
terraform apply
```

## Cleanup

To remove the deployed resources, run:

```bash
terraform destroy
```
