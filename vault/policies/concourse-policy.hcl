path "/sys/policies/*" {
  capabilities = ["create", "update", "delete", "list"]
}

path "/sys/policy/*" {
  capabilities = ["create", "update", "delete", "list"]
}

path "auth/kubernetes/role/*" {
  capabilities  = ["create", "update", "delete", "list"]
}

path "database/*" {
  capabilities  = ["create", "update", "delete", "list"]
}