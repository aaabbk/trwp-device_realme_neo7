#
# BoardConfig.mk - TWRP 12.1 for realme Neo7 (RMX5060 / RE6022L1 / MT6989)
#
# 事实来源：
#   1) 官方 vendor_boot.img 逐字节解析（header v4 / page_size 4096 / dtb 462480 B /
#      kernel_addr 0x40000000 / tags+dtb_addr 0x47c80000 / cmdline bootopt=64S3,32N2,64N2）
#   2) 1.txt 实测分区表（/dev/block/by-name + /proc/partitions）
#   3) .notes/twrp12-spec.md（TeamWin android-12.1 源码逐行核实）
#
# 方案结论：本机是 GKI 设备（boot 只含 kernel、init_boot 独立、vendor_boot v4，
#           且 vendor_boot 内含官方 recovery），AOSP build 硬性要求把 recovery 放进
#           vendor_boot，禁止 BOARD_USES_RECOVERY_AS_BOOT。
#

DEVICE_PATH := device/realme/RE6022L1

# ================================================================ 架构
TARGET_ARCH := arm64
TARGET_ARCH_VARIANT := armv8-a
TARGET_CPU_ABI := arm64-v8a
TARGET_CPU_ABI2 := armeabi-v7a
TARGET_CPU_VARIANT := generic
TARGET_CPU_VARIANT_RUNTIME := generic

TARGET_2ND_ARCH := arm
TARGET_2ND_ARCH_VARIANT := armv8-a
TARGET_2ND_CPU_ABI := armeabi-v7a
TARGET_2ND_CPU_ABI2 := armeabi
TARGET_2ND_CPU_VARIANT := generic
TARGET_2ND_CPU_VARIANT_RUNTIME := generic

TARGET_USES_64_BIT_BINDER := true
TARGET_SUPPORTS_64_BIT_APPS := true

# ================================================================ 平台 / 设备
# MediaTek MT6989（天玑 9300+），依据：
#   - dtb: androidboot.hardware=mt6989、mediatek,MT6989
#   - 官方 fstab/init.rc 的 mt6989/mtk-msdc 路径
#   - vendor_boot 内 270 个 .ko 全为 MTK 平台模块
TARGET_BOARD_PLATFORM := mt6989
TARGET_BOOTLOADER_BOARD_NAME := RE6022L1
TARGET_OTA_ASSERT_DEVICE := RE6022L1,RMX5060,ossi

# ---------------- MTK 平台显式声明 ----------------
# BOARD_USES_MTK_HARDWARE=true 让 TWRP 12.1 启用 MTK 特定处理
# （/dev/block/platform/mtk-msdc.0 等 MTK 块设备路径、MTK 亮度/分区处理）。
# 不声明时 TWRP 走通用路径，MTK 设备可能出现分区/亮度找不到的问题。
BOARD_USES_MTK_HARDWARE := true
BOARD_HAS_MTK_HARDWARE := true

# ================================================================ GKI / vendor_boot (header v4)
BOARD_BOOT_HEADER_VERSION := 4
BOARD_KERNEL_PAGESIZE := 4096
BOARD_KERNEL_BASE := 0x40000000
BOARD_KERNEL_CMDLINE := bootopt=64S3,32N2,64N2

# GKI 语义：recovery 不进 boot.img
BOARD_USES_GENERIC_KERNEL_IMAGE := true

# 把 recovery 资源放进 vendor_boot —— 本机唯一可行路线
BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT := true
# v4 设备：做成独立 recovery ramdisk 分片（TWRP 内 repack 依赖 vendor_ramdisk_recovery.cpio）
BOARD_INCLUDE_RECOVERY_RAMDISK_IN_VENDOR_BOOT := true

# 禁止：GKI 下与 BOARD_USES_RECOVERY_AS_BOOT 互斥（AOSP board_config.mk L931-946 直接报错）
# BOARD_USES_RECOVERY_AS_BOOT := true

# TWRP 的 vendor/twrp/build/tasks/kernel.mk:108 要求定义该变量（即使不打包 kernel）。
# 本机走 vendor_boot 方案、不含 kernel，这里只满足构建检查；aarch64 GKI 的镜像是 Image。
BOARD_KERNEL_IMAGE_NAME := Image

# 显式声明"无内核"：vendor_boot 方案不打包 kernel 与 boot.img，
# 避免 TWRP kernel.mk 继续要求 TARGET_PREBUILT_KERNEL / 内核源码。
TARGET_NO_KERNEL := true

# vendor_boot 必须打包官方 dtb（原样复用，不得重编）；
# AOSP 会用该目录生成 dtb.img 并通过 mkbootimg --dtb 打进 vendor_boot。
BOARD_PREBUILT_DTBIMAGE_DIR := $(DEVICE_PATH)/prebuilt-dtb

BOARD_MKBOOTIMG_ARGS += --header_version 4 --pagesize 4096

# ================================================================ 分区大小
# 实测（/proc/partitions，1 KiB blocks × 1024）
BOARD_BOOTIMAGE_PARTITION_SIZE := 67108864          # sdc41 boot_a        65536 KiB = 64 MiB
BOARD_VENDOR_BOOTIMAGE_PARTITION_SIZE := 67108864  # sdc42 vendor_boot_a  65536 KiB = 64 MiB
# 提示：TWRP 的 vendor_boot 若超过 64 MiB 会构建失败，届时需精简 ramdisk（去掉多余语言/工具）。
BOARD_INIT_BOOTIMAGE_PARTITION_SIZE := 8388608     # sdc43 init_boot_a     8192 KiB =  8 MiB
BOARD_DTBOIMG_PARTITION_SIZE := 8388608            # sdc44 dtbo_a          8192 KiB =  8 MiB

# ⚠ super / 动态分区：只构建 recovery 时不需要这些变量。
#   若要构建完整 system/OTA，先用 `lpdump /dev/block/by-name/super` 实测组名与大小，再取消注释。
# BOARD_SUPER_PARTITION_SIZE := 15569272832        # sdc91 super 15204352 KiB = 14.5 GiB
# BOARD_SUPER_PARTITION_GROUPS := realme_dynamic_partitions
# BOARD_REALME_DYNAMIC_PARTITIONS_SIZE := 15560851456
# BOARD_REALME_DYNAMIC_PARTITIONS_PARTITION_LIST := \
#     system system_ext product vendor odm \
#     vendor_dlkm odm_dlkm system_dlkm \
#     my_product my_engineering my_company my_carrier my_region \
#     my_heytap my_stock my_preload my_bigball my_manifest

# ================================================================ 文件系统 / 镜像
TARGET_USERIMAGES_USE_EXT4 := true
TARGET_USERIMAGES_USE_F2FS := true
TARGET_USES_MKE2FS := true
BOARD_USES_METADATA_PARTITION := true

# A/B + VAB（与官方 fstab 的 slotselect/checkpoint 一致）
AB_OTA_UPDATER := true

# ================================================================ AVB
# 本机已解锁（cmdline: oplusboot.verifiedbootstate=orange）。
# 默认不签名 vendor_boot，先走最简路径；若 bootloader 仍校验 vendor_boot，
# 需先刷 --flags 3 的 vbmeta（见 README-构建与刷入.md）。
BOARD_AVB_ENABLE := false
# 需要签名时取消注释（key 换成你自己的）：
# BOARD_AVB_ENABLE := true
# BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
# BOARD_AVB_ALGORITHM := SHA256_RSA2048
# BOARD_AVB_KEY_PATH := vendor/twrp/build/target/product/security/testkey

# ================================================================ Recovery
TARGET_RECOVERY_FSTAB := $(DEVICE_PATH)/recovery/twrp.fstab
TARGET_RECOVERY_PIXEL_FORMAT := RGBX_8888   # 花屏/偏色时改 BGRA_8888
TARGET_RECOVERY_DEVICE_DIRS += $(DEVICE_PATH)

# ================================================================ TWRP UI
TW_THEME := portrait_hdpi
TW_DEVICE_VERSION := TWRP-RE6022L1-12.1
TW_DEFAULT_LANGUAGE := zh_CN
TW_EXTRA_LANGUAGES := true

# 背光：实测 /sys/class/leds/lcd-backlight 存在，max_brightness = 4094
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 4094

# 内核模块（能开机的关键）：
#   本机 270 个 .ko 全部在官方 vendor_boot 的 /lib/modules（其中 modules.load.recovery
#   列出 recovery 阶段要加载的 260 个）。TWRP 构建出的 vendor_boot 不会自动继承它们，
#   所以已把原厂 lib/modules 整目录复制进 recovery/root/lib/modules/，构建后位于 ramdisk 的
#   /lib/modules —— AOSP init 在 recovery 模式会自动按 modules.load.recovery 加载。
#   TW_LOAD_VENDOR_BOOT_MODULES 作为第二道保险保留（重复 insmod 已加载模块只会报存在，不影响启动）。
TW_LOAD_VENDOR_BOOT_MODULES := true

# 体积预算（vendor_boot 分区 = 64 MiB）：
#   modules 9.5 MiB + 触摸固件 1.5 MiB + TWRP 基础 ramdisk 约 15~25 MiB（均 gzip 后估算）
#   ≈ 26~36 MiB，余量充足。若后续加入大量语言/主题导致超限，先精简 TW_EXTRA_LANGUAGES。

# fastbootd：vendor_boot 内已确认 android.hardware.fastboot@1.0-impl-mtk.so
TW_INCLUDE_FASTBOOTD := true

# 加密：首版关闭。12.1 不支持 FDE；MTK 上开 FBE 常导致 recovery 挂起（同平台 vivo 树实证）
TW_INCLUDE_CRYPTO := false
# TW_INCLUDE_CRYPTO_FBE := true

# 其它 TWRP 选项
TW_EXCLUDE_TWRPAPP := true
TW_INCLUDE_REPACKTOOLS := true   # 由 BOARD_MOVE_RECOVERY_RESOURCES_TO_VENDOR_BOOT 自动开启，显式声明便于排查
TW_USE_TOOLBOX := true

# 触摸：实测 event3 "touchpanel"（INPUT_PROP_DIRECT，X max 20224 / Y max 44480），无需黑名单。
# 若出现多节点干扰再启用：
# TW_INPUT_BLACKLIST := "uinput_nav;oplus_fp_input"

# 若黑屏但 adb 可用（MTK 常见），可试：
# TW_SCREEN_BLANK_ON_BOOT := true

# ================================================================ 最终覆盖（保持在文件末尾）
# TWRP 的 vendor/twrp/config/BoardConfigTWRP.mk 可能设置 AVB/CRYPTO 默认值，
# 在此再次声明以确保本机的取舍生效。
BOARD_AVB_ENABLE := false
TW_INCLUDE_CRYPTO := false
TW_LOAD_VENDOR_BOOT_MODULES := true
