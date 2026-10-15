#!/usr/bin/env python3
"""Fail-closed base image reference and source manifest checks (stdlib only)."""
import argparse
import re
import sys
from pathlib import Path

DIGEST = re.compile(r"^[a-z0-9][a-z0-9._/-]*@sha256:[0-9a-f]{64}$")
def validate(image: str) -> None:
    if not DIGEST.fullmatch(image):
        raise ValueError("BASE_IMAGE must be an immutable OCI sha256 digest reference")
    if not image.startswith("ghcr.io/ublue-os/kinoite-main@sha256:"):
        raise ValueError("Base repository is not the reviewed candidate; update policy first")

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("image")
    args = parser.parse_args()
    try:
        validate(args.image)
    except ValueError as exc:
        print(f"FAIL: {exc}", file=sys.stderr)
        return 2
    print("PASS: immutable reference syntax; license/signature NOT verified")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
