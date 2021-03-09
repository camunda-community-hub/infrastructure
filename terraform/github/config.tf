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
  address            = var.vault_address
  add_address_to_env = true
}


data "vault_generic_secret" "camunda_community_hub" {
  path = "secret/common/github.com/actions/camunda-community-hub"
}

data "vault_generic_secret" "github_credentials" {
  path = "secret/common/github.com/camunda"
}

module "community_hub_secrets" {
  source = "./modules/org_secrets"

  github_org   = "camunda-community-hub"
  github_token = data.vault_generic_secret.github_credentials.data["GITHUB_TOKEN"]
  repositories = ["template-repo"]
  secrets      = data.vault_generic_secret.camunda_community_hub.data
}

module "camunda_secrets" {
  source = "./modules/org_secrets"

  github_org   = "camunda"
  github_token = data.vault_generic_secret.github_credentials.data["GITHUB_TOKEN"]
  repositories = [
    "camunda-acm-plugin",
    "camunda-bpm-custom-batch",
    "camunda-bpm-graphql",
    "camunda-bpm-grpc-external-task",
    "camunda-bpm-identity-keycloak",
    "camunda-bpm-junit5",
    "camunda-bpm-mail",
    "camunda-bpm-migration",
    "camunda-bpm-mockito",
    "camunda-bpm-platform-osgi",
    "camunda-bpm-process-test-coverage",
    "camunda-bpm-reactor",
    "camunda-bpm-swagger",
    "camunda-bpm-wildfly-swarm",
    "camunda-dmn-xlsx",
    "camunda-engine-cassandra",
    "camunda-external-task-client-spring-boot",
    "camunda-rest-client-spring-boot",
    "cloud-connect-modeler-plugin",
    "dmn-scala",
    "et",
    "iam",
    "infra-github-demo",
  ]
  secrets = data.vault_generic_secret.camunda_community_hub.data
}
