# Copyright (C) 2010 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

#
# MStar smart TV Virtual Device configuration file.
#

# for fix num button wake up TV issue before suspend.
device.internal= 1

touch.deviceType = touchScreen
touch.orientationAware = 1

keyboard.layout = Vendor_0094_Product_0001
keyboard.characterMap = qwerty
keyboard.orientationAware = 1
keyboard.builtIn = 0

# add # for fix BT reconnect issue.
#cursor.mode = navigation
cursor.orientationAware = 1

#add support voice search attribute
audio.mic = 1
