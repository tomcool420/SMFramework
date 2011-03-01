//
//  SMFComplexDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFComplexDropShadowControl.h"
#import "SMFThemeInfo.h"
#import <substrate.h>

@implementation SMFComplexDropShadowControl
@synthesize title=_title;
@synthesize subtitle=_subtitle;
@synthesize progress=_progress;
@synthesize blocking=_blocking;
-(id)init
{
    self=[super init];
    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
    [self setFrame:f];
    _bg=[[BRControl alloc] init];
    _progress=[[SMFProgressBarControl alloc]init];
    _titleControl=[[BRMetadataTitleControl alloc]init];
    _scrolling=[[BRScrollingTextBoxControl alloc]init];
    _list=MSHookIvar<BRListControl *>(_scrolling, "_list");
    self.backgroundColor=[[SMFThemeInfo sharedTheme]blackColor];
    self.borderColor=[[SMFThemeInfo sharedTheme] whiteColor];
    self.borderWidth=3.0;
    self.title=@"Installing SMFramework";
    self.subtitle=@"org.tomcool.smframework";
    [self setContent:_bg];
    _text=[[NSMutableString alloc] initWithString:@"Hello\nBye\n.\n."];
    return self;
}
-(void)addToController:(BRController *)ctrl
{
    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
    [self setFrame:f];
    [ctrl addControl:self];
    [ctrl setFocusedControl:self];
    [ctrl _setFocus:self];
}
-(void)reload
{
    [_bg _removeAllControls];
    CGRect pf = [self frame];
    [_progress setFrame:CGRectMake(pf.size.width*0.2f, pf.size.height*0.02f, pf.size.width*0.6f, pf.size.height*0.06f)];
    [_bg addControl:_progress];
    
    [_titleControl setTitle:_title];
    [_titleControl setTitleSubtext:_subtitle];
    [_titleControl setFrame:CGRectMake(pf.size.width*0.02f, pf.size.height*0.83f, pf.size.width*0.6f, pf.size.height*0.15f)];
    [_bg addControl:_titleControl];
    
    [_scrolling setFrame:CGRectMake(0.0, pf.size.height*0.11, pf.size.width, pf.size.height*0.75f)];
    [_scrolling setText:[self attributedStringForString:_text]];
    [_bg addControl:_scrolling];
    
}
-(id)attributedStringForString:(NSString*)s
{
    NSMutableDictionary *d = [[[[BRThemeInfo sharedTheme]metadataTitleAttributes] mutableCopy] autorelease];
    [d setObject:[NSNumber numberWithInt:0] forKey:@"BRTextAlignmentKey"];
    [d setObject:[NSNumber numberWithInt:0] forKey:@"BRLineBreakModeKey"];
    return [[[NSAttributedString alloc]initWithString:s attributes:d]autorelease];
}
-(void)appendToText:(NSString *)t
{
    [_text appendString:t];
    [_scrolling setText:[self attributedStringForString:_text]];
    [_list setSelection:([_list dataCount]-1)];
    [_scrolling layoutSubcontrols];
}
-(void)controlWasActivated
{
    [super controlWasActivated];
    [self reload];
}
-(void)setShowsProgressBar:(BOOL)shows
{
    [_progress setHidden:!shows];
    _pbShows=shows;
}
-(BOOL)showsProgressBar
{
    return _pbShows;
}
-(void)setShowsWaitSpinner:(BOOL)shows
{
    [_spinner setHidden:!shows];
    _showWaitSpinner=shows;
}
-(BOOL)brEventAction:(BREvent*)event
{
    
    int remoteAction = [event remoteAction];
    switch (remoteAction)
    {
        case kBREventRemoteActionMenu:
            [self removeFromParent];
            return YES;
            break;
        case kBREventRemoteActionUp:
            if (event.value==1) {
                if ([_list selection]==0)
                {
                    [_list setSelection:([_list dataCount]-1)];
                    return YES;
                }
            }
            break;
        case kBREventRemoteActionDown:
            if (event.value==1) {
                if ([_list selection]==([_list dataCount]-1)) {
                    return YES;
                }
            }
            break;
    }
    return [super brEventAction:event];
}
-(BOOL)showsWaitSpinner
{
    return _showWaitSpinner;
}
-(void)dealloc
{
    [_titleControl release];
    _titleControl=nil;
    [_bg release];
    _bg=nil;
    [_scrolling release];
    _scrolling=nil;
    [_progress release];
    _progress=nil;
    [_spinner release];
    _spinner = nil;
    
    _list=nil;
    self.title=nil;
    self.subtitle=nil;
    [super dealloc];
    
}
@end
