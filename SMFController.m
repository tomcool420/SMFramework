//
//  SMFController.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 11/30/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//


#import "SMFController.h"

@implementation SMFController

-(CGRect)getMasterFrame
{
    CGRect master ;
//    if ([SMFPreferences twoPointThreeOrGreater]){
//        master  = [[self parent] frame];
//    } else {
//        master = [self frame];
//    }
    master=[self frame];
    if ([self is1080i])
        master.size=[self sizeFor1080i];
    return master;
}

- (BOOL)is1080i
{
//	NSString *displayUIString = [BRDisplayManager currentDisplayModeUIString];
//	NSArray *displayCom = [displayUIString componentsSeparatedByString:@" "];
//	NSString *shortString = [displayCom objectAtIndex:0];
//	if ([shortString isEqualToString:@"1080i"])
//		return YES;
//	else
		return NO;
}

- (CGSize)sizeFor1080i
{
	
	CGSize currentSize;
	currentSize.width = 1280.0f;
	currentSize.height = 720.0f;
	
	
	return currentSize;
}
-(void)dealloc
{
    [_title release];
    [_headerControl release];
    [_spinner release];
    [_imageControl release];
    [_image release];
    [super dealloc];
}
-(void)drawSelf;
{
    [self _removeAllControls];
    
}
@end
@implementation SMFController (layout)


-(void)layoutSpinner
{
    [_spinner removeFromParent];
    CGRect masterFrame=[self getMasterFrame];
    CGRect frame2 = masterFrame;
	frame2.origin.x = masterFrame.size.width  * 0.39f;
    frame2.origin.y = (masterFrame.size.height * 0.05f);// - txtSize.height;
	
    frame2.size.width = masterFrame.size.width*0.22f;
	frame2.size.height = masterFrame.size.height*0.22f;
	[_spinner setFrame:frame2];
	[_spinner setSpins:YES];
    [self addControl:_spinner];
}
-(void)layoutHeader
{
    [_headerControl removeFromParent];
    if(_title == nil)
        _title = DEFAULT_CONTROLLER_TITLE;
    [_headerControl setTitle:_title];
    CGRect masterFrame = [self getMasterFrame];
    CGRect frame=masterFrame;
    frame.origin.y = frame.size.height * 0.82f;
    frame.size.height = [[BRThemeInfo sharedTheme] listIconHeight];
    [_headerControl setFrame:frame];
    [self addControl:_headerControl];
}
-(void)layoutImage
{
    [_imageControl removeFromParent];
    if (_image==nil)
        _image = [[BRThemeInfo sharedTheme] appleTVIcon];
    [_imageControl setImage:_image];
    [_imageControl setAutomaticDownsample:YES];
	CGRect masterFrame = [self getMasterFrame];
    float aspectRatio = [_image aspectRatio];
	CGRect frame;
	frame.origin.x = masterFrame.size.width *0.7f;
	frame.origin.y = masterFrame.size.height *0.3f;
	frame.size.width = masterFrame.size.height*0.4f; 
	frame.size.height= frame.size.width/aspectRatio;
    [_imageControl setFrame:frame];
    [self addControl:_imageControl];
}



@end

