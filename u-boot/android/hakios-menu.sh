#!/system/bin/sh
# HakiOS installed beside Android: once Android is up, make HakiOS's slot (a) the active one again, so that the next
# start of the phone shows U-Boot's menu (devices/redwood/u-boot/install.env) instead of going straight to Android.
#
# Install (root: KernelSU, whose bootctl does it; Magisk the same with its own path to bootctl):
#   adb push hakios-menu.sh /data/local/tmp/ && adb shell su -c 'mkdir -p /data/adb/service.d &&
#     cp /data/local/tmp/hakios-menu.sh /data/adb/service.d/ && chmod 755 /data/adb/service.d/hakios-menu.sh'
# Without it nothing breaks: Android stays the slot that starts, and `fastboot set_active a` (or the menu's own
# Android entry, in reverse) brings the menu back.
BOOTCTL=/data/adb/ksu/bin/bootctl
[ -x "$BOOTCTL" ] || BOOTCTL=$(command -v bootctl)
[ -n "$BOOTCTL" ] || exit 0
until [ "$(getprop sys.boot_completed)" = 1 ]; do sleep 5; done
# Android marks its own slot successful at boot completion; after that the active slot may change
sleep 30
[ "$(getprop ro.boot.slot_suffix)" = _b ] || exit 0
"$BOOTCTL" set-active-boot-slot 0 && log -t hakios-menu "slot a active again: the next start shows HakiOS's menu"
