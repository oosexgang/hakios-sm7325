#!/bin/bash
# The SM7325 device platform on HakiOS's UEFI: uefi/apply.sh with this phone's
# platform from files/ here. See README.md here for the vendor's drivers and the build.
exec "$(dirname "$(readlink -f "$0")")/../../../uefi/apply.sh" sm7325-device
