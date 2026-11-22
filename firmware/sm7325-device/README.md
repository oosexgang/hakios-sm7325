# Local SM7325 device firmware

This directory is a local staging area and is excluded from Git. The files below are extracted
from the device/vendor packages available in this development workspace; they are not redistributed
by this project.

| Directory | Contents |
| --- | --- |
| `audio/` | Qualcomm ADSP payloads, DSP image, and AW882xx calibration data |
| `bluetooth/` | Qualcomm Bluetooth firmware/NV data |
| `gpu/` | Adreno 642L (A660 family) firmware |
| `haptic/` | Awinic haptic firmware |
| `identity/` | Local board identity/configuration extracted for development |
| `modem/` | Modem firmware and its local TFTP image, when extracted |
| `source/` | Android vendor boot source image, if available |
| `touch/` | FocalTech touchscreen firmware |
| `uefi/` | Locally generated loader artifacts and extracted device tree |
| `wifi/` | WCN6750 firmware, board data, and regulatory data |

To recreate the directory, use firmware from your own device or an authorized vendor package and
follow the kernel and U-Boot extraction notes. Preserve the filenames expected by the drivers.
Do not commit these files: several contain proprietary firmware or device-specific data. Generated
artifacts such as `SILICIUM_UEFI.fd` and `BootShim.bin` are local build outputs and can be regenerated.
