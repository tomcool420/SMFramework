//
//  SMFComplexDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Backrow/Backrow.h>
#import "SMFProgressBarControl.h"

@interface SMFComplexDropShadowControl : BRDropShadowControl {
    BRPanelControl *_panel;
    BRScrollingTextBoxControl *_scrolling;
    BRWaitSpinnerControl *_spinner;
    SMFProgressBarControl *_progress;
    BOOL    _pbShows;
    BOOL    _blocking;
    BOOL    _showWaitSpinner;
}
-(void)appendToText:(NSString *)t;
-(void)addToController:(BRController *)ctrl;

-(void)setShowsProgressBar:(BOOL)shows;
-(void)setShowsWaitSpinner:(BOOL)spinner;
-(BOOL)showsProgressBar;
-(BOOL)showsWaitSpinner;

-(void)setBlocking:(BOOL)blocking;
-(BOOL)blocking;
@end
