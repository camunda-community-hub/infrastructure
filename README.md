# Infrastructure Repository for `camunda-community-hub`

> [!IMPORTANT]
> The infrastructure code has been migrated to a private repository as part of an organizational restructuring. This public repository now serves only as the community-facing interface for onboarding and managing repositories.

This repository holds the public interface for infrastructure management of the `camunda-community-hub` organization.

Community Hub repositories must be onboarded to gain access to organization-level secrets and automated workflows essential for automated release management (publishing artifacts to [Camunda Artifactory](https://artifacts.camunda.com/) and [Maven Central](https://central.sonatype.com/)), Docker image publishing under the `camundacommunityhub/*` namespace, code signing with GPG, and CI/CD pipeline integration with shared credentials. The onboarding process is managed through Infrastructure as Code, automatically provisioning the required credentials.

For detailed information about the build and release processes, see the [Community Hub Release Guide](https://github.com/camunda-community-hub/community/blob/main/maintainers-reviewers/RELEASE.MD).

## Contents

- `.github/ISSUE_TEMPLATE/` - Issue templates for repository onboarding requests
- `managed-repositories.yml` - Auto-synced by internal systems to surface the repositories currently onboarded - automatically updated, never edit manually

## Onboarding a New Community Hub Repository

To add a new repository to the Camunda Community Hub:

1. **Check Repository List**: First, verify your repository is not already onboarded by checking `managed-repositories.yml`
2. **Create an Issue**: Use the [Repository Onboarding Request](../../issues/new?template=repository-onboarding.md) template
3. **Provide Required Information**: Fill out all the requested details about your repository
4. **Submit and Wait**: We will review your request and handle the infrastructure setup
5. **Confirmation**: Once approved and configured, your repository will be provisioned with the required credentials and listed in `managed-repositories.yml`.
