GO_EASY_ON_ME=1
FW_DEVICE_IP=10.0.1.5
first: clean package install
include theos/makefiles/common.mk

FRAMEWORK_NAME = SMFramework
SMFramework_FILES = SMFMediaMenuController.m SMFCenteredMenuController.m SMFFolderBrowser.m SMFMediaPreview.mm SMFBaseAsset.m SMFPasscodeController.m SMFMenuController.m
SMFramework_FILES += BRMenuItem_SMF.m SMFInvocationCenteredMenuController.m SMFMenuItem.m SMFScreenCapture.m SMFThemeInfo.m SMFClockController.m
SMFramework_FILES += SMFEventManager.m SMFEvent.m SMFEventConfiguration.m
SMFramework_FILES += SMFPhotoMethods.mm SMFQueryMenu.m SMFProgressBarControl.m SMFPopup.xm SMFCommonTools.m #SMFInfoControl.mm 
SMFramework_INSTALL_PATH = /Library/Frameworks
#SMFramework_BUNDLE_EXTENSION = framework
SMFramework_LDFLAGS = -undefined dynamic_lookup -framework UIKit -framework ImageIO#-L$(FW_PROJECT_DIR) -lBackRow
SUBPROJECTS = eventcatcher



include $(FW_MAKEDIR)/framework.mk
include $(FW_MAKEDIR)/aggregate.mk
after-install::
	ssh root@$(FW_DEVICE_IP) killall Lowtide
	
after-SMFramework-stage::
	rm -rf "Headers"
	mkdir "Headers"
	cp *.h "Headers/"
	mkdir "$(FW_SHARED_BUNDLE_RESOURCE_PATH)/Headers"
	cp *.h "$(FW_SHARED_BUNDLE_RESOURCE_PATH)/Headers/"