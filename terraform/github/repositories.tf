locals {
  repositories = {
    camunda = [
      "dmn-scala",
    ],
    camunda-community-hub = [
      "bpmn-driven-testing",
      "bpmn-spec",
      "camunda-bpm-assert-scenario",
      "camunda-bpm-camel",
      "camunda-bpm-custom-batch",
      "camunda-bpm-graphql",
      "camunda-bpm-grpc-external-task",
      "camunda-bpm-identity-keycloak",
      "camunda-bpm-migration",
      "camunda-bpm-platform-osgi",
      "camunda-bpm-process-test-coverage",
      "camunda-cloud-benchmark",
      "camunda-dmn-xlsx",
      "camunda-engine-rest-client-java",
      "camunda-google-ws-java",
      "camunda-operate-client-java",
      "camunda-platform-7-mail",
      "camunda-platform-7-mockito",
      "camunda-platform-7-rest-client-spring-boot",
      "camunda-platform-graphql",
      "camunda-platform-to-cloud-migration",
      "camunda-tasklist-client-java",
      "community-hub-release-parent",
      "eze",
      "kafka-connect-zeebe",
      "kotlin-coworker",
      "spring-zeebe",
      "thymeleaf-feel",
      "zebee-cherry-filestorage",
      "zeebe-cherry-framework",
      "zeebe-cloudevents-router",
      "zeebe-debug-exporter",
      "zeebe-dmn-worker",
      "zeebe-embedded-job-worker",
      "zeebe-exporter-protobuf",
      "zeebe-hazelcast-exporter",
      "zeebe-http-worker",
      "zeebe-kafka-exporter",
      "zeebe-keycloak-interceptor",
      "zeebe-play",
      "zeebe-process-generator",
      "zeebe-script-worker",
      "zeebe-simple-monitor",
      "zeebe-simple-tasklist",
      "zeebe-test-container",
      "zeebe-worker-java-testutils",
      "zeeqs",
    ],
  }
}

data "vault_generic_secret" "camunda_community_hub" {
  path = "secret/github.com/organizations/camunda-community-hub"
}

data "vault_generic_secret" "github_camunda_app" {
  path = "secret/github.com/apps/camunda"
}

data "vault_generic_secret" "github_community_hub_app" {
  path = "secret/github.com/apps/camunda-community-hub"
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
