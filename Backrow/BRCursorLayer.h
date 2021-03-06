/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BRMultiPartWidgetLayer.h"


__attribute__((visibility("hidden")))
@interface BRCursorLayer : BRMultiPartWidgetLayer {
@private
	float _radius;	// 96 = 0x60
	float _haloPercentage;	// 100 = 0x64
}
@property(assign) float cornerRadius;	// G=0x34d00225; S=0x34d00235; converted property
@property(assign) float haloPercentage;	// G=0x34d00205; S=0x34d00215; converted property
- (id)init;	// 0x34d001b1
// converted property getter: - (float)cornerRadius;	// 0x34d00225
// converted property getter: - (float)haloPercentage;	// 0x34d00205
- (id)imageMapForCornerRadius:(float)cornerRadius;	// 0x34d002c9
// converted property setter: - (void)setCornerRadius:(float)radius;	// 0x34d00235
// converted property setter: - (void)setHaloPercentage:(float)percentage;	// 0x34d00215
@end

