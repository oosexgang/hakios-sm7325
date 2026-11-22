#!/bin/bash
# The POCO X5 Pro platform on HakiOS's UEFI: uefi/apply.sh with this phone's
# platform from files/ here. See README.md here for the vendor's drivers and the build.
exec "$(dirname "$(readlink -f "$0")")/../../../uefi/apply.sh" poco-x5-pro
