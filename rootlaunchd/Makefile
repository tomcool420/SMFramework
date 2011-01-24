include $(THEOS)/makefiles/common.mk

TOOL_NAME = smfrootlaunchd
smfrootlaunchd_FILES = main.mm
smfrootlaunchd_INSTALL_PATH = /usr/bin
smfrootlaunchd_LDFLAGS= -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/tool.mk

after-smfrootlaunchd-stage::   
	 $(FAKEROOT) chmod 755 $(FW_STAGING_DIR)/usr/bin/smfrootlaunchd
#	 $(FAKEROOT) chmod u+s $(FW_STAGING_DIR)/usr/bin/SMFHelper
	 $(FAKEROOT) chown root:wheel $(FW_STAGING_DIR)/usr/bin/smfrootlaunchd