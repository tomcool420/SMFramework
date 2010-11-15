//
//  SMFProgressBarControl.m
//  SoftwareMenuFramework
//
//  Created by Alan Quatermain on 19/04/07.
//  Copyright 2007 AwkwardTV. All rights reserved.
//
//  Updated by nito 08-20-08 - works in 2.x
//  Updated by Thomas 2-2-10 - allows for different aspect Ratios


#import "SMFProgressBarControl.h"
@implementation SMFProgressBarControl

- (id) init
{
	self = [super init];
	
    _widget = [[BRProgressBarWidget alloc] init];
	
    [self addControl: _widget];
	
    // defaults
    _maxValue = 100.0f;
    _minValue = 0.0f;
	
    return self;
}

- (void) dealloc
{
    [_widget release];
    //[_layer release];

    [super dealloc];
}

- (void) setFrame: (CGRect) frame
{
    [super setFrame: frame];
	
    CGRect widgetFrame;// = CGRectZero;
    widgetFrame.origin.x = 0.0f;
    widgetFrame.origin.y = 0.0f;
    widgetFrame.size.width = frame.size.width;
    widgetFrame.size.height = ceilf( frame.size.width * 0.1f );
    if (frame.size.height>widgetFrame.size.height) {
        widgetFrame.origin.y=widgetFrame.origin.y+ceilf((frame.size.height-widgetFrame.size.height)/2.f);
    }
    [_widget setFrame: widgetFrame];
}



- (void) setMaxValue: (float) maxValue
{
    @synchronized(self)
    {
        _maxValue = maxValue;
    }
}

- (float) maxValue
{
    return ( _maxValue );
}

- (void) setMinValue: (float) minValue
{
    @synchronized(self)
    {
        _minValue = minValue;
    }
}

- (float) minValue
{
    return ( _minValue );
}

- (void) setCurrentValue: (float) currentValue
{
    @synchronized(self)
    {
        float range = _maxValue - _minValue;
        float value = currentValue - _minValue;
        float percentage = (value / range) * 100.0f;
        [_widget setPercentage: percentage];
    }
}

- (float) currentValue
{
    float result = 0.0f;

    @synchronized(self)
    {
        float percentage = [_widget percentage];
        float range = _maxValue - _minValue;
        result = (percentage / 100.0f) * range;
    }

    return ( result );
}

- (void) setPercentage: (float) percentage
{
    [_widget setPercentage: percentage];
}

- (float) percentage
{
    return ( [_widget percentage] );
}

@end
