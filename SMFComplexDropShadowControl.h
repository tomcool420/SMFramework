//
//  SMFComplexDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "Backrow/AppleTV.h"
#import "SMFProgressBarControl.h"
#import "SMFDropShadowControl.h"

@interface SMFComplexDropShadowControl : SMFDropShadowControl {
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
    NSObject *delegate;
}
/*
 *  If you want to change the title and subtitle while the control is up,
 *  you can just change the two properties
 */
@property(copy)NSString *title;
@property(copy)NSString *subtitle;
@property(readonly,assign)SMFProgressBarControl *progress;
@property(readwrite,assign)BOOL blocking;
@property(readwrite,assign)NSObject *delegate;

-(void)appendToText:(NSString *)t;
	//-(void)addToController:(BRController *)ctrl;

-(void)setShowsProgressBar:(BOOL)shows;
-(void)setShowsWaitSpinner:(BOOL)spinner;
-(BOOL)showsProgressBar;
-(BOOL)showsWaitSpinner;

-(void)setBlocking:(BOOL)blocking;
-(BOOL)blocking;
-(id)attributedStringForString:(NSString*)s;
-(void)updateHeader;
- (void)removeBlueLozenge;

@end
