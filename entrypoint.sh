#!/bin/sh -l

# Capture inputs as variables
API_KEY=$1
SOURCE_ID=$2
TYPE=$3

# Your GraphQL endpoint (ensure this is set correctly)
GRAPHQL_ENDPOINT="https://api.management.inkeep.com/graphql"

# Your GraphQL mutation
GRAPHQL_MUTATION='mutation CreateSourceSyncJob($sourceId: String!, $type: SourceSyncJobType!) {
  createSourceSyncJob(input: {sourceId: $sourceId, type: $type}) {
    success
  }
}'

# Make the GraphQL request
RESPONSE=$(curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_KEY}" \
  --data "{\"query\":\"${GRAPHQL_MUTATION}\",\"variables\":{\"sourceId\":\"${SOURCE_ID}\",\"type\":\"${TYPE}\"}}" \
  $GRAPHQL_ENDPOINT)

echo "GraphQL response: $RESPONSE"

# Basic error handling based on the presence of "errors" in the response
if echo "$RESPONSE" | grep -q "errors"; then
  echo "Error in GraphQL request"
  exit 1
else
  echo "GraphQL request succeeded"
fi
