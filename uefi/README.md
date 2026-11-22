# POCO X5 Pro UEFI platform

The POCO X5 Pro 5G's platform for HakiOS's UEFI (`uefi/` of the common repository: Mu-Silicium with HakiOS's changes and banner).
It is modelled on `lisa` (the same `KodiakPkg` SoC package).

What is here, in `files/`:

- `Platforms/Xiaomi/SM7325DevicePkg`: the memory map and the driver list;
- `Resources/Configs/sm7325-device.toml`, `Resources/DTBs/sm7325-device.dtb` (the device tree from the phone's vendor_boot);
- `Binaries/sm7325-device`: the vendor's UEFI drivers, **not tracked**: you make this directory yourself from your own phone
  (`uefi/README.md` says how); `files/Binaries/sm7325-device/README.md` is kept: it lists the patches that were applied to them.

```sh
devices/sm7325-device/uefi/apply.sh     # = uefi/apply.sh sm7325-device
```

The build and the vendor's drivers: [uefi/README.md](../../../uefi/README.md).
