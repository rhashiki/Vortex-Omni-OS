#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
command -v podman >/dev/null || { echo "podman required" >&2; exit 1; }
command -v python3 >/dev/null || { echo "python3 required" >&2; exit 1; }
BASE_IMAGE="${BASE_IMAGE:-}"
IMAGE_TAG="${IMAGE_TAG:-localhost/vortex-omnios:build01}"
if [[ -z "$BASE_IMAGE" ]]; then
  echo "BASE_IMAGE must be explicitly set to an approved OCI digest" >&2
  exit 2
fi
python3 build/scripts/validate-base.py "$BASE_IMAGE"
if [[ "${LICENSE_AUDIT_APPROVED:-0}" != 1 ]]; then
  echo "STOP: image not approved for distribution; set LICENSE_AUDIT_APPROVED=1 only after completing a documented license audit." >&2
  exit 3
fi
podman build --pull=always --build-arg "BASE_IMAGE=$BASE_IMAGE" -f build/Containerfile -t "$IMAGE_TAG" .
echo "Experimental OCI image built: $IMAGE_TAG. Boot, licensing, ISO and recovery not validated by this command."
