#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

LOCAL_PATH := device/oplus/ossi

# 基本产品配置
PRODUCT_DEVICE := ossi
PRODUCT_NAME := twrp_Neo7
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX5060
PRODUCT_MANUFACTURER := realme

# 架构支持
PRODUCT_AAPT_CONFIG := normal
PRODUCT_AAPT_PREF_CONFIG := xxhdpi

# A/B
AB_OTA_UPDATER := true
AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/otapreopt_script \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_system=true \
    POSTINSTALL_PATH_system=system/bin/mtk_plpath_utils \
    FILESYSTEM_TYPE_system=ext4 \
    POSTINSTALL_OPTIONAL_system=true

AB_OTA_POSTINSTALL_CONFIG += \
    RUN_POSTINSTALL_vendor=true \
    POSTINSTALL_PATH_vendor=bin/checkpoint_gc \
    FILESYSTEM_TYPE_vendor=ext4 \
    POSTINSTALL_OPTIONAL_vendor=true

# Boot control HAL
PRODUCT_PACKAGES += \
    android.hardware.boot-service.mtk_recovery \
    android.hardware.boot@1.0 \
    android.hardware.boot@1.1 \
    android.hardware.boot@1.2

PRODUCT_PACKAGES += \
    bootctrl.common

# Vendor Boot 支持（关键添加）
PRODUCT_PACKAGES += \
    vendor_bootimage

# 恢复模式工具
PRODUCT_PACKAGES += \
    otapreopt_script \
    cppreopts.sh \
    update_engine \
    update_verifier \
    update_engine_sideload

# 动态分区
PRODUCT_USE_DYNAMIC_PARTITIONS := true

# Soong 命名空间
PRODUCT_SOONG_NAMESPACES += $(LOCAL_PATH)

# 构建属性
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="ossi-user 14 UKQ1.231108.001 1755266220662 release-keys"

PRODUCT_GMS_CLIENTID_BASE := android-oppo