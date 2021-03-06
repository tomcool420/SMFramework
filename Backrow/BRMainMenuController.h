/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import "BRController.h"

@class NSMutableArray, NSArray, BRMainMenuControl, BRBackgroundTask;
@protocol BRAppliance;

@interface BRMainMenuController : BRController {
@private
	NSArray *_applianceInfos;	// 60 = 0x3c
	NSMutableArray *_topShelfControllers;	// 64 = 0x40
	BRMainMenuControl *_browser;	// 68 = 0x44
	BOOL _enabled;	// 72 = 0x48
	BOOL _handlingMainMenuEvent;	// 73 = 0x49
	BRBackgroundTask *_topShelfRefreshTask;	// 76 = 0x4c
}
@property(readonly, assign) id<BRAppliance> currentAppliance;	// G=0x34cdc389; 
+ (BOOL)handlingMainMenuEvent;	// 0x34cdbf4d
+ (void)highlightApplianceWithKey:(id)key andCategoryWithIdentifier:(id)identifier;	// 0x34cdbecd
+ (void)setHandlingMainMenuEvent:(BOOL)event;	// 0x34cdbfbd
- (id)init;	// 0x34cdc031
- (BOOL)_browserItemSelected:(id)selected;	// 0x34cdc899
- (BOOL)_handlingMainMenuEvent;	// 0x34cdc965
- (void)_highlightApplianceWithKey:(id)key andCategoryWithIdentifier:(id)identifier;	// 0x34cdc871
- (void)_loadAppliances;	// 0x34cdc725
- (void)_reloadTopShelvesByRecreating:(BOOL)recreating;	// 0x34cdc9f9
- (void)_setHandlingMainMenuEvent:(BOOL)event;	// 0x34cdc975
- (void)_shelfNoLongerFocusable:(id)focusable;	// 0x34cdc985
- (void)_topShelfControllerWillBeHidden:(id)_topShelfController;	// 0x34cdcc4d
- (void)_topShelfControllerWillBeShown:(id)_topShelfController;	// 0x34cdcc11
- (id)accessibilityLabel;	// 0x34cdc3a9
- (BOOL)canBeRemovedFromStack;	// 0x34cdc219
- (void)clearRemembery;	// 0x34cdc369
- (void)controlWasActivated;	// 0x34cdc605
- (void)controlWasDeactivated;	// 0x34cdc6b1
// declared property getter: - (id)currentAppliance;	// 0x34cdc389
- (void)dealloc;	// 0x34cdc159
- (void)enable;	// 0x34cdc21d
- (void)mainMenu:(id)menu didSelectCategoryAtIndexPath:(id)indexPath;	// 0x34cdc44d
- (id)mainMenu:(id)menu shelfForApplianceAtIndex:(unsigned)index;	// 0x34cdc3d1
- (void)mainMenu:(id)menu willHideShelfAtApplianceIndex:(long)applianceIndex;	// 0x34cdc595
- (void)mainMenu:(id)menu willShowShelfAtApplianceIndex:(long)applianceIndex;	// 0x34cdc5cd
- (void)reloadMainMenu;	// 0x34cdc22d
@end

