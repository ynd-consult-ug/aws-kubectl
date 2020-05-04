#!/bin/bash -x
DIR=$(dirname $0)
cd $DIR

if [ -z ${AWS_ACCOUNT+x} ];then
  read -p 'AWS Account ID: ' AWS_ACCOUNT
fi
if [ -z ${AWS_REGION+x} ];then
  read -p 'AWS Region: ' AWS_REGION
fi
if [ -z ${NAMESPACES+x} ];then
  read -p 'Namespaces (space separated): ' NAMESPACES
fi
if [ -z ${AWS_ACCESS_KEY_ID+x} ];then
  read -p 'Please provide AWS_ACCESS_KEY_ID: ' AWS_ACCESS_KEY_ID
fi
if [ -z ${AWS_SECRET_ACCESS_KEY+x} ];then
  read -sp 'Please provide AWS_SECRET_ACCESS_KEY: ' AWS_SECRET_ACCESS_KEY
fi

echo "Creating aws-secrets"
kubectl create secret generic aws-secrets \
  --from-literal="aws-access-key-id=$AWS_ACCESS_KEY_ID" \
  --from-literal="aws-secret-access-key=$AWS_SECRET_ACCESS_KEY" \
  --from-literal="aws-region=$AWS_REGION" \
  --from-literal="aws-account=$AWS_ACCOUNT" \
  --from-literal="namespaces=\'$NAMESPACES\'" \
  --dry-run=client \
  -o yaml| kubectl apply -f-

echo "Upserting aws-role"
kubectl apply -f templates/aws-role.yml

echo "Upserting $NAMESPACE aws-ecr-cron"
kubectl apply -f templates/ecr-cron.yml
