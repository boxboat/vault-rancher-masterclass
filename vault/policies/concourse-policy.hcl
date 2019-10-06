path "database/*" {
  policy = "write"
}

path "policies/*" {
  policy="write"
}

path "auth/kubernetes/*" {
  policy = "write"
}