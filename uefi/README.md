# POCO X5 Pro UEFI platform

The POCO X5 Pro 5G's platform for HakiOS's UEFI (`uefi/` of the common repository: Mu-Silicium with HakiOS's changes and banner).
It is modelled on `lisa` (the same `KodiakPkg` SoC package).

What is here, in `files/`:

- `Platforms/Xiaomi/PocoX5ProPkg`: the memory map and the driver list;
- `Resources/Configs/poco-x5-pro.toml`, `Resources/DTBs/poco-x5-pro.dtb` (the device tree from the phone's vendor_boot);
- `Binaries/poco-x5-pro`: the vendor's UEFI drivers, **not tracked**: you make this directory yourself from your own phone
  (`uefi/README.md` says how); `files/Binaries/poco-x5-pro/README.md` is kept: it lists the patches that were applied to them.

```sh
devices/poco-x5-pro/uefi/apply.sh     # = uefi/apply.sh poco-x5-pro
```

The build and the vendor's drivers: [uefi/README.md](../../../uefi/README.md).
