#!/bin/bash
# Pull the phone's own device tree over adb and turn it into the SoC boot-args HakiOS needs on this
# device (tools/soc-args.py). The SM7325 device matches the kernel's built-in values, so its soc.args
# comes out empty of surprises; another phone's will carry its addresses. Needs the phone in Android
# with adb. /sys/firmware/fdt is readable by everybody on most ROMs; where only root can read it (seen
# on an SM7325 unit running a KernelSU build) the tree is copied under su to a staging file the shell
# can read, pulled from there, and the staging file is removed again.
set -e -o pipefail
here=$(cd "$(dirname "$0")" && pwd)             # before the cd: $0 may be a relative path
cd "$here/../.."
PATH=$PWD/tools/macos-bin/platform-tools:$PATH
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
if ! adb pull /sys/firmware/fdt "$tmp/fdt" >/dev/null 2>&1; then
	stage=/data/local/tmp/hakios-fdt
	adb shell "su -c 'cat /sys/firmware/fdt > $stage && chmod 644 $stage'" >/dev/null 2>&1 || true
	got=0; adb pull "$stage" "$tmp/fdt" >/dev/null 2>&1 || got=1
	adb shell "su -c 'rm -f $stage'" >/dev/null 2>&1 || true
	[ "$got" -eq 0 ] || { echo "pull-soc.sh: cannot read /sys/firmware/fdt over adb, with or without su"; exit 1; }
fi
# made aside and copied over, so that a failure leaves the soc.args that was there
python3 tools/soc-args.py "$tmp/fdt" > "$tmp/soc.args"
cp "$tmp/soc.args" "$here/soc.args"
cat "$here/soc.args"
echo "pull-soc.sh: wrote $here/soc.args"
