data "github_repository" "repo" {
  full_name = join("/", [var.github_org, each.value])
  for_each  = toset(var.repositories)
}

resource "github_actions_organization_secret" "secret_entry" {
  for_each                = nonsensitive(toset(keys(var.secrets)))
  plaintext_value         = contains(var.base64_encoded_secrets, each.value) ? base64decode(var.secrets[each.value]) : var.secrets[each.value]
  secret_name             = each.value
  visibility              = "selected"
  selected_repository_ids = [for r in data.github_repository.repo : r.repo_id]
}
