#!/bin/bash

set -euxo pipefail
RELEASE_ID="$(gh api --method GET "repos/${GITHUB_REPOSITORY}/releases/tags/${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .id)"
if [ -n "$RELEASE_ID" ]; then
    gh api --method DELETE "repos/${GITHUB_REPOSITORY}/git/refs/tags/${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .
    gh api --method DELETE "repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}" | jq .
fi
gh api --method POST "repos/${GITHUB_REPOSITORY}/releases" --field "tag_name=${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .
