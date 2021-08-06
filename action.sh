#!/bin/sh

set -eux
hub api --method DELETE "repos/${GITHUB_REPOSITORY}/git/refs/tags/${GITHUB_REF##*/}" | jq .
RELEASE_ID="$(hub api --method GET "repos/${GITHUB_REPOSITORY}/releases/tags/${GITHUB_REF##*/}" | jq .id)"
hub api --method DELETE "repos/${GITHUB_REPOSITORY}/releases/${RELEASE_ID}" | jq .
hub api --method POST "repos/${GITHUB_REPOSITORY}/releases" --field "tag_name=${GITHUB_REF##*/}" | jq .
