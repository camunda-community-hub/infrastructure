terraform {
  required_version = "~> 0.14.7"
  required_providers {
    github = {
      source  = "integrations/github",
      version = "~> 4.5.1"
    }
    vault = {
      source  = "hashicorp/vault",
      version = "~>2.18.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "camunda-infra"

    workspaces {
      name = "community-extensions"
    }
  }
}

provider "vault" {
  add_address_to_env = true
  address            = var.vault_address
  auth_login {
    path = "auth/approle/login"

    parameters = {
      role_id   = var.vault_login_approle_role_id
      secret_id = var.vault_login_approle_secret_id
    }
  }

}

provider "github" {
  alias        = "camunda"
  organization = "camunda"
  token        = data.vault_generic_secret.github_credentials.data["GITHUB_TOKEN"]
}

provider "github" {
  alias        = "camunda_community_hub"
  organization = "camunda-community-hub"
  token        = data.vault_generic_secret.github_credentials.data["GITHUB_TOKEN"]
}
