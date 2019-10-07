#!/bin/bash

vault login --method=userpass username=concourse password=password

for file in vault/apps/*; do
     sh $file
done

for policy in vault/policies/*; do
    policyName=$(echo $policy | cut -d'.' -f1 | cut -d'/' -f3)
    echo $policyName
    cat $policy | vault policy write $policyName -
done