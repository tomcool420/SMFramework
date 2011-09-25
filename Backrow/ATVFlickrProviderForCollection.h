/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "ATVFlickrProvider.h"
#import "BRPhotoProviderForCollection.h"

@class ATVFlickrCollection;

@interface ATVFlickrProviderForCollection : ATVFlickrProvider <BRPhotoProviderForCollection> {
@private
	ATVFlickrCollection *_collection;	// 24 = 0x18
}
@property(readonly, retain) ATVFlickrCollection *collection;	// G=0x34c116d5; converted property
@property(assign) BOOL vendPhotoDataOnly;	// G=0x34c116ed; S=0x34c116e9; converted property
+ (id)providerForCollection:(id)collection;	// 0x34c11431
- (id)initWithCollection:(id)collection;	// 0x34c11471
- (id)_data;	// 0x34c11671
- (BOOL)_handlesObject:(id)object;	// 0x34c11691
- (BOOL)canHaveZeroData;	// 0x34c116e5
// converted property getter: - (id)collection;	// 0x34c116d5
- (void)dealloc;	// 0x34c11581
- (id)hashForDataAtIndex:(long)index;	// 0x34c1163d
// converted property setter: - (void)setVendPhotoDataOnly:(BOOL)only;	// 0x34c116e9
// converted property getter: - (BOOL)vendPhotoDataOnly;	// 0x34c116ed
@end
