#!/bin/sh

set -eux
hub api --method DELETE "repos/${GITHUB_REPOSITORY}/git/refs/tags/${INPUTS_TAG:-${GITHUB_REF##*/}}" | jq .
RELEASE_ID="$(hub api --method GET "repos/${GITHUB_REPOSITORY}/releases/tags/${INPUTS_TAG:-${GITHUB_REF##*/}}" | jq .id)"
hub api --method DELETE "repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}" | jq .
hub api --method POST "repos/${GITHUB_REPOSITORY}/releases" --field "tag_name=${INPUTS_TAG:-${GITHUB_REF##*/}}" --field "target_commitish=${INPUTS_TAG:-${GITHUB_REF##*/}}" | jq .
