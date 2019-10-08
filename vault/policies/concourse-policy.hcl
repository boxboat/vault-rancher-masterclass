path "database/*" {
  policy = ["create", "update", "delete", "list"]
}

path "/sys/policies/*" {
  policy= ["create", "update", "delete", "list"]
}

path "/sys/policy/*" {
  policy= ["create", "update", "delete", "list"]
}

path "auth/kubernetes/role/*" {
  policy = ["create", "update", "delete", "list"]
}