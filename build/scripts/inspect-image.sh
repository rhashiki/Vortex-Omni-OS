#!/usr/bin/env bash
set -euo pipefail
# Run only after image is built; records package list and image metadata.
IMAGE_TAG="${IMAGE_TAG:-localhost/vortex-omnios:build01}"
OUT="${OUT:-artifacts/build01}"
command -v podman >/dev/null || { echo "podman missing" >&2; exit 1; }
mkdir -p "$OUT"
podman image inspect "$IMAGE_TAG" > "$OUT/image-inspect.json"
podman run --rm --entrypoint /usr/bin/rpm "$IMAGE_TAG" -qa > "$OUT/rpm-packages.txt"
echo "Inspection captured in $OUT; manual license audit still required."
