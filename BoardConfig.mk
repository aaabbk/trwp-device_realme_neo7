#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

DEVICE_PATH := device/oplus/ossi

# For building with minimal manifest
ALLOW_MISSING_DEPENDENCIES := true

# A/B
AB_OTA_PARTITIONS := \
    boot \
    init_boot \
    vendor_boot \
    dtbo \
    odm \
    product \
    system \
    system_ext \
    system_dlkm \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_dlkm

# AB partitions for oplus
AB_OTA_PARTITIONS += \
    my_bigball \
    my_carrier \
    my_company \
    my_engineering \
    my_heytap \
    my_manifest \
    my_preload \
    my_product \
    my_region \
    my_stock

# Hardware
BOARD_USES_MTK_HARDWARE := true

# Platform
TARGET_BOARD_PLATFORM := mt6989

# Architecture
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := 
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := cortex-a55

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv7-a-neon
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := cortex-a55

# APEX
DEXPREOPT_GENERATE_APEX_IMAGE := true

# Bootloader
TARGET_BOOTLOADER_BOARD_NAME := ossi
TARGET_NO_BOOTLOADER := true

# Display
TARGET_SCREEN_DENSITY := 480

# Kernel
BOARD_BOOTIMG_HEADER_VERSION := 4
BOARD_KERNEL_BASE := 0x3fff8000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2
BOARD_KERNEL_PAGESIZE := 4096
BOARD_RAMDISK_OFFSET := 0x26f08000
BOARD_KERNEL_TAGS_OFFSET := 0x07c88000
BOARD_MKBOOTIMG_ARGS += --header_version $(BOARD_BOOTIMG_HEADER_VERSION)
BOARD_MKBOOTIMG_ARGS += --ramdisk_offset $(BOARD_RAMDISK_OFFSET)
BOARD_MKBOOTIMG_ARGS += --tags_offset $(BOARD_KERNEL_TAGS_OFFSET)
BOARD_KERNEL_IMAGE_NAME := Image

# Kernel
TARGET_KERNEL_ARCH := arm64
BOARD_RAMDISK_USE_LZ4 := true
TARGET_KERNEL_HEADER_ARCH := arm64

TARGET_NO_KERNEL := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 67108864
BOARD_HAS_LARGE_FILESYSTEM := true
BOARD_SYSTEMIMAGE_PARTITION_TYPE := ext4
BOARD_USERDATAIMAGE_FILE_SYSTEM_TYPE := ext4
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4
TARGET_COPY_OUT_VENDOR := vendor

# Platform
TARGET_BOARD_PLATFORM := mt6989

# Recovery
TARGET_RECOVERY_PIXEL_FORMAT := BGRA_8888
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true

# Verified Boot
BOARD_AVB_ENABLE := true
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3

# Hack: prevent anti rollback
PLATFORM_SECURITY_PATCH := 2099-12-31
VENDOR_SECURITY_PATCH := 2099-12-31
PLATFORM_VERSION := 16.1.0

# Treble
BOARD_VNDK_VERSION := current

# 启用 vendor_boot 架构
TARGET_NO_RECOVERY := true
TARGET_USES_UEFI := true
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# vendor_boot 分区设置
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864  # 64MB
BOARD_RAMDISK_USE_LZ4 := true

# 内核配置（用于 vendor_boot）
TARGET_NO_KERNEL := true
TARGET_KERNEL_ARCH := arm64
TARGET_KERNEL_HEADER_ARCH := arm64

# TWRP 在 vendor_boot 中的功能支持
TW_LOAD_VENDOR_BOOT_MODULES := true
TW_PREPARE_DATA_MEDIA_EARLY := true
TW_EXCLUDE_DEFAULT_USB_INIT := true

# vendor_boot 镜像构建参数
BOARD_BOOT_HEADER_VERSION := 4
BOARD_PAGE_SIZE := 4096

#Vendor_boot recovery ramdisk
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true # 将recovery文件复制到vendor_boot

# 确保内核模块从 vendor_boot 加载
BOARD_VENDOR_RAMDISK_RECOVERY_KERNEL_MODULES_LOAD := true

#TWRP Configurations
TW_DEFAULT_LANGUAGE := zh_CN
TW_EXTRA_LANGUAGES := true
TW_THEME := portrait_hdpi
TW_INCLUDE_FASTBOOTD := true

TARGET_PREBUILT_DTB :=$(DEVICE_PATH)/prebuilt/dtb
BOARD_MKBOOTIMG_ARGS += --dtb $(TARGET_PREBUILT_DTB)# Partitions
BOARD_FLASH_BLOCK_SIZE := 262144 # (BOARD_KERNEL_PAGESIZE * 64)
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864 # boot/recovery/vendor_boot镜像的字节大小需原厂或手机完整提取出来的，不定义会报错

BOARD_KERNEL_SEPARATED_DTBO := true

# Device Fstab
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/root/system/etc/recovery.fstab