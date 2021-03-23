variable "vault_address" {
  type    = string
  default = "https://vault.int.camunda.com/"
}
variable "vault_login_approle_role_id" { type = string }
variable "vault_login_approle_secret_id" { type = string }
