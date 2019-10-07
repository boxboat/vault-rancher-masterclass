path "database/*" {
  policy = "write"
}

path "policies/*" {
  policy="write"
}

path "auth/kubernetes/role/*" {
  policy = "write"
}