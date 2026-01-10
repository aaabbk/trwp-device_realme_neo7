#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# 继承基础配置（TWRP 专用）
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)

# 继承设备配置
$(call inherit-product, device/oplus/ossi/device.mk)

# 尝试继承 TWRP 通用配置
ifneq ($(wildcard vendor/omni/config/common.mk),)
    $(call inherit-product, vendor/omni/config/common.mk)
else
    # 如果 vendor/omni 不存在，提供最小化 TWRP 配置
    PRODUCT_PACKAGES += \
        recovery \
        twrpdecrypt
endif

# 产品标识（必须与文件名匹配）
PRODUCT_DEVICE := ossi
PRODUCT_NAME := twrp_Neo7  # 必须与文件名一致
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX5060
PRODUCT_MANUFACTURER := realme

# 构建属性
PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="hal_mgvi_64_armv82-user 14 UKQ1.231108.001 1755266220662 release-keys"

BUILD_FINGERPRINT := oplus/ossi/ossi:14/UKQ1.231108.001/1755266220662:user/release-keys