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
    BRControl *_bg;
    BRScrollingTextBoxControl *_scrolling;
    BRWaitSpinnerControl *_spinner;
    SMFProgressBarControl *_progress;
    BRMetadataTitleControl *_titleControl;
    BOOL    _pbShows;
    BOOL    _blocking;
    BOOL    _showWaitSpinner;
    NSString *_title;
    NSString *_subtitle;
    NSMutableString *_text;
    BRListControl *_list;
}
@property(retain)NSString *title;
@property(retain)NSString *subtitle;
@property(readonly,assign)SMFProgressBarControl *progress;
@property(readwrite,assign)BOOL blocking;

-(void)appendToText:(NSString *)t;
-(void)addToController:(BRController *)ctrl;

-(void)setShowsProgressBar:(BOOL)shows;
-(void)setShowsWaitSpinner:(BOOL)spinner;
-(BOOL)showsProgressBar;
-(BOOL)showsWaitSpinner;

-(void)setBlocking:(BOOL)blocking;
-(BOOL)blocking;
-(id)attributedStringForString:(NSString*)s;
@end
