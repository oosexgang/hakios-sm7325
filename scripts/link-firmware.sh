#!/bin/bash
set -euo pipefail

HERE=$(cd "$(dirname "$0")/.." && pwd)
DEVICE_FW="$HERE/firmware/poco-x5-pro"
KERNEL=${1:-}
if [ -z "$KERNEL" ]; then
	echo "usage: $0 /path/to/kernel-checkout" >&2
	exit 2
fi
KERNEL=$(cd "$KERNEL" && pwd)

link_dir() {
	local source="$1" target="$2"
	if [ -L "$target" ]; then
		ln -sfn "$source" "$target"
	elif [ -e "$target" ]; then
		echo "refusing to replace existing path: $target" >&2
		exit 1
	else
		ln -s "$source" "$target"
	fi
}

mkdir -p "$DEVICE_FW" "$KERNEL/userland" "$KERNEL/firmware"
for pair in \
	"audio fw-audio" \
	"gpu fw-gpu" \
	"wifi fw-wifi" \
	"bluetooth fw-bt" \
	"haptic fw-haptic" \
	"touch fw-touch" \
	"modem fw-modem" \
	"camera fw-camera"; do
	set -- $pair
	link_dir "$DEVICE_FW/$1" "$KERNEL/userland/$2"
done
link_dir "$DEVICE_FW" "$KERNEL/firmware/poco-x5-pro"
echo "Firmware links configured for $KERNEL"
