terraform {
  required_providers {
    harness = {
      source  = "harness/harness"
      version = "~> 0.14"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9.1"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.4.3"
    }
  }
}
