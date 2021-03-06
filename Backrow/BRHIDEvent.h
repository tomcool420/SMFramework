/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "BREvent.h"


@interface BRHIDEvent : BREvent {
@private
	unsigned short _page;	// 30 = 0x1e
	unsigned short _usage;	// 32 = 0x20
	unsigned long long _extendedSignature;	// 36 = 0x24
}
@property(readonly, assign) unsigned long long extendedSignature;	// G=0x34ce8e69; converted property
@property(readonly, assign) unsigned short page;	// G=0x34ce8e49; converted property
@property(readonly, assign) unsigned short usage;	// G=0x34ce8e59; converted property
+ (id)eventWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value;	// 0x34ce89a1
+ (id)eventWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value atTime:(double)time;	// 0x34ce8959
+ (id)eventWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value extendedSignature:(unsigned long long)signature;	// 0x34ce890d
+ (id)eventWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value extendedSignature:(unsigned long long)signature atTime:(double)time;	// 0x34ce88b9
- (id)initWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value;	// 0x34ce89e1
- (id)initWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value atTime:(double)time;	// 0x34ce8a61
- (id)initWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value extendedSignature:(unsigned long long)signature;	// 0x34ce8a19
- (id)initWithPage:(unsigned short)page usage:(unsigned short)usage value:(int)value extendedSignature:(unsigned long long)signature atTime:(double)time;	// 0x34ce8a95
- (id)description;	// 0x34ce8c45
// converted property getter: - (unsigned long long)extendedSignature;	// 0x34ce8e69
- (BOOL)isEqual:(id)equal;	// 0x34ce8d5d
// converted property getter: - (unsigned short)page;	// 0x34ce8e49
// converted property getter: - (unsigned short)usage;	// 0x34ce8e59
@end

