package main

deny[msg] {
  input.kind == "Secret"
  msg := "Secret resources are forbidden in tenant repos; use platform-managed secret patterns."
}
