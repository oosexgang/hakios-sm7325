#!/bin/bash
# Extract this phone's vendor firmware into the device repository's ignored local directory.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
FW="$HERE/firmware/sm7325-device"

pull() {
	local category=$1; shift
	local dest="$FW/$category"
	mkdir -p "$dest"
	for source in "$@"; do
		adb pull "$source" "$dest/" >/dev/null 2>&1 || echo "pull-firmware.sh: not available: $source"
	done
	echo "pull-firmware.sh: $category: $(find "$dest" -type f | wc -l | tr -d ' ') files"
}

adb get-state >/dev/null
pull gpu /vendor/firmware/a660_gmu.bin /vendor/firmware/a660_sqe.fw /vendor/firmware/a660_zap.mdt /vendor/firmware/a660_zap.b00 /vendor/firmware/a660_zap.b01 /vendor/firmware/a660_zap.b02
pull wifi /vendor/firmware_mnt/image/wpss.mdt /vendor/firmware_mnt/image/wpss.b02 /vendor/firmware_mnt/image/wpss.b03 /vendor/firmware_mnt/image/wpss.b04 /vendor/firmware_mnt/image/wpss.b05 /vendor/firmware_mnt/image/wpss.b06 /vendor/firmware_mnt/image/wpss.b07 /vendor/firmware_mnt/image/bd_m20gl.elf /vendor/firmware_mnt/image/regdb_xiaomi.bin /vendor/firmware_mnt/image/wpss.qdb
pull audio /vendor/firmware_mnt/image/adsp.mdt $(for i in $(seq -w 2 36); do echo "/vendor/firmware_mnt/image/adsp.b$i"; done) /vendor/firmware/aw882xx_acf.bin
pull haptic /vendor/firmware/aw8697_haptic.bin
pull touch /vendor/firmware/focaltech_ts_fw_m20.bin
pull bluetooth /vendor/bt_firmware/image/msbtfw10.tlv /vendor/bt_firmware/image/msbtfw11.mbn /vendor/bt_firmware/image/msbtfw11.tlv /vendor/bt_firmware/image/msbtfw11.ver /vendor/bt_firmware/image/msnv10.bin /vendor/bt_firmware/image/msnv11.bin
pull modem /vendor/firmware_mnt/image/modem.mdt $(for i in $(seq -w 0 28); do echo "/vendor/firmware_mnt/image/modem.b$i"; done)
echo "pull-firmware.sh: done; firmware is local under firmware/sm7325-device/ and excluded from Git"
