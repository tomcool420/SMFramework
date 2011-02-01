//
//  BRGridController.m
//  SoftwareMenu
//
//  Created by Thomas Cool on 11/5/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//

#import "SMFGridController.h"
#import "../SMFPhotoMethods.h"

#define DEFAULT_IMAGES_PATH		@"/System/Library/PrivateFrameworks/AppleTV.framework/DefaultFlowerPhotos/"

@implementation SMFGridController
@synthesize _path;
-(id)initWithPath:(NSString *)path
{
    self=[self init];
    self._path=path;
    return self;
}

- (void) drawSelf
{
    _spinner=[[BRWaitSpinnerControl alloc]init];
    _cursorControl=[[BRCursorControl alloc] init];
    _scroller=[[BRScrollControl alloc] init];
    _gridControl=[[BRGridControl alloc] init];
    [self setGrid];
    [_gridControl focusControlAtIndex:0];
	[_gridControl setHorizontalGap:0.01f];
    [_gridControl setVerticalGap:0.01f];
    [_scroller setFollowsFocus:YES];
    [_scroller setContent:_gridControl];
    [self layoutSubcontrols];

}

- (void) setGrid
{
    NSString *path = DEFAULT_IMAGES_PATH;
    if (self._path!=nil)
        path=self._path;
    NSArray *assets=[SMFPhotoMethods mediaAssetsForPath:path];
    
    BRDataStore *st = [SMFPhotoMethods dataStoreForAssets:assets];
    SMFPhotoCollectionProvider* provider    = [SMFPhotoCollectionProvider providerWithDataStore:st 
                                                                                 controlFactory:[BRPhotoControlFactory standardFactory]];
    [_gridControl setProvider:provider];
    [_gridControl setColumnCount:5];
    [_gridControl setWrapsNavigation:YES];
    [self setControls:[NSArray arrayWithObjects:_spinner,_cursorControl,_scroller,nil]];
    CGRect masterFrame = [BRWindow interfaceFrame];
	
	
    CGRect frame;
    frame.origin.x = masterFrame.size.width  * 0.0f;
    frame.origin.y = (masterFrame.size.height * 0.0f);// - txtSize.height;
	
    frame.size.width = masterFrame.size.width*1.f;
	frame.size.height = masterFrame.size.height*1.f;
	[_gridControl setAcceptsFocus:YES];
    [_gridControl setWrapsNavigation:YES];
    [_gridControl setProviderRequester:_gridControl];//[NSNotificationCenter defaultCenter]];
    [_scroller setFrame:frame];
    [_gridControl setFrame:frame];
    [_scroller setAcceptsFocus:YES];
    [self addControl:_scroller];
    [self addControl:_spinner];
    [self addControl:_cursorControl];
    
}
-(void)controlWasActivated
{
	[self drawSelf];
    [super controlWasActivated];
	
}
@end
