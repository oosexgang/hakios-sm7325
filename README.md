# hakios-sm7325: SM7325 device and Snapdragon 778G (SM7325)

One HakiOS device repository: the device (`device.conf`, `configs/`, its UEFI platform, firmware scripts) and its SoC family's
layer (`soc/`: the SC7280 family, SM7325). `tools/hakios-device.py sync` in the common repository clones it into `devices/sm7325-device/`.

## The device

Everything in HakiOS that belongs to one phone is here. The kernel, loader and user space above
know nothing about the phone: addresses, interrupts, power rails and firmware come from its device
tree and its Android. A port to another Qualcomm phone is another directory like this one.

| What | Where |
|---|---|
| SoC | Qualcomm Snapdragon 778G (SM7325, "yupik" in the device tree) |
| UEFI for the phone | `uefi/`: a port of Mu-Silicium (a patch and files; `apply.sh` clones and applies, `export.sh` saves) |
| Board description for the current kernel | `sm7325-device/board.dts` and `sm7325-device/soc.dtsi` |
| UEFI build inputs and local firmware | Generated/extracted files live in `firmware/sm7325-device/`, ignored by Git |
| Tools | `tools/modem_firmware.py` (the modem image by the device tree), `tools/cellular_probe.py` (the modem's nodes in the device tree) |

What the kernel does for this phone in particular is the drivers `drivers/*/hakios.*`
(display, Goodix touch, UFS, Adreno 642L, WCN6750 Wi-Fi, the audio DSP, the modem, the Awinic
haptics, the cameras); the head of each file says where its numbers come from. That is the map of
what to rewrite for another phone.

## Firmware

```sh
./pull-firmware.sh      # phone in Android, connected with adb
```

Pulls GPU, Wi-Fi, audio DSP, haptic, touch, Bluetooth, and modem files into categories under
`firmware/sm7325-device/`. The files stay on the developer machine and are excluded from commits.
Run `scripts/link-firmware.sh /path/to/kernel` to connect kernel build inputs.

## Running

From the top of the repository, see the main README: `./xl enter`, `./xl ramdisk`, `./xl run`,
or everything in one command: `tools/modem-cycle.sh "ARGS" SECS`, or `make phone`.

## Porting to another Qualcomm phone: the SoC addresses

The kernel's modem and IPA drivers carry this phone's register and memory addresses as defaults and
take any that differ from boot-args `soc_*` (`hakios.mpss.c`, `soc_override()`, and `hakios.ipa.c`).
To bring up another phone, pull its own device tree and turn it into those arguments:

```sh
devices/<name>/pull-soc.sh      # adb pull /sys/firmware/fdt, then tools/soc-args.py -> devices/<name>/soc.args
```

`tools/soc-args.py DEVICE-TREE.dtb` reads the `qcom,ipa`, `qcom,ipcc`, the AOSS mailbox, the RPMh
controller and `apps-smmu` nodes and prints `soc_ipa_base`, `soc_gsi_base`, `soc_ipcc`, `soc_aoss`,
`soc_rsc`, `soc_apps_smmu`. The run scripts append `devices/<name>/soc.args` to the kernel command
line automatically (`SOC_ARGS=` to point elsewhere). The memory addresses (`soc_smem`, `soc_cmd_db`,
`soc_mpss_mem`, `soc_imem`) come from the phone's reserved-memory nodes; add them by hand for now.
For this phone every generated value equals the built-in default, so `soc.args` changes nothing here
and is kept only as the worked example.

### Every soc_* argument

What `tools/soc-args.py` reads from a phone's device tree, and where each comes from. The SM7325 device's values (the kernel defaults) are shown; another phone's are generated into its `soc.args`.

| Argument | Device-tree source | SM7325 value |
|---|---|---|
| `soc_ipa_base` | `qcom,ipa` reg `ipa-base` + 0x40000 (the registers) | `0x1e40000` |
| `soc_gsi_base` | `qcom,ipa` reg `gsi-base` | `0x1e04000` |
| `soc_ipcc` | `qcom,ipcc` reg | `0x408000` |
| `soc_aoss` | the AOSS QMP mailbox reg | `0xc300000` |
| `soc_rsc` | `qcom,rpmh-rsc` reg drv-2 (the apps DRV) | `0x18220000` |
| `soc_apps_smmu` | `apps-smmu` reg | `0x15000000` |
| `soc_smem` | the reserved-memory `qcom,smem` points at | `0x80900000` |
| `soc_cmd_db` | reserved-memory `cmd_db` | `0x80860000` |
| `soc_mpss_mem` | reserved-memory `mpss` (the modem's image) | `0x8b800000` |
| `modem_ipa_fw_at` | reserved-memory `ipa_gsi` (where the IPA firmware loads) | `0x8b710000` |
| `soc_imem` | `qcom,msm-imem`, rounded down to its 2 MB block | `0x14600000` |
| `soc_ipa_stream` | `ipa_smmu_ap` iommus stream | `0x480` |
| `soc_ipa_stream_uc` | `ipa_smmu_uc` iommus stream | `0x482` |
| `soc_pas_mpss` | `qcom,mss` `qcom,pas-id` | `0x4` |
| `soc_pas_ipa` | `qcom,ipa_fws` `qcom,pas-id` | `0xf` |
| `soc_ipa_fw` | `qcom,ipa_fws` `qcom,firmware-name` | `yupik_ipa_fws` |

Still hardcoded (IPA-version specific, not per-phone within one IPA version): the SRAM region
layout and the SMEM filter-table item (`ipa_4_11_mem_part`), and the Qtime/resource-group values
the IPA is programmed with. A phone on the same IPA (4.11) needs none of these changed; a different
IPA version is a larger port.


## Board description for the current kernel

`sm7325-device/board.dts` and `sm7325-device/soc.dtsi` describe the phone for the newer board-table
build. Point `HAKIOS_DEVICES` at this repository and run `tools/boards.py status sm7325-device` from
the kernel checkout. The loader and kernel use the product name `sm7325-device`; Android fastboot
continues to report Xiaomi's product identifier `redwood`.
