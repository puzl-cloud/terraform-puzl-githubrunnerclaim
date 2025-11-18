terraform {
  required_version = ">= 1.3.0"

  required_providers {
    kubernetes = {
      source  = "puzl-cloud/kubernetes"
      version = "2.38.0"
    }
  }
}
