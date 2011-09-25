/**
 * This header is generated by class-dump-z 0.2a.
 * class-dump-z is Copyright (C) 2009 by KennyTM~, licensed under GPLv3.
 *
 * Source: /System/Library/PrivateFrameworks/AppleTV.framework/AppleTV
 */

#import "AppleTV-Structs.h"
#import "BRControl.h"

@class NSTimer, BRBoxListControl;

@interface BRContextMenuControl : BRControl {
@private
	BRControl *_endPositionControl;	// 44 = 0x2c
	BRControl *_startPositionControl;	// 48 = 0x30
	BRControl *_dimControl;	// 52 = 0x34
	BRControl *_dimPanel;	// 56 = 0x38
	CGRect _endPositionControlFrame;	// 60 = 0x3c
	CGRect _startPositionControlFrame;	// 76 = 0x4c
	CGRect _dimControlFrame;	// 92 = 0x5c
	BRBoxListControl *_contextBox;	// 108 = 0x6c
	int _dimOption;	// 112 = 0x70
	NSTimer *_autoDismissTimer;	// 116 = 0x74
}
@property(retain) BRControl *dimControl;	// G=0x34cfc795; S=0x34cfc75d; converted property
@property(assign) int dimOption;	// G=0x34cfc7c5; S=0x34cfc7a5; converted property
@property(retain) BRControl *endPositionControl;	// G=0x34cfc74d; S=0x34cfc715; converted property
@property(assign) BOOL isVisible;	// G=0x34cfcb51; S=0x34cfca59; converted property
@property(retain) id providers;	// G=0x34cfc6ad; S=0x34cfc679; converted property
@property(retain) BRControl *startPositionControl;	// G=0x34cfc705; S=0x34cfc6cd; converted property
- (id)init;	// 0x34cfc3cd
- (void)_addAnimationsForDisplayState:(BOOL)displayState;	// 0x34cfcb9d
- (void)_autoDismissTimerFired:(id)fired;	// 0x34cfcb79
- (CGRect)_dimControlFrame;	// 0x34cfd4b9
- (void)_dissmissAnimationComplete;	// 0x34cfd239
- (CGRect)_endPositionControlFrame;	// 0x34cfd261
- (CGRect)_startPositionControlFrame;	// 0x34cfd38d
- (BOOL)brEventAction:(id)action;	// 0x34cfc5b9
- (void)controlWasDeactivated;	// 0x34cfc56d
- (void)dealloc;	// 0x34cfc4e1
// converted property getter: - (id)dimControl;	// 0x34cfc795
// converted property getter: - (int)dimOption;	// 0x34cfc7c5
// converted property getter: - (id)endPositionControl;	// 0x34cfc74d
// converted property getter: - (BOOL)isVisible;	// 0x34cfcb51
- (void)layoutSubcontrols;	// 0x34cfc7d5
// converted property getter: - (id)providers;	// 0x34cfc6ad
// converted property setter: - (void)setDimControl:(id)control;	// 0x34cfc75d
// converted property setter: - (void)setDimOption:(int)option;	// 0x34cfc7a5
// converted property setter: - (void)setEndPositionControl:(id)control;	// 0x34cfc715
// converted property setter: - (void)setIsVisible:(BOOL)visible;	// 0x34cfca59
- (void)setProvider:(id)provider;	// 0x34cfc641
// converted property setter: - (void)setProviders:(id)providers;	// 0x34cfc679
// converted property setter: - (void)setStartPositionControl:(id)control;	// 0x34cfc6cd
// converted property getter: - (id)startPositionControl;	// 0x34cfc705
@end
