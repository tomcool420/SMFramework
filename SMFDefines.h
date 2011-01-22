//
//  SMFDefines.h
//  SMFramework
//
//  Created by Thomas Cool on 10/24/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
typedef enum {
	// for originator kBREventOriginatorRemote
	kBREventRemoteActionMenu = 1,
	kBREventRemoteActionMenuHold,
	kBREventRemoteActionUp,
	kBREventRemoteActionDown,
	kBREventRemoteActionPlay,
	kBREventRemoteActionLeft,
	kBREventRemoteActionRight,
    
    kBREventRemoteActionPlayPause=10,
    
	kBREventRemoteActionPlayHold = 20,
    kBREventRemoteActionSelectHold = 22,
	// Gestures, for originator kBREventOriginatorGesture
	kBREventRemoteActionTap = 30,
	kBREventRemoteActionSwipeLeft,
	kBREventRemoteActionSwipeRight,
	kBREventRemoteActionSwipeUp,
	kBREventRemoteActionSwipeDown,
	
	// Custom remote actions for old remote actions
	kBREventRemoteActionHoldLeft = 0xfeed0001,
	kBREventRemoteActionHoldRight,
	kBREventRemoteActionHoldUp,
	kBREventRemoteActionHoldDown,
} BREventRemoteAction;
