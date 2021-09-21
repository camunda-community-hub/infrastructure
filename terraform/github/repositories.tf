locals {
  repositories = {
    camunda = [
      "camunda-bpm-swagger",
      "camunda-external-task-client-spring-boot",
    ],
    camunda-community-hub = [
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
      "camunda-dmn-xlsx",
      "camunda-engine-cassandra",
      "camunda-rest-client-spring-boot",
      "community-hub-release-parent",
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
      "zeebe-worker-java-testutils",
      "kafka-connect-zeebe",
      "bpmn-driven-testing",
      "eze",
    ],
  }
}
data "vault_generic_secret" "camunda_community_hub" {
  path = "secret/common/github.com/actions/camunda-community-hub"
}

data "vault_generic_secret" "github_camunda_app" {
  path = "secret/common/github.com/camunda"
}

data "vault_generic_secret" "github_community_hub_app" {
  path = "secret/common/github.com/camunda-community-hub"
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
