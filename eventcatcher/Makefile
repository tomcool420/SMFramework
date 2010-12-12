GO_EASY_ON_ME=1
export FW_DEVICE_IP=appletv.local
export SDKVERSION=4.1
include theos/makefiles/common.mk

TWEAK_NAME = EventCatcher
EventCatcher_FILES = Tweak.xm
EventCatcher_OBJ_FILES = /Users/tomcool/DVLP/ATV2/SMFramework/obj/SMFramework
EventCatcher_LDFLAGS=-undefined dynamic_lookup

include $(FW_MAKEDIR)/tweak.mk
after-install::
	ssh root@$(FW_DEVICE_IP) killall Lowtide