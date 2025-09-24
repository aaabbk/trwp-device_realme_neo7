#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit from ossi device
$(call inherit-product, device/oplus/ossi/device.mk)

PRODUCT_DEVICE := ossi
PRODUCT_NAME := twrp_neo7
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX5060
PRODUCT_MANUFACTURER := realme

PRODUCT_GMS_CLIENTID_BASE := android-oplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="hal_mgvi_64_armv82-user 14 UKQ1.231108.001 1755266220662 release-keys"

BUILD_FINGERPRINT := oplus/ossi/ossi:14/UKQ1.231108.001/1755266220662:user/release-keys
