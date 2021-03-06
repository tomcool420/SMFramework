/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import "ATVMusicStoreCatalogItemController.h"

@class NSNumber, BRMediaListControl, NSDictionary;

__attribute__((visibility("hidden")))
@interface ATVMusicStoreCatalogCollectionController : ATVMusicStoreCatalogItemController {
@private
	BRMediaListControl *_mediaListControl;	// 68 = 0x44
	NSDictionary *_itemToPlayWhenRentalQueryCompletes;	// 72 = 0x48
	ATVMediaQueryRef _rentalQuery;	// 76 = 0x4c
	BOOL _rentalQueryComplete;	// 80 = 0x50
	NSNumber *_seasonID;	// 84 = 0x54
}
- (id)initWithItemDictionary:(id)itemDictionary;	// 0x34c1f035
- (void)_blueDotInfoChanged;	// 0x34c1f755
- (BOOL)_checkForItemsRented;	// 0x34c1fd21
- (id)_favorite;	// 0x34c1fa25
- (void)_favoriteItemsChanged:(id)changed;	// 0x34c1f775
- (void)_getBlueDotCount:(long *)count nonBlueDotCount:(long *)count2 withProvider:(id)provider;	// 0x34c204f5
- (void)_getEpisodeForSelectedItem:(id *)selectedItem andProvider:(id *)provider;	// 0x34c20425
- (void)_highlightFirstNonHeaderRow;	// 0x34c1f7d9
- (BOOL)_highlightItemSelectedByUser;	// 0x34c1f795
- (void)_markAllAsWatched:(BOOL)watched;	// 0x34c20b09
- (void)_markSelectedEpisodeAsWatched:(BOOL)watched;	// 0x34c209b1
- (id)_providerForSelectedItem;	// 0x34c204d1
- (void)_pushEpisodeForUserSelectedItem;	// 0x34c1f901
- (void)_rentalQueryComplete;	// 0x34c2010d
- (id)_userSelectedItemWithListIndex:(long *)listIndex;	// 0x34c1fa59
- (id)accessibilityLabel;	// 0x34c1f6b9
- (id)accessibilitySecondaryLabel;	// 0x34c1f6d9
- (void)controlWasActivated;	// 0x34c1f671
- (void)dealloc;	// 0x34c1f559
- (id)episodeForSelectedItem;	// 0x34c1f6f9
- (void)markAsUnwatched;	// 0x34c20af1
- (void)markAsWatched;	// 0x34c20ad9
- (void)markSeasonAsUnwatched;	// 0x34c20d0d
- (void)markSeasonAsWatched;	// 0x34c20cf5
- (void)playStoreItemWhenRentalQueryCompletes:(id)completes;	// 0x34c1f71d
- (id)providersForContextMenu;	// 0x34c205b1
- (void)relatedContentLoaded:(id)loaded;	// 0x34c1f6b5
- (void)wasExhumed;	// 0x34c1f635
- (void)wasPushed;	// 0x34c1f5f9
@end

