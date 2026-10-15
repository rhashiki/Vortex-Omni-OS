#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")/../.."
for file in build/Containerfile build/scripts/build-image.sh build/branding/vortex-omnios-release integrations/upstream/projects.yaml security/LICENSING_POLICY.md docs/ROADMAP.md; do
  test -s "$file" || { echo "Missing or empty: $file" >&2; exit 1; }
done
command -v python3 >/dev/null || { echo "python3 required" >&2; exit 1; }
python3 - <<'PY'
from pathlib import Path
p=Path('integrations/upstream/projects.yaml').read_text()
assert 'status: candidates_unverified' in p
assert p.count('    url: https://') >= 10
cf=Path('build/Containerfile').read_text()
assert 'FROM ${BASE_IMAGE}' in cf
assert 'COPY build/branding/' in cf
print('PASS: static scaffold checks (not boot validation)')
PY
