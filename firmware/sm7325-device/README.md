# SM7325 device firmware

This directory contains firmware payloads extracted from the device and vendor packages for development and boot testing. Files are grouped by hardware function and kept under their original driver-expected names.

| Directory | Contents |
| --- | --- |
| `audio/` | Qualcomm ADSP payloads, DSP image, and AW882xx calibration data |
| `bluetooth/` | Qualcomm Bluetooth firmware/NV data |
| `gpu/` | Adreno 642L (A660 family) firmware |
| `haptic/` | Awinic haptic firmware |
| `modem/` | Modem firmware and its local TFTP image, when extracted |
| `source/` | Android vendor boot source image, if available |
| `touch/` | FocalTech touchscreen firmware |
| `uefi/` | Locally generated loader artifacts and extracted device tree |
| `wifi/` | WCN6750 firmware, board data, and regulatory data |

The unique GPT identity data is intentionally omitted. Generated artifacts such as `SILICIUM_UEFI.fd` and `BootShim.bin` are included for reproducible bring-up; rebuild them from the UEFI sources when needed. Check each vendor package license before reusing these files outside this device project.
