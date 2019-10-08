vault write auth/kubernetes/role/hello-world \
    bound_service_account_names=app \
    bound_service_account_namespaces=default \
    policies=default \
    ttl=1h