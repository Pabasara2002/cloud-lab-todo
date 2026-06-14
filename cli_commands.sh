#!/bin/bash
# ==============================================================================
# PART B: AWS CLI DEPLOYMENT COMMANDS - TODO APPLICATION
# Student: Pabasara
# ==============================================================================

# Step 1: Initialize logging pipeline infrastructure
aws logs create-log-group --log-group-name /ecs/todo-task-cli --region ap-south-1

# Step 2: Extract active IAM ECS task execution execution role ARN
ROLE_ARN=$(aws iam get-role --role-name ecs-task-execution-role-cli --query 'Role.Arn' --output text)

# Step 3: Register architectural task configuration layout definition
aws ecs register-task-definition --cli-input-json file://task-definition.json --region ap-south-1

# Step 4: List active compute tasks inside the orchestration layer cluster
aws ecs list-tasks --cluster "cloud-lab-cluster-cli" --region ap-south-1

# Step 5: Query explicit network configuration interfaces for running task
aws ecs describe-tasks --cluster "cloud-lab-cluster-cli" --tasks "arn:aws:ecs:ap-south-1:710514262881:task/cloud-lab-cluster-cli/8e81adf7378c4025bddeff2b7fabeea7" --region ap-south-1

# Step 6: Instantiated container service topology distribution cluster via Fargate
aws ecs create-service \
  --cluster "cloud-lab-cluster-cli" \
  --service-name todo-service-cli \
  --task-definition "arn:aws:aws:ecs:ap-south-1:710514262881:task-definition/todo-task-cli" \
  --desired-count 2 \
  --launch-type FARGATE \
  --network-configuration "awsvpcConfiguration={subnets=[$SUBNET_IDS],securityGroups=[$ECS_SG_ID],assignPublicIp=ENABLED}" \
  --region ap-south-1
