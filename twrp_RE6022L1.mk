#
# twrp_RE6022L1.mk - TWRP product definition for realme Neo7
#
LOCAL_PATH := device/realme/RE6022L1

# ---------------------------------------------------------------- AOSP 基础
$(call inherit-product, $(SRC_TARGET_DIR)/product/base.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit_only.mk)

# VAB + vendor_boot ramdisk 启动（与 BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT 配套）
$(call inherit-product, $(SRC_TARGET_DIR)/product/virtual_ab_ota/launch_with_vendor_ramdisk.mk)

# ---------------------------------------------------------------- TWRP 公共配置
# twrp-12.1 分支的继承路径是 vendor/twrp（不是 vendor/omni）
$(call inherit-product, vendor/twrp/config/common.mk)

# ---------------------------------------------------------------- 设备配置
$(call inherit-product, $(LOCAL_PATH)/device.mk)

# ---------------------------------------------------------------- 产品标识
PRODUCT_DEVICE := RE6022L1
PRODUCT_NAME := twrp_RE6022L1
PRODUCT_BRAND := realme
PRODUCT_MODEL := RMX5060
PRODUCT_MANUFACTURER := realme

# ---------------------------------------------------------------- TWRP 属性
# 告诉 TWRP 本机是 vendor_boot 方案（与 BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT 一致）
PRODUCT_PROPERTY_OVERRIDES += \
    ro.twrp.vendor_boot=true
