GO_EASY_ON_ME=1
export FW_DEVICE_IP=appletv.local
export SDKVERSION=4.1
include theos/makefiles/common.mk

TWEAK_NAME = EventCatcher
EventCatcher_FILES = Tweak.xm
EventCatcher_OBJ_FILES = ../obj/SMFramework
EventCatcher_LDFLAGS=-undefined dynamic_lookup
EventCatcher_CFLAGS=-I../../ATV2Includes
EventCatcher_PRIVATE_FRAMEWORKS=IOSurface

include $(FW_MAKEDIR)/tweak.mk
after-install::
	ssh root@$(FW_DEVICE_IP) killall Lowtide