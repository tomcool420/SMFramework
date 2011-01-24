GO_EASY_ON_ME=1
include $(THEOS)/makefiles/common.mk

TOOL_NAME = smfporttester
smfporttester_FILES = main.mm
smfporttester_INSTALL_PATH = /usr/bin
smfporttester_LDFLAGS= -undefined dynamic_lookup

include $(THEOS_MAKE_PATH)/tool.mk

after-smfporttester-stage::   
	 $(FAKEROOT) chmod 755 $(FW_STAGING_DIR)/usr/bin/smfrootlaunchd
#	 $(FAKEROOT) chmod u+s $(FW_STAGING_DIR)/usr/bin/SMFHelper
	 $(FAKEROOT) chown root:wheel $(FW_STAGING_DIR)/usr/bin/smfrootlaunchd