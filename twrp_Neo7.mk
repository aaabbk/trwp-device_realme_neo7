#
# Copyright (C) 2025 The Android Open Source Project
# Copyright (C) 2025 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from common AOSP config
	$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
	$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)
	$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# Inherit from TWRP product configuration
	$(call inherit-product, vendor/twrp/config/common.mk)

# Device specific configs
	$(call inherit-product, device/oplus/ossi/device.mk)

PRODUCT_DEVICE := ossi
PRODUCT_NAME := twrp_Neo7
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX5060
PRODUCT_MANUFACTURER := realme

PRODUCT_PROPERTY_OVERRIDES += ro.twrp.vendor_boot=true