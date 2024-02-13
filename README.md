# Source Job Sync docker action

This action will initiate a source sync for the given source id.

## Inputs

## `api-ley`

**Required** The API key to authenticate the sync job creation request with.

## `source-id`
**Required** The source id for which the sync job will be created.

## `type`
**Optional** The type of source sync job to be created. Either FULL or INCREMENTAL. Default is INCREMENTAL.

## Example usage

uses: actions/source-sync-action@v1
with:
  api-key: ${{ secrets.InkeepApiKey}}
  source-id: 'test-id'
  type: 'FULL'
  
