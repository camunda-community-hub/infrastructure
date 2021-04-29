locals {
  repositories = {
    camunda = [
      "camunda-bpm-graphql",
      "camunda-bpm-grpc-external-task",
      "camunda-bpm-identity-keycloak",
      "camunda-bpm-platform-osgi",
      "camunda-bpm-swagger",
      "camunda-dmn-xlsx",
      "camunda-external-task-client-spring-boot",
      "infra-github-demo",
    ],
    camunda-community-hub = [
      "camunda-acm-plugin",
      "camunda-bpm-custom-batch",
      "camunda-bpm-junit5",
      "camunda-bpm-mail",
      "camunda-bpm-migration",
      "camunda-bpm-mockito",
      "camunda-bpm-process-test-coverage",
      "camunda-bpm-reactor",
      "camunda-engine-cassandra",
      "camunda-rest-client-spring-boot",
      "dmn-scala",
      "zeebe-process-generator",
      "zeeqs"
    ],
  }
}
data "vault_generic_secret" "camunda_community_hub" {
  path = "secret/common/github.com/actions/camunda-community-hub"
}

data "vault_generic_secret" "github_credentials" {
  path = "secret/common/github.com/camunda"
}

module "community_hub_secrets" {
  source     = "./modules/org_secrets"
  github_org = "camunda-community-hub"
  providers = {
    github = github.camunda_community_hub
  }

  repositories = local.repositories.camunda-community-hub
  secrets      = data.vault_generic_secret.camunda_community_hub.data
}

module "camunda_secrets" {
  source = "./modules/org_secrets"
  providers = {
    github = github.camunda
  }

  github_org   = "camunda"
  repositories = local.repositories.camunda
  secrets      = data.vault_generic_secret.camunda_community_hub.data
}
