# Build 01 — reproducible execution gates

1. Choose and verify a base OCI digest, upstream source, signatures and licenses.
2. Record digest in an approval manifest; do not rely on mutable stable tags for releases.
3. Run local tests: `python3 -m unittest discover -s tests -p 'test_*.py' -v`.
4. On Linux with Podman: `BASE_IMAGE=ghcr.io/ublue-os/kinoite-main@sha256:<verified digest> bash build/scripts/build-image.sh`.
5. Run `bash build/scripts/inspect-image.sh` and audit installed packages and firmware.
6. Produce a bootable disk artifact with compatible image-building tools in a Linux build host.
7. Boot QEMU with UEFI, record logs, verify storage, persistence, networking, update and rollback.
8. Only then consider approving the draft PR.

**Important:** A container image is not an ISO. No QEMU boot or disk image has yet been generated. The Universal Blue candidate may include redistributable but non-free firmware; a strict FOSS image needs additional filtering and audit.
