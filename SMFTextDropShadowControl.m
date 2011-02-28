//
//  SMFTextDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 2/27/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFTextDropShadowControl.h"
#import "SMFThemeInfo.h"

@implementation SMFTextDropShadowControl
@synthesize text=_text;
-(id)attributedStringForString:(NSString*)s
{
    return [[[NSAttributedString alloc]initWithString:s attributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]]autorelease];
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
    
        [self setContent:_scrolling];
    [ic autorelease];
    return self;
}
-(void)addToController:(BRController *)ctrl
{
    CGSize s = [BRWindow maxBounds];
    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
    [self setFrame:f];
    [ctrl addControl:self];
    [ctrl setFocusedControl:self.content];
    [ctrl _setFocus:self.content];
}
-(void)dealloc
{
    self.text=nil;
    [_scrolling release];
    _scrolling=nil;
    [super dealloc];
}
-(void)appendToText:(NSString *)t
{
    [_text appendString:t];
    [_scrolling setText:[self attributedStringForString:_text]];
    NSLog(@"self.text: %@ %@",self.text,_text);
    [_scrolling layoutSubcontrols];
}
@end
