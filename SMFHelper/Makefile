GO_EASY_ON_ME=1
export SDKVERSION=4.1
FW_DEVICE_IP=appletv.local
include ../theos/makefiles/common.mk
TOOL_NAME = SMFHelper
SMFHelper_FILES = smfHelper.m 
SMFHelper_INSTALL_PATH = /usr/bin
SMFHelper_CFLAGS = -I../../ATV2Includes
SMFHelper_LDFLAGS= -undefined dynamic_lookup

include $(FW_MAKEDIR)/tool.mk

after-SMFHelper-stage::   
	 $(FAKEROOT) chmod 4755 $(FW_STAGING_DIR)/usr/bin/SMFHelper
#	 $(FAKEROOT) chmod u+s $(FW_STAGING_DIR)/usr/bin/SMFHelper
	 $(FAKEROOT) chown root:wheel $(FW_STAGING_DIR)/usr/bin/SMFHelper