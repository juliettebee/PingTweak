INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk
TARGET = iphone:clang:13.5

ARCHS = arm64 arm64e

TWEAK_NAME = Ping

Ping_FILES = Tweak.x
Ping_CFLAGS = -fobjc-arc
include $(THEOS_MAKE_PATH)/tweak.mk
Ping_FRAMEWORKS += UIKit

SUBPROJECTS += ping
include $(THEOS_MAKE_PATH)/aggregate.mk
