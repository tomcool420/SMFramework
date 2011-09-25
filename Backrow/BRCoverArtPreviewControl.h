/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import "BRControl.h"

@class NSMutableArray, BRMediaType, NSTimer, NSArray;

@interface BRCoverArtPreviewControl : BRControl {
@private
	NSArray *_imageProxies;	// 44 = 0x2c
	NSMutableArray *_availableImages;	// 48 = 0x30
	BRMediaType *_mediaType;	// 52 = 0x34
	NSTimer *_crossfadeTimer;	// 56 = 0x38
	long _imageIndex;	// 60 = 0x3c
	float _rotation;	// 64 = 0x40
	BOOL _artworkNeedsDeletterboxing;	// 68 = 0x44
	BOOL _actionAdded;	// 69 = 0x45
	BOOL _onlyDefaultsAvailable;	// 70 = 0x46
	BOOL _controlWasDeactivated;	// 71 = 0x47
}
- (id)init;	// 0x34cfd939
- (void)_cleanupTimer;	// 0x34cfe625
- (void)_crossFadeToNextImage:(id)nextImage;	// 0x34cfe4cd
- (void)_imageUnavailable:(id)unavailable;	// 0x34cfe915
- (void)_loadImage:(id)image;	// 0x34cfe24d
- (void)_scheduleTimerOnMainThread;	// 0x34cfe671
- (void)_updateCoverArt:(id)art;	// 0x34cfe6d9
- (void)controlWasActivated;	// 0x34cfdfc5
- (void)controlWasDeactivated;	// 0x34cfe155
- (void)dealloc;	// 0x34cfda25
- (void)layoutSubcontrols;	// 0x34cfdab5
- (void)setDeletterboxAssetArtwork:(BOOL)artwork;	// 0x34cfe22d
- (void)setImageProxies:(id)proxies;	// 0x34cfdcd5
- (void)setImageProxy:(id)proxy;	// 0x34cfdc9d
- (void)setMissingAssetType:(id)type;	// 0x34cfdf8d
- (void)setRotation:(float)rotation;	// 0x34cfe23d
@end
