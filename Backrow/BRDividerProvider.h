/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BRProvider.h"
#import "BRControlFactory.h"
#import "BRControlHeightFactory.h"
#import <Foundation/Foundation.h> // Unknown library

@class BRDividerControl;

@interface BRDividerProvider : NSObject <BRControlFactory, BRControlHeightFactory, BRProvider> {
@private
	id<BRProvider> _provider;	// 4 = 0x4
	BRDividerControl *_topDivider;	// 8 = 0x8
	BOOL _dividerHidden;	// 12 = 0xc
	BOOL _showDivider;	// 13 = 0xd
}
@property(assign) BOOL dividerHidden;	// G=0x34d113cd; S=0x34d113a1; converted property
+ (id)providerWithProvider:(id)provider;	// 0x34d1126d
- (id)initWithProvider:(id)provider;	// 0x34d11101
- (void)_providerDataSetChanged:(id)changed;	// 0x34d116e5
- (void)_providerItemsModified:(id)modified;	// 0x34d1167d
- (id)_shiftRangesDown:(id)down;	// 0x34d115a9
- (BOOL)_shouldShowDivider;	// 0x34d11561
- (void)_updateTopDividerControl;	// 0x34d114c9
- (id)accessibilityLabel;	// 0x34d1173d
- (void)addDividerWithLabel:(id)label;	// 0x34d112c1
- (void)addDividerWithLabel:(id)label andOrientation:(int)orientation;	// 0x34d112d9
- (id)controlFactory;	// 0x34d113fd
- (id)controlForData:(id)data currentControl:(id)control requestedBy:(id)by;	// 0x34d1175d
- (id)dataAtIndex:(long)index;	// 0x34d11439
- (long)dataCount;	// 0x34d11401
- (void)dealloc;	// 0x34d111ed
- (id)divider;	// 0x34d113ed
// converted property getter: - (BOOL)dividerHidden;	// 0x34d113cd
- (BOOL)dividerVisible;	// 0x34d113dd
- (id)hashForDataAtIndex:(long)index;	// 0x34d11485
- (float)heightForControlForData:(id)data requestedBy:(id)by;	// 0x34d117b1
- (id)provider;	// 0x34d112b1
- (void)removeDivider;	// 0x34d11369
// converted property setter: - (void)setDividerHidden:(BOOL)hidden;	// 0x34d113a1
@end
