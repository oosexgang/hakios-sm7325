APRIORI DXE {
  INF MdeModulePkg/Core/Dxe/DxeMain.inf
  INF MdeModulePkg/Universal/PCD/Dxe/Pcd.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/EnvDxe/EnvDxe.inf

  INF MdeModulePkg/Universal/ReportStatusCodeRouter/RuntimeDxe/ReportStatusCodeRouterRuntimeDxe.inf
  INF MdeModulePkg/Universal/StatusCodeHandler/RuntimeDxe/StatusCodeHandlerRuntimeDxe.inf
  INF MdeModulePkg/Core/RuntimeDxe/RuntimeDxe.inf
  INF ArmPkg/Drivers/CpuDxe/CpuDxe.inf
  INF ArmPkg/Drivers/ArmGicDxe/ArmGicDxe.inf
  INF EmbeddedPkg/MetronomeDxe/MetronomeDxe.inf
  INF ArmPkg/Drivers/TimerDxe/TimerDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/SmemDxe/SmemDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/DALSYSDxe/DALSYSDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/HWIODxe/HWIODxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ChipInfoDxe/ChipInfoDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PlatformInfoDxe/PlatformInfoDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ProjectInfoDxe/ProjectInfoDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/HALIOMMUDxe/HALIOMMUDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ULogDxe/ULogDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/CmdDbDxe/CmdDbDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PwrUtilsDxe/PwrUtilsDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/NpaDxe/NpaDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/RpmhDxe/RpmhDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/VcsDxe/VcsDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ClockDxe/ClockDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ICBDxe/ICBDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ShmBridgeDxe/ShmBridgeDxeLA.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/TzDxe/ScmDxeLA.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/TLMMDxe/TLMMDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/SPMIDxe/SPMIDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/I2CDxe/I2CDxe.inf

  INF MdeModulePkg/Universal/ResetSystemRuntimeDxe/ResetSystemRuntimeDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PmicDxe/PmicDxeLa.inf

  INF MdeModulePkg/Universal/Disk/DiskIoDxe/DiskIoDxe.inf
  INF MdeModulePkg/Universal/Disk/PartitionDxe/PartitionDxe.inf
  INF MdeModulePkg/Universal/Disk/UnicodeCollation/EnglishDxe/EnglishDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/SdccDxe/SdccDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UFSDxe/UFSDxe.inf

  INF FatPkg/EnhancedFatDxe/Fat.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/TzDxe/TzDxeLA.inf

  INF MdeModulePkg/Universal/Variable/RuntimeDxe/VariableRuntimeDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/DDRInfoDxe/DDRInfoDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/FeatureEnablerDxe/FeatureEnablerDxe.inf

!if $(USE_CUSTOM_DISPLAY_DRIVER) == 1
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/DisplayDxe/DisplayDxe.inf
!else
  INF SiliciumPkg/Drivers/SimpleFbDxe/SimpleFbDxe.inf
!endif

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PILProxyDxe/PILProxyDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PILDxe/PILDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/IPCCDxe/IPCCDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/GLinkDxe/GLinkDxe.inf
!if $(USE_CUSTOM_DISPLAY_DRIVER) == 1
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/CPRDxe/CPRDxe.inf
!endif

  INF MdeModulePkg/Universal/WatchdogTimerDxe/WatchdogTimer.inf
  INF MdeModulePkg/Universal/SecurityStubDxe/SecurityStubDxe.inf
  INF EmbeddedPkg/EmbeddedMonotonicCounter/EmbeddedMonotonicCounter.inf
  INF EmbeddedPkg/RealTimeClockRuntimeDxe/RealTimeClockRuntimeDxe.inf
  INF MdeModulePkg/Universal/PrintDxe/PrintDxe.inf
  INF MdeModulePkg/Universal/DevicePathDxe/DevicePathDxe.inf
  INF MdeModulePkg/Universal/CapsuleRuntimeDxe/CapsuleRuntimeDxe.inf
  INF MdeModulePkg/Universal/HiiDatabaseDxe/HiiDatabaseDxe.inf
  INF MdeModulePkg/Universal/BdsDxe/BdsDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/SPIDxe/SPIDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/PmicGlinkDxe/PmicGlinkDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UsbPwrCtrlDxe/UsbPwrCtrlDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/QcomChargerDxe/QcomChargerDxeLA.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ChargerExDxe/ChargerExDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UsbfnDwc3Dxe/UsbfnDwc3Dxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/XhciPciEmulationDxe/XhciPciEmulationDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/XhciDxe/XhciDxe.inf

  INF MdeModulePkg/Bus/Usb/UsbBusDxe/UsbBusDxe.inf
  INF MdeModulePkg/Bus/Usb/UsbKbDxe/UsbKbDxe.inf
  INF MdeModulePkg/Bus/Usb/UsbMassStorageDxe/UsbMassStorageDxe.inf

  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UsbMsdDxe/UsbMsdDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UsbDeviceDxe/UsbDeviceDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UsbConfigDxe/UsbConfigDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/ButtonsDxe/ButtonsDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/TsensDxe/TsensDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/LimitsDxe/LimitsDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/GpiDxe/GpiDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/UCDxe/UCDxe.inf
  INF Binaries/poco-x5-pro/QcomPkg/Drivers/RNGDxe/RngDxe.inf

  INF EmbeddedPkg/SimpleTextInOutSerial/SimpleTextInOutSerial.inf
  INF MdeModulePkg/Universal/Console/ConPlatformDxe/ConPlatformDxe.inf
  INF MdeModulePkg/Universal/Console/ConSplitterDxe/ConSplitterDxe.inf
  INF MdeModulePkg/Universal/Console/GraphicsConsoleDxe/GraphicsConsoleDxe.inf
}
