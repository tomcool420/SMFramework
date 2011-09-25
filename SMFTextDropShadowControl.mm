//
//  SMFTextDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 2/27/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFTextDropShadowControl.h"
#import "SMFThemeInfo.h"
#import "SMFDefines.h"
#import <substrate.h>

@implementation SMFTextDropShadowControl
@synthesize text=_text;
@synthesize attributedString=_att;
-(id)attributedStringForString:(NSString*)s
{
    NSMutableDictionary *d = [[[[BRThemeInfo sharedTheme]metadataTitleAttributes] mutableCopy] autorelease];
    [d setObject:[NSNumber numberWithInt:0] forKey:@"BRTextAlignmentKey"];
    [d setObject:[NSNumber numberWithInt:0] forKey:@"BRLineBreakModeKey"];
    return [[[NSAttributedString alloc]initWithString:s attributes:d]autorelease];
}
-(id)init
{
    self=[super init];

    self.text=[NSMutableString stringWithString:@"Hello"];
        self.backgroundColor=[[SMFThemeInfo sharedTheme]blackColor];
        self.borderColor=[[SMFThemeInfo sharedTheme] whiteColor];
        self.borderWidth=3.0;
    BRImageControl *ic =[[BRImageControl alloc] init];
    [ic setImage:[[SMFThemeInfo sharedTheme]btstackIcon]];
        _scrolling=[[BRScrollingTextBoxControl alloc]init];
        [_scrolling setText:[self attributedStringForString:_text]];
    _list=MSHookIvar<BRListControl *>(_scrolling, "_list");
    
        [self setContent:_scrolling];
    [ic autorelease];
    return self;
}
//-(void)addToController:(BRController *)ctrl
//{
//    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
//    [self setFrame:f];
//    [ctrl addControl:self];
//    [ctrl setFocusedControl:self];
//    [ctrl _setFocus:self];
//}
-(void)dealloc
{
    self.text=nil;
    [_scrolling release];
    _scrolling=nil;
    [super dealloc];
}
-(void)controlWasActivated
{
    [self setFocusedControl:_scrolling];
    [self _setFocus:_scrolling];
    [super controlWasActivated];
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
-(void)appendToText:(NSString *)t
{
    [_text appendString:t];
    [_scrolling setText:[self attributedStringForString:_text]];
    [_list setSelection:([_list dataCount]-1)];
    [_scrolling layoutSubcontrols];
}
@end
