//
//  SMFProgressBarMenuItem.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/27/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import "SMFProgressBarMenuItem.h"
#import "SMFProgressBarControl.h"
@implementation SMFProgressBarMenuItem
+(SMFProgressBarMenuItem *)progressMenuItem
{
    SMFProgressBarMenuItem *a = [[SMFProgressBarMenuItem alloc]init];
    [a setShowsBar:YES];
    return [a autorelease];
}
+(SMFProgressBarMenuItem *)menuItem
{
    SMFProgressBarMenuItem *a = [[SMFProgressBarMenuItem alloc]init];
    [a setShowsBar:NO];
    return [a autorelease];
}
+(SMFProgressBarMenuItem *)rightProgressBarMenuItem
{
    SMFProgressBarMenuItem *a = [[SMFProgressBarMenuItem alloc] init];
    [a setShowsBar:YES];
    [a setLeftIndentFraction:0.75f];
    return [a autorelease];
}
+(SMFProgressBarMenuItem *)leftProgressBarMenuItem
{
    SMFProgressBarMenuItem *a = [[SMFProgressBarMenuItem alloc] init];
    [a setShowsBar:YES];
    [a setRightIndentFraction:0.7f];
    return [a autorelease];
}
+(SMFProgressBarMenuItem *)centeredProgressBarMenuItem
{
    SMFProgressBarMenuItem *a = [[SMFProgressBarMenuItem alloc] init];
    [a setShowsBar:YES];
    [a setLeftIndentFraction:0.75f];
    [a setRightIndentFraction:0.75f];
    return [a autorelease];
}
-(id)init
{
    self = [super init];
    _progressBar = [[SMFProgressBarControl alloc]init];
    [_progressBar setMaxValue:100.0f];
    [_progressBar setMinValue:0.0f];
    [_progressBar setCurrentValue:0.f];
    [self setLeftIndentFraction:0.];
    [self setRightIndentFraction:1.];
    return self;
}
-(void)dealloc
{
    [_progressBar release];
    [super dealloc];
}
-(void)layoutSubcontrols
{
    [super layoutSubcontrols];
    CGRect bounds = [self bounds];
    float b=0.3f;
    float a=[[BRThemeInfo sharedTheme] textMenuItemLeftInsetAndRightInset:&b];
    bounds.origin.x=a;
    bounds.size.width=bounds.size.width-a-b;
    float width = bounds.size.width*([self rightIndentFraction]-[self leftIndentFraction]);
    float x=bounds.size.width*[self leftIndentFraction];
    bounds.size.width=width;
    bounds.origin.x=x+bounds.origin.x;
    if ([self showsBar]) {
        [self addControl:_progressBar];
        [_progressBar setFrame:bounds];
    }
    else {
        [_progressBar removeFromParent];
    }

    
}

#pragma mark Progress Bar Methods
-(void)setLeftIndentFraction:(float)frac
{
    _leftBarIndent=frac;
}
-(void)setRightIndentFraction:(float)frac
{
    _rightBarIndent=frac;
}
-(float)leftIndentFraction
{
    return _leftBarIndent;
}
-(float)rightIndentFraction
{
    return _rightBarIndent;
}
-(void)setShowsBar:(BOOL)val
{
    showBar=val;
}
-(BOOL)showsBar
{
    return showBar;
}
-(void)setProgressValue:(float)val
{
    [_progressBar setCurrentValue:val];
    [self setNeedsDisplay:YES];
}
-(void)setMaxProgressValue:(float)max
{
    [_progressBar setMaxValue:max];
    [self setNeedsDisplay:YES];
}
-(void)setMinProgressValue:(float)min
{
    [_progressBar setMinValue:min];
    [self setNeedsDisplay:YES];
}
-(float)currentProgress
{
    return [_progressBar currentValue];
}
-(float)maxProgressValue
{
    return [_progressBar maxValue];
}
-(float)minProgressValue
{
    return [_progressBar minValue];
}
-(void)setNeedsDisplay:(BOOL)disp
{
    //[super setNeedsDisplay:disp];
    //[_progressBar setNeedsLayout:YES];
}
@end
