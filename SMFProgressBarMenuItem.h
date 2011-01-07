//
//  SMFProgressBarMenuItem.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/27/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SMFMenuItem.h"

@class SMFProgressBarControl;
@interface SMFProgressBarMenuItem : SMFMenuItem {
    SMFProgressBarControl * _progressBar;
    BOOL                    showBar;
    float                   _leftBarIndent;  //number from 0 -> 1
    float                   _rightBarIndent; //number from 0 -> 1 if leftBar>rightBar, default full bar is selected
                                             //0 for left and 1 for right
}
+(SMFProgressBarMenuItem *)progressMenuItem;                //Full bar, can be manually adjusted.
+(SMFProgressBarMenuItem *)menuItem;                        //no bar, like a BRTextImageMenuItemLayer
+(SMFProgressBarMenuItem *)rightProgressBarMenuItem;        //with a bar taking up right 30%
+(SMFProgressBarMenuItem *)leftProgressBarMenuItem;         //with a bar taking up left 75%
+(SMFProgressBarMenuItem *)centeredProgressBarMenuItem;      //with a bar taking up center 50%

-(id)init;
-(void)layoutSubcontrols;
-(void)dealloc;



#pragma mark Progress Bar Methods
-(void)setLeftIndentFraction:(float)frac;
-(void)setRightIndentFraction:(float)frac;
-(float)leftIndentFraction;
-(float)rightIndentFraction;
-(void)setShowsBar:(BOOL)val;
-(BOOL)showsBar;
-(void)setProgressValue:(float)val;
-(void)setMaxProgressValue:(float)max;
-(void)setMinProgressValue:(float)min;
-(float)currentProgress;
-(float)maxProgressValue;
-(float)minProgressValue;
-(void)setNeedsDisplay:(BOOL)disp;
@end
