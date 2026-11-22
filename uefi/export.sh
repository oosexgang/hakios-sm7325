#!/bin/bash
# Export Xiaomi's upstream platform inputs into the POCO X5 Pro package layout.
# The upstream source still calls this model redwood; repository paths use the product name.
set -euo pipefail
cd "$(dirname "$(readlink -f "$0")")"
MU=${MU:-../../../Mu-Silicium}
rm -rf files
mkdir -p files/Resources/Configs files/Resources/DTBs files/Platforms/Xiaomi/PocoX5ProPkg files/Binaries/poco-x5-pro
cp -R "$MU/Platforms/Xiaomi/redwoodPkg/." files/Platforms/Xiaomi/PocoX5ProPkg/
if [ -f files/Platforms/Xiaomi/PocoX5ProPkg/redwood.dsc ]; then mv files/Platforms/Xiaomi/PocoX5ProPkg/redwood.dsc files/Platforms/Xiaomi/PocoX5ProPkg/PocoX5Pro.dsc; fi
if [ -f files/Platforms/Xiaomi/PocoX5ProPkg/redwood.fdf ]; then mv files/Platforms/Xiaomi/PocoX5ProPkg/redwood.fdf files/Platforms/Xiaomi/PocoX5ProPkg/PocoX5Pro.fdf; fi
if [ -f files/Platforms/Xiaomi/PocoX5ProPkg/redwood.dec ]; then mv files/Platforms/Xiaomi/PocoX5ProPkg/redwood.dec files/Platforms/Xiaomi/PocoX5ProPkg/PocoX5Pro.dec; fi
cp "$MU/Resources/Configs/redwood.toml" files/Resources/Configs/poco-x5-pro.toml
cp "$MU/Resources/DTBs/redwood.dtb" files/Resources/DTBs/poco-x5-pro.dtb
cp -R "$MU/Binaries/redwood/." files/Binaries/poco-x5-pro/
python3 - <<'PYREWRITE'
from pathlib import Path
root = Path("files")
for path in root.rglob("*"):
    if not path.is_file():
        continue
    try:
        text = path.read_text()
    except UnicodeDecodeError:
        continue
    text = text.replace("redwoodPkg", "PocoX5ProPkg")
    text = text.replace("Scopes = ('redwood',", "Scopes = ('poco-x5-pro',")
    text = text.replace("Binaries/redwood/", "Binaries/poco-x5-pro/")
    text = text.replace("redwood.dsc", "PocoX5Pro.dsc")
    text = text.replace("redwood.fdf", "PocoX5Pro.fdf")
    text = text.replace("Build/redwoodPkg", "Build/PocoX5ProPkg")
    text = text.replace("PLATFORM_NAME                  = redwood", "PLATFORM_NAME                  = poco-x5-pro")
    text = text.replace('PcdSmbiosSystemRetailModel|"redwood"', 'PcdSmbiosSystemRetailModel|"POCO X5 Pro 5G"')
    text = text.replace('PcdSmbiosSystemRetailSku|"POCO_X5_Pro_5G_redwood"', 'PcdSmbiosSystemRetailSku|"POCO_X5_Pro_5G"')
    text = text.replace('return "redwood"', 'return "poco-x5-pro"')
    path.write_text(text)
PYREWRITE
find files -name __pycache__ -prune -exec rm -rf {} +
echo "POCO X5 Pro UEFI export: $(find files -type f | wc -l | tr -d ' ') files"
