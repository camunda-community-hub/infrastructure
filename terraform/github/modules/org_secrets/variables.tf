variable "github_org" {
  type = string
}

variable "repositories" {
  type = list(string)
}

variable "secrets" {
  type = map(string)
}

variable "base64_encoded_secrets" {
  description = "Names of secrets which are stored in Vault using base64 encoding, and need decoding before being saved to GitHub."
  type        = list(string)
  default = [
    "MAVEN_CENTRAL_GPG_SIGNING_KEY_SEC"
  ]
}
