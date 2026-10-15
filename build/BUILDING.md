# Build 01 — experimental OCI image

Prerequisites: Linux workstation with Podman, Git, adequate disk space, and optional QEMU/virtualization tools.

1. Review the base image's source, licenses, signatures, and exact digest.
2. Run `bash build/scripts/verify-scaffold.sh` for static checks.
3. Set `BASE_IMAGE=ghcr.io/ublue-os/kinoite-main@sha256:<reviewed-digest>`.
4. Run `bash build/scripts/build-image.sh`.
5. Record digest, environment, output, and errors.

For a disposable experiment only, `ALLOW_UNPINNED_BASE=1 bash build/scripts/build-image.sh` permits the moving `stable` tag. Never use this for a release.

## Important limits
This only defines an OCI derivative build. It does not generate an ISO, install to disk, prove bootability, or satisfy the user's fully free/open-source requirement. Those require separate validation, image generation and hardware/VM testing. No GitHub Actions are used.

## Next gates
- Review Fedora/Universal Blue image content for proprietary firmware and third-party licenses.
- Pin immutable base and package versions.
- Produce disk image with compatible bootc image tooling and test boot with QEMU.
- Validate network, persistence, recovery, signatures, rollback and installer before merging.
