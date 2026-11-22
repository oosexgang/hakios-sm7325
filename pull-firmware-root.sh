#!/bin/bash
# Extract firmware through su when Android restricts direct adb reads; keep every blob local.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
FW="$HERE/firmware/poco-x5-pro"
S=/data/local/tmp/hakios-fw
STAGE=$(mktemp -d "$HERE/.firmware-root.XXXXXX")
trap 'rm -rf "$STAGE"; adb shell "su -c 'rm -rf $S'" >/dev/null 2>&1 || true' EXIT
adb get-state >/dev/null
adb shell "su -c 'rm -rf $S; mkdir -p $S/gpu $S/wifi $S/audio $S/haptic $S/touch $S/bluetooth $S/modem; cp /vendor/firmware/a660_gmu.bin /vendor/firmware/a660_sqe.fw /vendor/firmware/a660_zap.* $S/gpu/ 2>/dev/null; cp /vendor/firmware_mnt/image/wpss.* $S/wifi/; cp /vendor/firmware_mnt/image/adsp.* /vendor/firmware/aw882xx_acf.bin $S/audio/ 2>/dev/null; cp /vendor/firmware/aw8697_haptic.bin $S/haptic/ 2>/dev/null; cp /vendor/firmware/focaltech_ts_fw_m20.bin $S/touch/ 2>/dev/null; cp /vendor/bt_firmware/image/* $S/bluetooth/ 2>/dev/null; cp /vendor/firmware_mnt/image/modem.* $S/modem/ 2>/dev/null; cp -r /vendor/firmware_mnt/image $S/modem/image; chmod -R a+rX $S'"
adb pull "$S" "$STAGE/hakios-fw" >/dev/null
mkdir -p "$FW"
for category in gpu wifi audio haptic touch bluetooth modem; do
	if [ -d "$STAGE/hakios-fw/$category" ]; then
		rm -rf "$FW/$category"
		mv "$STAGE/hakios-fw/$category" "$FW/$category"
	fi
done
echo "pull-firmware-root.sh: firmware saved under $FW (local, ignored by Git)"
