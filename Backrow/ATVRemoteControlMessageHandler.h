/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import <Foundation/Foundation.h> // Unknown library

@class NSMutableArray, NSTimer, ATVDirectionalRemoteConnectionHandler;

@interface ATVRemoteControlMessageHandler : NSObject {
@private
	int _touchDirection;	// 4 = 0x4
	CGPoint _startPoint;	// 8 = 0x8
	double _lastTimeStamp;	// 16 = 0x10
	CGPoint _lastPoint;	// 24 = 0x18
	NSTimer *_swipeTimer;	// 32 = 0x20
	NSTimer *_easeOutTimer;	// 36 = 0x24
	double _easeOutInterval;	// 40 = 0x28
	double _easeOutDecelerationFactor;	// 48 = 0x30
	BOOL _easeOutRepeat;	// 56 = 0x38
	CGPoint _autoScrollStartPoint;	// 60 = 0x3c
	double _autoScrollStartInterval;	// 68 = 0x44
	NSTimer *_autoScrollContinueTimer;	// 76 = 0x4c
	BOOL _isReallyReallyAutoScrolling;	// 80 = 0x50
	double _autoScrollInterval;	// 84 = 0x54
	CGPoint _velocityAdjustOffset;	// 92 = 0x5c
	CGPoint _lastVelocityRefPoint;	// 100 = 0x64
	CGPoint _velocityVector;	// 108 = 0x6c
	NSMutableArray *_velocitySet;	// 116 = 0x74
	int _touchCount;	// 120 = 0x78
	NSMutableArray *_throttledEventQueue;	// 124 = 0x7c
	NSTimer *_throttleEventTimer;	// 128 = 0x80
	BOOL _prohibitSelect;	// 132 = 0x84
	BOOL _activelyScrolling;	// 133 = 0x85
	CGSize _selectionChange;	// 136 = 0x88
	ATVDirectionalRemoteConnectionHandler *_connectionHandler;	// 144 = 0x90
	NSTimer *_connectionTimeoutTimer;	// 148 = 0x94
}
- (id)init;	// 0x34c428c9
- (CGPoint)_adjustPoint:(CGPoint)point forVelocity:(CGPoint)velocity;	// 0x34c434e9
- (void)_autoScrollContinueTimerCallback:(id)callback;	// 0x34c4459d
- (void)_beginAutoScroll;	// 0x34c43fb1
- (double)_calculateVelocityAverage;	// 0x34c436c9
- (void)_clearEventQueue;	// 0x34c44ef5
- (void)_connectionTimedOut:(id)anOut;	// 0x34c431f5
- (BOOL)_easeOutInProgress;	// 0x34c44ba5
- (void)_easeOutTimerCallback:(id)callback;	// 0x34c44995
- (void)_finishAutoScroll;	// 0x34c441c5
- (void)_finishEaseOut;	// 0x34c44b35
- (CGPoint)_getSelectionPosition:(CGPoint)position;	// 0x34c43a11
- (CGSize)_initialSelectionChangeDistance;	// 0x34c44f49
- (void)_invalidateSwipeAction;	// 0x34c43f19
- (BOOL)_isAutoScrolling;	// 0x34c43f89
- (BOOL)_isReallyReallyAutoScrolling;	// 0x34c43fa1
- (void)_postEvent:(id)event;	// 0x34c44bbd
- (void)_postThrottledEvent:(id)event;	// 0x34c44d19
- (void)_processLastTouchMove;	// 0x34c4328d
- (void)_processSelectionChange:(int)change delta:(int)delta;	// 0x34c43a81
- (void)_processSwipeMovement;	// 0x34c43be9
- (BOOL)_processTouchEvent:(unsigned long)event value:(unsigned long)value eventDictionary:(id)dictionary;	// 0x34c42cc5
- (void)_refreshConnectionTimeoutTimer;	// 0x34c4313d
- (CGSize)_repeatSelectionChangeDistance;	// 0x34c44f55
- (void)_resetTrackingCoordinates;	// 0x34c43209
- (void)_resetVelocitySet;	// 0x34c439f1
- (void)_scrollEndNotification;	// 0x34c44fbd
- (void)_scrollStartNotification;	// 0x34c44f99
- (void)_sendDirectionEvent:(int)event value:(int)value;	// 0x34c43b2d
- (BOOL)_startEaseOut;	// 0x34c4464d
- (BOOL)_swipeActive;	// 0x34c43f01
- (void)_swipeTimeout;	// 0x34c43e5d
- (void)_throttleEventTimerCallback;	// 0x34c44db1
- (BOOL)_updateAutoScroll;	// 0x34c44029
- (void)_updateAutoScrollInterval;	// 0x34c44281
- (void)_updateVelocitySet:(CGPoint)set velocity:(CGPoint)velocity;	// 0x34c43919
- (double)_velocitySetTotalDistance;	// 0x34c43861
- (void)dealloc;	// 0x34c42a09
- (BOOL)handleDirectionalRemoteMessage:(unsigned long)message value:(unsigned long)value eventDictionary:(id)dictionary;	// 0x34c42ac5
- (void)invalidate;	// 0x34c42a99
@end

