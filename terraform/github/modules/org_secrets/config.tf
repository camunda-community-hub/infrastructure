terraform {
  required_version = "~> 1.3.5"
  required_providers {
    github = {
      source  = "integrations/github",
      version = "~> 5.42.0"
    }
  }
}
