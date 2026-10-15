#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
python3 -m unittest discover -s tests -p 'test_*.py' -v
bash -n build/scripts/build-image.sh build/scripts/verify-scaffold.sh build/scripts/check-host.sh build/scripts/inspect-image.sh build/scripts/test-local.sh
bash build/scripts/verify-scaffold.sh
echo "PASS: static/unit validation only; OCI image and QEMU boot not tested"
