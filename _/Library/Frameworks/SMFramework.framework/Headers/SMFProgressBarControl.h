//
//  SMProgressBarControl.h
//  QuDownloader
//
//  Created by Alan Quatermain on 19/04/07.
//  Copyright 2007 AwkwardTV. All rights reserved.
//
//  Updated by nito 08-20-08 - works in 2.x
//  Updated by Thomas 2-2-10 - allows for different aspect Ratios
//  Updated by Thomas 14-11-10 - ATV2 fixes
#import <Backrow/Backrow.h>
@class BRProgressBarWidget;

@interface SMFProgressBarControl : BRControl
{
    BRProgressBarWidget *   _widget;
    float                   _maxValue;
    float                   _minValue;
}

- (id) init;
- (void) dealloc;

- (void) setFrame: (CGRect) frame;

- (void) setMaxValue: (float) maxValue;
- (float) maxValue;

- (void) setMinValue: (float) minValue;
- (float) minValue;

- (void) setCurrentValue: (float) currentValue;
- (float) currentValue;

- (void) setPercentage: (float) percentage;
- (float) percentage;

@end
