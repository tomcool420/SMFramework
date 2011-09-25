/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import "BRMenuListItemProvider.h"
#import "BRMediaMenuController.h"

@class BRIconPreviewController, NSArray;

@interface BRSlideshowSettingsMusicController : BRMediaMenuController <BRMenuListItemProvider> {
@private
	NSArray *_playlistNames;	// 136 = 0x88
	long _currentSavedSelection;	// 140 = 0x8c
	BRIconPreviewController *_slideshowSettingsIconController;	// 144 = 0x90
	BOOL _isMusicAvailable;	// 148 = 0x94
}
- (id)init;	// 0x34d6ef9d
- (BOOL)_isMusicAvailable;	// 0x34d6f535
- (void)_pickSelectedSetting;	// 0x34d6f46d
- (long)_rowForTitle:(id)title;	// 0x34d6f409
- (void)dealloc;	// 0x34d6f18d
- (long)defaultIndex;	// 0x34d6f291
- (float)heightForRow:(long)row;	// 0x34d6f375
- (long)itemCount;	// 0x34d6f335
- (id)itemForRow:(long)row;	// 0x34d6f2b5
- (void)itemSelected:(long)selected;	// 0x34d6f1e5
- (id)previewControlForItem:(long)item;	// 0x34d6f37d
- (BOOL)rowSelectable:(long)selectable;	// 0x34d6f379
- (id)titleForRow:(long)row;	// 0x34d6f355
@end
