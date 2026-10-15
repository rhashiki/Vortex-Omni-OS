#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
command -v podman >/dev/null || { echo "podman required" >&2; exit 1; }
BASE_IMAGE="${BASE_IMAGE:-ghcr.io/ublue-os/kinoite-main:stable}"
IMAGE_TAG="${IMAGE_TAG:-localhost/vortex-omnios:build01}"
if [[ "${ALLOW_UNPINNED_BASE:-0}" != 1 && "$BASE_IMAGE" != *@sha256:* ]]; then
  echo "Refusing mutable base tag. Supply BASE_IMAGE=...@sha256:<reviewed digest> (or ALLOW_UNPINNED_BASE=1 for non-release experimentation)." >&2
  exit 2
fi
podman build --pull=always --build-arg "BASE_IMAGE=$BASE_IMAGE" -f build/Containerfile -t "$IMAGE_TAG" .
echo "OCI image built: $IMAGE_TAG. Boot/ISO not validated."
