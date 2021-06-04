locals {
  repositories = {
    camunda = [
      "camunda-bpm-grpc-external-task",
      "camunda-bpm-swagger",
      "camunda-dmn-xlsx",
      "camunda-external-task-client-spring-boot",
      "infra-github-demo",
    ],
    camunda-community-hub = [
      "camunda-acm-plugin",
      "camunda-bpm-custom-batch",
      "camunda-bpm-graphql",
      "camunda-bpm-identity-keycloak",
      "camunda-bpm-junit5",
      "camunda-bpm-mail",
      "camunda-bpm-migration",
      "camunda-bpm-mockito",
      "camunda-bpm-platform-osgi",
      "camunda-bpm-process-test-coverage",
      "camunda-bpm-reactor",
      "camunda-engine-cassandra",
      "camunda-rest-client-spring-boot",
      "dmn-scala",
      "zeebe-process-generator",
      "zeeqs",
      "camunda-bpm-assert-scenario",
      "zeebe-exporter-protobuf",
      "zeebe-test-container",
      "zeebe-protocol-immutables",
      "zeebe-kafka-exporter",
      "zeebe-debug-exporter",
      "zeebe-simple-monitor",
      "zeebe-hazelcast-exporter",
      "zeebe-simple-tasklist",
      "bpmn-spec",
      "zeebe-http-worker",
      "zeebe-script-worker",
      "zeebe-dmn-worker",
      "zeebe-worker-java-testutils"
      "camunda-modeler-plugin-usertask-generatedform-preview"
      "pmn-js-plugin-rename-technical-ids"
      "bpmn-js-plugin-reduced-palette"
      "bpmn-js-plugin-color-picker"
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
