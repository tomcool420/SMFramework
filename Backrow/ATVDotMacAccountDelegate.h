/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "ATVDotMacParserDelegate.h"

@class NSArray, NSDate, NSDictionary;

__attribute__((visibility("hidden")))
@interface ATVDotMacAccountDelegate : ATVDotMacParserDelegate {
@private
	NSArray *_albumOrder;	// 24 = 0x18
	NSArray *_videoOrder;	// 28 = 0x1c
	NSArray *_slideshowOrder;	// 32 = 0x20
	NSDate *_modDate;	// 36 = 0x24
	NSDictionary *_startSelectors;	// 40 = 0x28
	NSDictionary *_endSelectors;	// 44 = 0x2c
}
@property(readonly, retain) NSDictionary *endSelectors;	// G=0x34bf9115; converted property
@property(readonly, retain) NSDate *modDate;	// G=0x34bf9ce1; converted property
@property(readonly, retain) NSDictionary *startSelectors;	// G=0x34bf9105; converted property
- (id)init;	// 0x34bf8475
- (void)__atv_end_dotmac_iMovieUserOrder;	// 0x34bf8b15
- (void)__atv_end_dotmac_keyImagePath;	// 0x34bf8e2d
- (void)__atv_end_dotmac_posterPath;	// 0x34bf8f7d
- (void)__atv_end_dotmac_redacted;	// 0x34bf8e9d
- (void)__atv_end_dotmac_title;	// 0x34bf8d35
- (void)__atv_end_dotmac_type;	// 0x34bf8cfd
- (void)__atv_end_dotmac_userHidden;	// 0x34bf8f0d
- (void)__atv_end_dotmac_useritemguid;	// 0x34bf8f45
- (void)__atv_end_dotmac_userorder;	// 0x34bf8a15
- (void)__atv_end_dotmac_videoDurationLrg;	// 0x34bf90cd
- (void)__atv_end_dotmac_videoDurationMed;	// 0x34bf905d
- (void)__atv_end_dotmac_videoDurationSmall;	// 0x34bf8fed
- (void)__atv_end_dotmac_videoPathLrg;	// 0x34bf9095
- (void)__atv_end_dotmac_videoPathMed;	// 0x34bf9025
- (void)__atv_end_dotmac_videoPathSmall;	// 0x34bf8fb5
- (void)__atv_end_dotmac_viewIdentifier;	// 0x34bf8cc5
- (void)__atv_end_dotmac_webImagePath;	// 0x34bf8e65
- (void)__atv_end_iphoto_userHidden;	// 0x34bf8ed5
- (void)__atv_end_slideshowUserOrder;	// 0x34bf8c15
- (void)__atv_end_title;	// 0x34bf8c8d
- (void)__atv_end_updated;	// 0x34bf8db5
- (void)__atv_start_link:(id)link;	// 0x34bf8d6d
- (id)_publicMedia;	// 0x34bf9e5d
- (void)_updateEntriesWithDateTaken:(id)dateTaken withType:(id)type;	// 0x34bf9d99
- (void)dealloc;	// 0x34bf8975
- (id)displayName;	// 0x34bf9cf1
// converted property getter: - (id)endSelectors;	// 0x34bf9115
- (id)listOfAlbumInfos;	// 0x34bf91a1
- (id)listOfAlbumInfosAlphabetically;	// 0x34bf933d
- (id)listOfAlbumInfosUserSort;	// 0x34bf93f9
- (id)listOfVideoInfos;	// 0x34bf9481
- (id)listOfVideoInfosAlphabetically;	// 0x34bf96b1
- (id)listOfVideoInfosUserSort;	// 0x34bf976d
- (id)mediaUserSort;	// 0x34bf9125
// converted property getter: - (id)modDate;	// 0x34bf9ce1
- (id)mostRecentAlbumInfo;	// 0x34bf9b41
- (id)slideshowInfos;	// 0x34bf97f5
- (id)slideshowInfosAlphabetically;	// 0x34bf99fd
- (id)slideshowInfosUserSort;	// 0x34bf9ab9
// converted property getter: - (id)startSelectors;	// 0x34bf9105
@end
