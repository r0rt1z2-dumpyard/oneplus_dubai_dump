#
# Copyright (C) 2023 The Android Open Source Project
# Copyright (C) 2023 SebaUbuntu's TWRP device tree generator
#
# SPDX-License-Identifier: Apache-2.0
#

# Inherit from those products. Most specific first.
$(call inherit-product, $(SRC_TARGET_DIR)/product/full_base_telephony.mk)

# Inherit some common Omni stuff.
$(call inherit-product, vendor/omni/config/common.mk)

# Inherit from Dubai device
$(call inherit-product, device/oneplus/Dubai/device.mk)

PRODUCT_DEVICE := Dubai
PRODUCT_NAME := omni_Dubai
PRODUCT_BRAND := OnePlus
PRODUCT_MODEL := D00
PRODUCT_MANUFACTURER := oneplus

PRODUCT_GMS_CLIENTID_BASE := android-oneplus

PRODUCT_BUILD_PROP_OVERRIDES += \
    PRIVATE_BUILD_DESC="OnePlusTV-user 11 RTM1.210315.027 2211042104 release-keys"

BUILD_FINGERPRINT := OnePlus/OnePlusTV/Dubai:11/RTM1.210315.027/2211042104:user/release-keys
