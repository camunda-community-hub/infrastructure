# Infrastructure Repository for `camunda-community-hub`

This repository holds infrastructure configuration for the `camunda-community-hub` organisation.

## Contents

- `terraform/github` - Terraform code for configuring repositories

## Use case: Onboarding a new Community Hub repository

1. Edit [`terraform/github/repositories.tf`](https://github.com/camunda-community-hub/infrastructure/edit/master/terraform/github/repositories.tf) to add a new string entry under `locals` -> `repositories` -> `camunda-community-hub`
2. Enter a meaningful commit message, like `chore(terraform): add new repository`
3. Ensure "Create a **new branch** for this commit and start a pull request" is selected. Enter a meaningful branch name.
4. Click on `Propose Changes`.
5. Notify the Camunda team that your Pull Request is ready for review by _tagging_ @camunda-community-hub/devrel in a comment
6. After the PR has been approved by the DevRel team, the Camunda infrastructure team needs to merge the PR, as they add the necessary credentials to the repo in this step.

![image](https://user-images.githubusercontent.com/175639/113735029-21ec6e80-96fc-11eb-8aa9-8da1473411bf.png)
