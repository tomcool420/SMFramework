GO_EASY_ON_ME=1
SDKVERSION=4.2
#FW_DEVICE_IP=test.local
FW_DEVICE_IP=appletv.local
first: clean package install
include $(THEOS)/makefiles/common.mk

FRAMEWORK_NAME = SMFramework
SMFramework_FILES = SMFMediaMenuController.m SMFMenuController.m SMFCenteredMenuController.m SMFFolderBrowser.m SMFMediaPreview.mm SMFBaseAsset.m SMFPasscodeController.m 
SMFramework_FILES += BRMenuItem_SMF.m SMFInvocationCenteredMenuController.m SMFMenuItem.m SMFScreenCapture.m SMFThemeInfo.m SMFClockController.m
SMFramework_FILES += SMFEventManager.m SMFEvent.m SMFEventConfiguration.m SMFMovieAsset.m
SMFramework_FILES += SMFPhotoMethods.mm SMFQueryMenu.m SMFProgressBarControl.m SMFPopup.xm SMFCommonTools.m SMFColorSelectionMenu.m 
SMFramework_FILES += SMFPreferences.m SMFProgressBarMenuItem.m SMFImageAsset.m SMFDebAsset.m
SMFramework_FILES += NSArray_SMF.m SMFViewMenuController.m SMFListDropShadowControl.m SMFControllerPasscodeController.m SMFTextDropShadowControl.mm
SMFramework_FILES += Example/SMFGridController.m SMFMoviePreviewController.m SMFControlFactory.m SMFAssetPreviewController.m SMFPhotoMediaAsset.m
SMFramework_FILES += SMFBookcaseController.m SMFBookcaseDelegateAndDatasourceExample.m SMFComplexDropShadowControl.mm
SMFramework_INSTALL_PATH = /Library/Frameworks
#SMFramework_BUNDLE_EXTENSION = framework
SMFramework_LDFLAGS = -undefined dynamic_lookup -framework UIKit -framework ImageIO#-L$(FW_PROJECT_DIR) -lBackRow
SMFramework_CFLAGS = -I../ATV2Includes
SUBPROJECTS = eventcatcher 



include $(FW_MAKEDIR)/framework.mk
include $(FW_MAKEDIR)/aggregate.mk
after-install::
	ssh root@$(FW_DEVICE_IP) killall AppleTV
	
after-SMFramework-stage::
	rm -rf "Headers"
	mkdir "Headers"
	cp *.h "Headers/"
	mkdir "$(FW_SHARED_BUNDLE_RESOURCE_PATH)/Headers"
	cp *.h "$(FW_SHARED_BUNDLE_RESOURCE_PATH)/Headers/"
	rm -rf ../ATV2Includes/SMFramework
	mkdir ../ATV2Includes/SMFramework
	cp -rf Headers/ ../ATV2Includes/SMFramework/