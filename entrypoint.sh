#!/bin/sh -l

# Capture inputs as variables
API_KEY=$1
SOURCE_ID=$2
TYPE=$3

# Your GraphQL endpoint (ensure this is set correctly)
GRAPHQL_ENDPOINT="https://api.management.inkeep.com/graphql"

# Your GraphQL mutation
GRAPHQL_MUTATION='mutation CreateSourceSyncJob($sourceId: ID!, $type: SourceSyncJobType!) {
  createSourceSyncJob(input: {sourceId: $sourceId, type: $type}) {
    success
  }
}'

# Use jq to create the JSON payload
JSON_PAYLOAD=$(jq -n \
                  --arg query "$GRAPHQL_MUTATION" \
                  --arg sourceId "$SOURCE_ID" \
                  --arg type "$TYPE" \
                  '{query: $query, variables: {sourceId: $sourceId, type: $type}}')

# Make the GraphQL request
RESPONSE=$(curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer ${API_KEY}" \
  --data "$JSON_PAYLOAD" \
  $GRAPHQL_ENDPOINT)


echo "GraphQL response: $RESPONSE"

# Basic error handling based on the presence of "errors" in the response
if echo "$RESPONSE" | grep -q "errors"; then
  echo "Error in GraphQL request"
  exit 1
else
  echo "GraphQL request succeeded"
fi
