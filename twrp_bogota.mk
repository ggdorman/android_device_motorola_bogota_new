# ========================================
# Inclusions
# ========================================
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, device/motorola/bogota/device.mk)
$(call inherit-product, vendor/twrp/config/common.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/emulated_storage.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/developer_gsi_keys.mk)

# ========================================
# Variables
# ========================================
PRODUCT_GMS_CLIENTID_BASE := android-motorola
PRODUCT_DEVICE := bogota
PRODUCT_NAME := twrp_bogota
PRODUCT_BRAND := motorola
PRODUCT_MODEL := moto g56 5g
PRODUCT_MANUFACTURER := motorola

# ========================================
# Property overrides
# ========================================
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true \
    persist.sys.fuse.passthrough.enable=true
