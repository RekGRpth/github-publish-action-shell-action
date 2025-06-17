#!/bin/bash

set -euxo pipefail
if [ gh api --method GET "repos/${GITHUB_REPOSITORY}/releases/tags/${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" ]; then
    RELEASE_ID="$(gh api --method GET "repos/${GITHUB_REPOSITORY}/releases/tags/${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .id)"
    gh api --method DELETE "repos/${GITHUB_REPOSITORY}/git/refs/tags/${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .
    gh api --method DELETE "repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}" | jq .
fi
gh api --method POST "repos/${GITHUB_REPOSITORY}/releases" --field "tag_name=${INPUTS_TAG:-${GITHUB_REF##*/}-tag}" | jq .
