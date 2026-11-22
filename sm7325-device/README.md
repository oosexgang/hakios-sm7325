# SM7325 device

Device support for Qualcomm SM7325 / Snapdragon 778G. The board description is in `board.dts`,
and shared SoC register data is in `soc.dtsi`.

## Current status

The owner has reported that Darwin 27.2 reached its interface from a RAM boot with Adreno/Metal
active. Battery percentage reporting and Metal frame artifacts/performance remain work items. This
package describes the board; it does not claim every peripheral is supported.

## Board identity

The kernel and loader identify this board as `sm7325-device`. Xiaomi Android fastboot still reports
`redwood` as the product string, so `fastboot-product` in `board.dts` retains that value for host
compatibility. The shared U-Boot tree also currently names its board defconfig
`hakios_redwood_defconfig`.

## Local firmware

Firmware is stored under `../firmware/sm7325-device/` and ignored by Git. See that directory's README
for categories and extraction notes. `../scripts/link-firmware.sh /path/to/kernel` connects these
local files to the kernel's expected firmware input paths.

## Storage

The read-only UFS survey and the existing Darwin partition are documented in `../docs/storage.md`.
