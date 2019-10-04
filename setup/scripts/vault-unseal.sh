##/bin/bash
VAULT_POD=vault-0

VAULT_OUTPUT=$(kubectl -n vault exec $VAULT_POD -c vault -- vault operator init --tls-skip-verify --key-threshold=1 --key-shares=1)

VAULT_UNSEAL=$(printf $VAULT_OUTPUT | grep "Unseal Key [0-9]*" | sed 's/Unseal Key [0-9]*: //g')

VAULT_TOKEN=$(printf $VAULT_OUTPUT | grep "Initial Root Token:*" | sed 's/Initial Root Token*: //g')

kubectl -n vault exec $VAULT_POD -c vault -- vault operator unseal -tls-skip-verify $VAULT_UNSEAL

kubectl -n vault exec $VAULT_POD -c vault -- vault login -tls-skip-verify $VAULT_TOKEN

kubectl -n vault exec $VAULT_POD -c vault -- vault auth enable userpass 
kubectl -n vault exec $VAULT_POD -c vault -- vault auth enable kubernetes
kubectl -n vault exec $VAULT_POD -c vault -- vault write auth/userpass/users/concourse password=password policies=concourse

kubectl -n vault exec $VAULT_POD -c vault -- vault secrets enable database 
kubectl -n vault exec $VAULT_POD -c vault -- vault write database/config/mysql plugin_name=mysql-database-plugin connection_url="{{username}}:{{password}}@tcp(mysql.mysql:3306)/" allowed_roles="my-role" username="root" password="testing" 
kubectl -n vault exec $VAULT_POD -c vault -- vault write database/roles/my-role db_name=mysql creation_statements="CREATE USER '{{name}}'@'%' IDENTIFIED BY '{{password}}';GRANT SELECT ON *.* TO '{{name}}'@'%';" default_ttl="1h" max_ttl="24h"