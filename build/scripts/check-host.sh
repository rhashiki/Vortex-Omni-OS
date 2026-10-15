#!/usr/bin/env bash
set -euo pipefail
missing=0
echo "Vortex OmniOS Build 01 — host preflight"
for tool in bash python3 podman qemu-system-x86_64; do
  if command -v "$tool" >/dev/null 2>&1; then
    echo "PASS: $tool"
  else
    echo "MISSING: $tool"
    missing=1
  fi
done
if [[ -e /dev/kvm ]]; then echo "INFO: /dev/kvm present"; else echo "INFO: /dev/kvm unavailable (software emulation may work)"; fi
if [[ "$missing" -ne 0 ]]; then
  echo "BLOCKED: build/VM prerequisites unavailable"
  exit 1
fi
echo "PASS: host commands available; this does not prove OCI build or VM boot"
