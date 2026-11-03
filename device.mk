#
# device.mk - realme Neo7 (RE6022L1 / MT6989)
#
LOCAL_PATH := device/realme/RE6022L1

# ---------------------------------------------------------------- API 级别
# 设备实测是 Android 14（ro.build.version.sdk=34），但 **TWRP 12.1 的构建基线是 SDK 32**，
# 其 BOARD_SYSTEMSDK_VERSIONS 默认 32。若这里写 34，build/make/core/config.mk 会直接报：
#   BOARD_SYSTEMSDK_VERSIONS (32) must all be greater than or equal to
#   PRODUCT_SHIPPING_API_LEVEL (34)
# 因此构建期用 32（只影响 ro.product.first_api_level，对 recovery 无实际影响）。
PRODUCT_SHIPPING_API_LEVEL := 32

# ---------------------------------------------------------------- A/B & VAB
# 分区名取自实测分区表（1.txt）与原厂 fstab。
# 注：init_boot 虽是 A/B 分区，但 MTK 参考树未把它列入 AB_OTA_PARTITIONS；
#     若要让 OTA 更新 init_boot，再自行加回 `init_boot \`。
AB_OTA_PARTITIONS += \
    boot \
    dtbo \
    odm \
    odm_dlkm \
    product \
    system \
    system_ext \
    vbmeta \
    vbmeta_system \
    vbmeta_vendor \
    vendor \
    vendor_boot \
    vendor_dlkm

# ---------------------------------------------------------------- 动态分区
# 只构建 recovery（mka vendorbootimage）时不需要；
# 若要构建完整 system/OTA，取消注释并在 BoardConfig.mk 补上 super 组大小。
# PRODUCT_USE_DYNAMIC_PARTITIONS := true

# ---------------------------------------------------------------- OTA / VAB 组件
# 用于 TWRP 内 sideload 官方 OTA。若不需要可整段注释以减小体积。
PRODUCT_PACKAGES += \
    checkpoint_gc \
    update_engine \
    update_engine_sideload \
    update_verifier
