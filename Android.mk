#
# Android.mk - realme Neo7 (RE6022L1 / MT6989)
#
LOCAL_PATH := $(call my-dir)

ifeq ($(TARGET_DEVICE),RE6022L1)
include $(call all-subdir-makefiles,$(LOCAL_PATH))
endif
