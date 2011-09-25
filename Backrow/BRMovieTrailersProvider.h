/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BRNetworkMediaProvider.h"

@class NSMutableArray;

@interface BRMovieTrailersProvider : BRNetworkMediaProvider {
@private
	NSMutableArray *_mediaCollections;	// 12 = 0xc
	int _lastError;	// 16 = 0x10
}
@property(readonly, assign) int lastError;	// G=0x34ce0901; converted property
+ (void)initialize;	// 0x34ce0201
+ (BOOL)trailersAvailable;	// 0x34ce0331
- (id)init;	// 0x34ce03b5
- (BOOL)_addMediaAsset:(id)asset;	// 0x34db7959
- (void)_loadTrailers;	// 0x34ce0911
- (void)_loadTrailersWithResolution:(id)resolution forURL:(id)url;	// 0x34ce0b11
- (void)_networkStatusChanged:(id)changed;	// 0x34ce0335
- (void)_postLoadedNotification:(id)notification;	// 0x34ce0a85
- (void)dealloc;	// 0x34ce0479
- (int)errorCodeForProvider;	// 0x34ce0889
// converted property getter: - (int)lastError;	// 0x34ce0901
- (int)load;	// 0x34ce0615
- (id)mediaForEntityName:(id)entityName;	// 0x34ce052d
- (id)mediaTypes;	// 0x34ce04e5
- (id)providerID;	// 0x34ce0521
- (int)unload;	// 0x34ce07bd
@end
