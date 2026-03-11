# OrangeFox (TWRP) device tree for Motorola Moto G56 5G (bogota)

Officially released on May 29 2025

# Maintainers
~~- [TeamWin Recovery Project](https://github.com/TeamWin) - developer manifest~~
~~- [OrangeFox Recovery Project](https://gitlab.com/OrangeFox) - developer manifest~~
~~- [Cloud](https://github.com/DeviceTree) - Device owner and developer~~

# Motorola G56 5G
<p align="left" width="100%">
<img width="33%" src="https://fdn2.gsmarena.com/vv/pics/motorola/motorola-moto-g56-1.jpg">
</p>




# Device Specifications

| Basic                        | Spec Sheet                                                                    |
| ---------------------------: | :-----------------------------------------------------------------------------|
| Chipset                      | Mediatek Dimensity 7060 (MT6855)                                              |
| CPU                          | Octa-core (2x2.6 GHz Cortex-A78 & 6x2.0 GHz Cortex-A55)                       |
| GPU                          | IMG BXM-8-256                                                                 |
| Memory                       | 4/8/12 GB RAM                                                                 |
| Shipped OS                   | Android 15                                                                    |
| Storage                      | 128/256/512 GB (UFS 2.1)                                                      |
| SIM                          | dual Nano-SIM, eSIM                                                           |
| MicroSD                      | No                                                                            |
| Battery                      | 5200mAh Li-ion (non-removable), 30W fast charge                               |
| Dimensions                   | 165.8 x 76.3 x 8.4 mm (6.53 x 3.00 x 0.33 in)                                 |
| Display                      | 6.72" 2400x1080 pixels, 20:9 ratio, 120Hz (~392 ppi)                          |
| Rear Camera 1                | 50 MP, f/1.8 PDAF                                                             |
| Rear Camera 2                | 8 MP, f/2.2 (ultrawide)                                                       |
| Front Camera                 | 32 MP, f/2.2                                                                  |
| Fingerprint                  | side-mounted (power button)                                                   |
| Sensors                      | accelerometer, gyroscope, light sensor, proximity sensor, compass             |
| Extras                       | Dual speakers, NFC, HDR10+ support, Always on Display, 3.5mm audio jack       |





# Checks
Blocking checks
- [✔] Correct screen/recovery size
- [✔] Working Touch, screen
- [✖] Backup to internal/microSD (No SD card slot)
- [✖] Restore from internal/microSD (No SD card slot)
- [✔] reboot to system
- [✔] ADB

Medium checks
- [✔] update.zip sideload
- [✔] UI colors (red/blue inversions)
- [✔] Screen goes off and on
- [✔] F2FS/EXT4 Support, exFAT/NTFS where supported
- [✔] all important partitions listed in mount/backup lists
- [✖] backup/restore to/from external (USB-OTG) storage
- [✔] decrypt /data
- [✖] Correct date
- [✖] USB-OTG (flash drive)

Minor checks
- [✖] MTP export
- [✔] reboot to bootloader
- [✔] reboot to recovery
- [✔] poweroff
- [✔] battery level
- [✖] temperature (thermal zone not available during recovery)
- [✖] encrypted backups
- [✖] input devices via USB (USB-OTG) - keyboard and mouse
- [✖] USB mass storage export
- [✔] set brightness
- [✖] vibrate
- [✔] screenshot
- [✖] partition SD card (No SD card slot)
- [✔] Fastbootd

## To Build with OrangeFox manifest
**Clone manifest ofrp-12.1**
```bash
sudo apt install git
sudo apt install repo
sudo apt install git aria2 -y
git clone https://gitlab.com/OrangeFox/misc/scripts
cd scripts
sudo bash setup/android_build_env.sh
sudo bash setup/install_android_sdk.sh
```
**Sync manifest ofrp-12.1**
```bash
mkdir ~/OrangeFox_sync
cd ~/OrangeFox_sync
git clone https://gitlab.com/OrangeFox/sync.git
cd ~/OrangeFox_sync/sync/
./orangefox_sync.sh --branch 12.1 --path ~/fox_12.1
```
**Cloning the device tree**
```bash
cd ~/fox_12.1
git clone https://github.com/DeviceTree/android_device_motorola_bogota.git -b twrp-12.1 device/motorola/bogota
```
**Build**
```bash
build/envsetup.sh; lunch twrp_bogota-eng && mka adbd vendorbootimage
```
## To Build with TeamWin manifest (Not Reccomended/Broken)
**Clone manifest twrp-12.1**
```bash
sudo apt install git
sudo apt install repo
mkdir ~/twrp_12.1
cd ~/twrp_12.1
repo init -u https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp -b twrp-12.1
```
**Sync manifest twrp-12.1**
```bash
repo sync
```
**Cloning the device tree**
```bash
cd ~/twrp_12.1
git clone https://github.com/DeviceTree/android_device_motorola_bogota.git -b twrp-12.1 device/motorola/bogota
```
**Build**
```bash
export ALLOW_MISSING_DEPENDENCIES=true; . build/envsetup.sh; lunch twrp_bogota-eng
mka vendorbootimage
```
## Common Fixes
- Terminal Closing after 2 Minutes: run this command to disable systemd-oomd which causes Terminal to close if high memory usage (Ubuntu 22.04 and Later)
```bash
systemctl disable --now systemd-oomd
```
To check if it worked run this command
```bash
systemctl is-enabled systemd-oomd
```
The output should be
```bash
disabled
```
