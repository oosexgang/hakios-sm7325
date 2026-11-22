# Build and integrate

This directory is the device package for `poco-x5-pro`; it does not contain the shared kernel or the
shared U-Boot source.

## Kernel board checks

```sh
DEVICE_REPO=$(pwd)
"$DEVICE_REPO/scripts/link-firmware.sh" /path/to/xnu-kernel
cd /path/to/xnu-kernel
export HAKIOS_DEVICES="$DEVICE_REPO"
tools/boards.py check
tools/boards.py status poco-x5-pro
```

The link script is safe to rerun and refuses to replace real directories or files.

## U-Boot profile

The shared U-Boot repository reads the external profile under `uefi-profiles/` and the local
firmware under `firmware/`:

```sh
cd /path/to/poco-x5-pro-uefi
source ./env.sh
export HAKIOS_PROFILE_ROOT="$(cd /path/to/hakios-sm7325/uefi-profiles && pwd)"
export DEVICE_FIRMWARE="$(cd /path/to/hakios-sm7325/firmware && pwd)"
PROFILE=qualcomm/poco-x5-pro
source "$HAKIOS_PROFILE_ROOT/$PROFILE/profile.env"
u-boot/build.sh "$PROFILE"
```

The UEFI build requires the pinned U-Boot source, an AArch64 cross compiler, and the host tools
listed by the UEFI repository. Building does not imply the resulting image is safe to flash; use
the documented RAM boot path for hardware testing.

## Firmware

See [firmware/poco-x5-pro/README.md](firmware/poco-x5-pro/README.md). Firmware is kept on the local machine
and intentionally ignored by Git.
