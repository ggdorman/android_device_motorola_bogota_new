# ========================================
# Build Rules
# ========================================
DEVICE_PATH := device/motorola/bogota
ALLOW_MISSING_DEPENDENCIES := true
BUILD_BROKEN_DUP_RULES := true
BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# ========================================
# Architecture Info
# ========================================
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
# TODO: Or this because device is 8.2a?
#TARGET_ARCH_VARIANT := armv8-2a
TARGET_CPU_ABI := arm64-v8a
# why variant generic then runtime is cortex?
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55
TARGET_KERNEL_ARCH := $(TARGET_ARCH)
TARGET_KERNEL_HEADER_ARCH := $(TARGET_ARCH)

TARGET_2ND_ARCH := arm
# TODO: Remove old value below?
# TARGET_2ND_ARCH_VARIANT := armv8-2a
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55
TARGET_BOARD_SUFFIX := _64

# TODO: Extras from guide - likely not needed?
TARGET_SUPPORTS_64_BIT_APPS := true
TARGET_IS_64_BIT := true

# CPU boost
ENABLE_CPUSETS := true
ENABLE_SCHEDBOOST := true

# ========================================
# Touch Screen and Other Modules
# ========================================

# TODO: Many devices have these drivers, when the touchscreen driver is located directly in the kernel. So there is no need to add.
# Removed: focaltech_0flash_mmi_v3.ko ilitek_v3_mmi.ko
TW_LOAD_VENDOR_MODULES := "chipone_tddi_mmi_v2.ko hf_manager.ko flashlight.ko flashlights-bogota-aw36515.ko flashlights-ocp81375.ko mtk-sp-spk-amp.ko leds-gpio.ko mt6855-mt6369.ko qpnp_adaptive_charge.ko ccci_auxadc.ko"
TW_SUPPORT_INPUT_AIDL_HAPTICS := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FIX_OFF := true
TW_SUPPORT_INPUT_AIDL_HAPTICS_FQNAME := "android.hardware.vibrator@2::IVibrator/default"

# ========================================
# Variables (Device-Specific)
# ========================================
TARGET_OTA_ASSERT_DEVICE := bogota
TARGET_BOARD_PLATFORM := mt6855
# TODO: should be good (otherwise prop.default ro.vendor.mgvi_name= mgvi_64_ww_armv82)
TARGET_BOOTLOADER_BOARD_NAME := bogota
TARGET_NO_BOOTLOADER := true
TARGET_USES_UEFI := true
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab
# TODO: fix mt6855 file below
TARGET_RECOVERY_INITRC := $(DEVICE_PATH)/recovery/root/init.recovery.mt6855.rc
TARGET_SYSTEM_PROP += $(DEVICE_PATH)/system.prop
TW_SKIP_ADDITIONAL_FSTAB := true

# ========================================
# MTK Hardware Support
# ========================================
BOARD_HAS_MTK_HARDWARE := true
BOARD_USES_MTK_HARDWARE := true
MTK_HARDWARE := true # from guide, redundant?
TW_USE_MODEL_HARDWARE_ID_FOR_DEVICE_ID := true

# ========================================
# Vendor_Boot Image Config
# ========================================
BOARD_KERNEL_SEPARATED_DTBO := true

# Not required for recovery as vendor_boot
TARGET_NO_KERNEL := true
# TODO: then why exists?

# Vendor_Boot Offsets
BOARD_VENDOR_CMDLINE := bootopt=64S3,32N2,64N2 # actual 'bootopt=64S3,32N2,64N2 loglevel=4 initcall_debug=0' fails to build
BOARD_PAGE_SIZE := 4096 # good
# BOARD_KERNEL_PAGESIZE := 4096 # NEW flag from twrpdtgen, needs checking
BOARD_BOOT_HEADER_VERSION := 4 # good
BOARD_HEADER_SIZE := 2128 # good
BOARD_FLASH_BLOCK_SIZE := 262144 # good (twrpdtgen)
TARGET_PREBUILT_DTB := $(DEVICE_PATH)/prebuilt/dtb
BOARD_PREBUILT_BOOTIMAGE := $(DEVICE_PATH)/prebuilt/boot.img
BOARD_DTB_SIZE := $(stat -L -c %s $(TARGET_PREBUILT_DTB))
BOARD_DTB_OFFSET := 0x07c88000 # good
BOARD_KERNEL_OFFSET := 0x00008000 # good
BOARD_RAMDISK_OFFSET := 0x26f08000 # good
BOARD_TAGS_OFFSET := 0x07c88000 # good
BOARD_KERNEL_BASE := 0x3fff8000 # # not output by unpackbootimg, twrpdtgen value, LLM value = 0x40000000
BOARD_VENDOR_BASE := 0x3fff8000 # good BUT NEW flag, needs checking
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864 # good

# Offsets implementation in new vendor_boot recovery image
BOARD_MKBOOTIMG_ARGS += \
    --dtb $(TARGET_PREBUILT_DTB) \
    --dtb_offset $(BOARD_DTB_OFFSET) \
    --vendor_cmdline $(BOARD_VENDOR_CMDLINE) \
    --pagesize $(BOARD_PAGE_SIZE) --board "" \
    --kernel_offset $(BOARD_KERNEL_OFFSET) \
    --ramdisk_offset $(BOARD_RAMDISK_OFFSET) \
    --tags_offset $(BOARD_TAGS_OFFSET) \
    --base $(BOARD_KERNEL_BASE) \
    --header_version $(BOARD_BOOT_HEADER_VERSION)

# Device does not use recovery image
TARGET_NO_RECOVERY := true

# GKI support
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# Vendor_boot ramdisk config
BOARD_RAMDISK_USE_LZ4 := true
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
BOARD_MOVE_GSI_AVB_KEYS_TO_VENDOR_BOOT := false
TW_LOAD_VENDOR_BOOT_MODULES := true

# ========================================
# Enforce VINTF Manifest(s)
# ========================================
PRODUCT_ENFORCE_VINTF_MANIFEST := true

# Device supports full treble
PRODUCT_FULL_TREBLE := true

# ========================================
# Partitions Config
# ========================================
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := f2fs
BOARD_USES_VENDOR_DLKMIMAGE := true
#TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Metadata partition support
BOARD_USES_METADATA_PARTITION := true
# BOARD_ROOT_EXTRA_FOLDERS += metadata # TODO: from guide, not included in vienna
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SUPPRESS_SECURE_ERASE := true

# Workaround for error copying vendor files to recovery ramdisk
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# ========================================
# Encryption / Decryption Support (FBE)
# ========================================
INCLUDE_CRYPTO := false
TW_INCLUDE_CRYPTO := $(INCLUDE_CRYPTO)
TW_INCLUDE_CRYPTO_FBE := $(INCLUDE_CRYPTO)
TW_INCLUDE_FBE := $(INCLUDE_CRYPTO)
TW_INCLUDE_FBE_METADATA_DECRYPT := $(INCLUDE_CRYPTO)
TW_USE_FSCRYPT_POLICY := 2 # good
RECOVERY_SDCARD_ON_DATA := true

# ========================================
# Anti-Rollback Bypass
# ========================================
PLATFORM_SECURITY_PATCH := 2099-12-31
BOOT_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
VENDOR_SECURITY_PATCH := $(PLATFORM_SECURITY_PATCH)
PLATFORM_VERSION := 99.87.36
PLATFORM_VERSION_LAST_STABLE := $(PLATFORM_VERSION)

# ========================================
# AVB (Android Verified Boot)
# ========================================
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
BOARD_AVB_VENDOR_BOOT_KEY_PATH := external/avb/test/data/testkey_rsa4096.pem # TODO: update key?
BOARD_AVB_VENDOR_BOOT_ALGORITHM := SHA256_RSA4096
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX := 1
BOARD_AVB_VENDOR_BOOT_ROLLBACK_INDEX_LOCATION := 1

# ========================================
# Display / UI
# ========================================
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TW_MAX_BRIGHTNESS := 2047
TW_DEFAULT_BRIGHTNESS := 1400
TW_FRAMERATE := 120
# TW_NO_CPU_TEMP := true # TODO: test

# ========================================
# TWRP Tools & Features Config
# ========================================
SIZE_REDUCTION_PLACEHOLDER := true # Local Placeholder

# Exclude default init.recovery.usb.rc from build
TW_EXCLUDE_DEFAULT_USB_INIT := true

# MTP support
TW_HAS_MTP := true
TW_USB_STORAGE := true

# Custom battery path
TW_CUSTOM_BATTERY_PATH := "/sys/devices/platform/smart_battery/power_supply/battery/capacity" # vienna path
#TW_CUSTOM_BATTERY_PATH := "/sys/class/power_supply/battery/capacity" # likely unnecessary (should be default path), doesn't work...
# TW_NO_BATT_PERCENT := true # if it ends up not working

# Blacklist fingerprint sensor
TW_INPUT_BLACKLIST := "hbtp_vm"

# TODO: then why include?
# Not needed
TW_EXCLUDE_APEX := true
TW_EXCLUDE_TWRPAPP := true

# Set recovery theme for mobile
TW_THEME := portrait_hdpi

# Extra languages support
TW_EXTRA_LANGUAGES := true

# Custom device version
TW_DEVICE_VERSION := v0.1.0 | ggdorman

# Toybox instead of Busybox
TW_USE_TOOLBOX := true

# MKE2FS support
TARGET_USES_MKE2FS := true

# Partition tools
TW_ENABLE_ALL_PARTITION_TOOLS := $(SIZE_REDUCTION_PLACEHOLDER)

# LogD + Logcat Implementation
TWRP_INCLUDE_LOGCAT := true
TWRP_EVENT_LOGGING := true
TARGET_USES_LOGD := true

# Extra logs
TARGET_RECOVERY_DEVICE_MODULES += strace
RECOVERY_BINARY_SOURCE_FILES   += $(TARGET_OUT_EXECUTABLES)/strace

# Framebuffer screenshot support
TW_INCLUDE_FB2PNG := $(SIZE_REDUCTION_PLACEHOLDER)

# Include NTFS file system support using ntfs-3g driver
TW_INCLUDE_NTFS_3G := $(SIZE_REDUCTION_PLACEHOLDER)

# Reset props inclusion
TW_INCLUDE_RESETPROP := $(SIZE_REDUCTION_PLACEHOLDER)
TW_INCLUDE_LIBRESETPROP := $(SIZE_REDUCTION_PLACEHOLDER)

# Magiskboot implementation
TW_INCLUDE_REPACKTOOLS := $(SIZE_REDUCTION_PLACEHOLDER)

# FastbootD implementation
TW_INCLUDE_FASTBOOTD := true

# Status bar config
TW_STATUS_ICONS_ALIGN := center
