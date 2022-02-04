terraform {
  required_version = "~> 1.1.5"
  required_providers {
    github = {
      source  = "integrations/github"
      version = "~> 4.14.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 2.23.0"
    }
  }

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "camunda-infra"

    workspaces {
      name = "camunda-community-hub-repo-management"
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
  alias = "camunda"
  owner = "camunda"
  # Github app: https://github.com/organizations/camunda/settings/apps/infra-team-terraform
  app_auth {
    id              = data.vault_generic_secret.github_camunda_app.data["GITHUB_APP_ID"]
    installation_id = data.vault_generic_secret.github_camunda_app.data["GITHUB_APP_INSTALLATION_ID"]
    pem_file        = data.vault_generic_secret.github_camunda_app.data["GITHUB_APP_PEM_FILE_CONTENT"]
  }
}

provider "github" {
  alias = "camunda_community_hub"
  owner = "camunda-community-hub"
  # Github app: https://github.com/organizations/camunda-community-hub/settings/apps/infrastructure-terraform
  app_auth {
    id              = data.vault_generic_secret.github_community_hub_app.data["GITHUB_APP_ID"]
    installation_id = data.vault_generic_secret.github_community_hub_app.data["GITHUB_APP_INSTALLATION_ID"]
    pem_file        = data.vault_generic_secret.github_community_hub_app.data["GITHUB_APP_PEM_FILE_CONTENT"]
  }
}
