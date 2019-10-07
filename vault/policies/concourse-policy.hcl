path "database/*" {
  policy = "write"
}

path "/sys/policies/*" {
  policy="write"
}

path "/sys/policy/*" {
  policy="write"
}

path "auth/kubernetes/role/*" {
  policy = "write"
}