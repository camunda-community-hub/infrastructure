variable "github_org" { type = string }
variable "repositories" {
  type = list(string)
}

variable "secrets" {
  type = map(string)
}
variable "github_token" {
  type = string
}
