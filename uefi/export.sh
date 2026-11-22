#!/bin/bash
# Export Xiaomi's upstream platform inputs into the SM7325 device package layout.
# The upstream source still calls this model redwood; repository paths use the product name.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
MU=${MU:-../../../Mu-Silicium}
rm -rf files
mkdir -p files/Resources/Configs files/Resources/DTBs files/Platforms/Xiaomi/SM7325DevicePkg files/Binaries/sm7325-device
cp -R "$MU/Platforms/Xiaomi/redwoodPkg/." files/Platforms/Xiaomi/SM7325DevicePkg/
if [ -f files/Platforms/Xiaomi/SM7325DevicePkg/redwood.dsc ]; then mv files/Platforms/Xiaomi/SM7325DevicePkg/redwood.dsc files/Platforms/Xiaomi/SM7325DevicePkg/SM7325Device.dsc; fi
if [ -f files/Platforms/Xiaomi/SM7325DevicePkg/redwood.fdf ]; then mv files/Platforms/Xiaomi/SM7325DevicePkg/redwood.fdf files/Platforms/Xiaomi/SM7325DevicePkg/SM7325Device.fdf; fi
if [ -f files/Platforms/Xiaomi/SM7325DevicePkg/redwood.dec ]; then mv files/Platforms/Xiaomi/SM7325DevicePkg/redwood.dec files/Platforms/Xiaomi/SM7325DevicePkg/SM7325Device.dec; fi
cp "$MU/Resources/Configs/redwood.toml" files/Resources/Configs/sm7325-device.toml
cp "$MU/Resources/DTBs/redwood.dtb" files/Resources/DTBs/sm7325-device.dtb
cp -R "$MU/Binaries/redwood/." files/Binaries/sm7325-device/
python3 - <<'PYREWRITE'
from pathlib import Path
import re
root = Path("files")
for path in root.rglob("*"):
    if not path.is_file():
        continue
    try:
        text = path.read_text()
    except UnicodeDecodeError:
        continue
    text = text.replace("redwoodPkg", "SM7325DevicePkg")
    text = text.replace("Scopes = ('redwood',", "Scopes = ('sm7325-device',")
    text = text.replace("Binaries/redwood/", "Binaries/sm7325-device/")
    text = text.replace("redwood.dsc", "SM7325Device.dsc")
    text = text.replace("redwood.fdf", "SM7325Device.fdf")
    text = text.replace("Build/redwoodPkg", "Build/SM7325DevicePkg")
    text = text.replace("PLATFORM_NAME                  = redwood", "PLATFORM_NAME                  = sm7325-device")
    text = text.replace('PcdSmbiosSystemRetailModel|"redwood"', 'PcdSmbiosSystemRetailModel|"SM7325 device"')
    text = re.sub(r'(PcdSmbiosSystemRetailSku\|)"[^"]*"', r'\1"SM7325_DEVICE"', text)
    text = text.replace('return "redwood"', 'return "sm7325-device"')
    path.write_text(text)
PYREWRITE
find files -name __pycache__ -prune -exec rm -rf {} +
echo "SM7325 UEFI export: $(find files -type f | wc -l | tr -d ' ') files"
