//
//  SMFMoviePreviewDelegateDatasource.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Backrow/AppleTV.h"

@protocol SMFMoviePreviewControllerDatasource
-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)summary;
-(NSArray  *)headers;
-(NSArray  *)columns;
-(NSString *)rating;
-(BRImage *)coverArt;
-(BRPhotoDataStoreProvider *)providerForShelf;

@optional
-(NSString *)shelfTitle;
-(NSArray *)buttons;
-(NSString *)posterPath;
@end

@class SMFMoviePreviewController;
@protocol SMFMoviePreviewControllerDelegate
//If a delegate responds to a method... 
//it needs to implement the sounds for selection itself
//See SMFThemeInfo or BRSoundHandler
-(void)controller:(SMFMoviePreviewController *)c selectedControl:(BRControl *)ctrl;
@optional
-(void)controller:(SMFMoviePreviewController *)c buttonSelectedAtIndex:(int)index;
-(void)controller:(SMFMoviePreviewController *)c switchedFocusTo:(BRControl *)newControl;
-(void)controller:(SMFMoviePreviewController *)c shelfLastIndex:(long)index;
-(void)controllerSwitchToNext:(SMFMoviePreviewController *)c ;
-(void)controllerSwitchToPrevious:(SMFMoviePreviewController *)c ;
-(BOOL)controllerCanSwitchToNext:(SMFMoviePreviewController *)c ;
-(BOOL)controllerCanSwitchToPrevious:(SMFMoviePreviewController *)c;
@end