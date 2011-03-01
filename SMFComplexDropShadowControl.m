//
//  SMFComplexDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFComplexDropShadowControl.h"


@implementation SMFComplexDropShadowControl
-(id)init
{
    self=[super init];
    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
    [self setFrame:f];
    _panel=[[BRPanelControl alloc] init];
    [self setContent:_panel];
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
    
}
-(void)controlWasActivated
{
    [super controlWasActivated];
    [self reload];
}
@end
