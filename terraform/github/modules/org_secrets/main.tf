data "github_repository" "repo" {
  full_name = join("/", [var.github_org, each.value])
  for_each  = toset(var.repositories)
}

resource "github_actions_organization_secret" "secret_entry" {
  for_each                = var.secrets
  plaintext_value         = contains(var.base64_encoded_secrets, each.key) ? base64decode(each.value) : each.value
  secret_name             = each.key
  visibility              = "selected"
  selected_repository_ids = [for r in data.github_repository.repo : r.repo_id]
}
