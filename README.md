The Docker Image contains the aws-cli and kubectl. It is used to update the AWS ECR credentials periodically in a kubernetes cluster.

# Setup

Run and answer all prompts:

  ./aws.sh

or provide the values like this:

  AWS_ACCESS_KEY_ID=KEY AWS_SECRET_ACCESS_KEY=KEY AWS_REGION=eu-central-1 AWS_ACCOUNT=ID NAMESPACES='prod test' ./aws.sh

Afterwards you should be able to see the cron job with:

  kubectl get cronjobs

# Thanks

This is based on the work of @xynova and Mike Petersen <mike@odania-it.de>.

