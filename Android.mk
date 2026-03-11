# Set Local_path
LOCAL_PATH := $(call my-dir)

# Check if target device is codename bogota
ifeq ($(TARGET_DEVICE),bogota)
    include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
