VAULT_POD=$(kubectl -n vault get vault example -o jsonpath='{.status.vaultStatus.sealed[0]}')

VAULT_OUTPUT=$(kubectl -n vault exec $VAULT_POD -c vault -- vault init --tls-skip-verify --key-threshold=1 --key-shares=1)

VAULT_UNSEAL=$(printf $VAULT_OUTPUT | grep "Unseal Key [0-9]*" | sed 's/Unseal Key [0-9]*: //g')

VAULT_TOKEN=$(printf $VAULT_OUTPUT | grep "Initial Root Token:*" | sed 's/Initial Root Token*: //g')

kubectl -n vault exec $VAULT_POD -c vault -- vault unseal -tls-skip-verify $VAULT_UNSEAL

echo $VAULT_TOKEN