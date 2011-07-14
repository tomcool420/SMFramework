//
//  SMFMoviePreviewDelegateAndDatasourceExample.m
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//
#import "../SMFMoviePreviewController.h"
#import "SMFMoviePreviewDelegateAndDatasourceExample.h"

@implementation SMFMoviePreviewDelegateAndDatasourceExample
#pragma mark datasource methods
-(NSString *)title
{
    return @"Awesomeness";
}
-(NSString *)subtitle
{
    return @"An AwkwardTV Production";
}
-(NSString *)summary
{
    return @"Awesomeness, a history of development on the AppleTV. from tragedy to comedy, from whining to bitching, from compliments to insults: the History of the AppleTV in 5 acts. Complete with exta bashing, QQ and whining";
}
-(NSArray *)headers
{
    return [NSArray arrayWithObjects:@"Details",@"Actors",@"Director",@"Producers",nil];
}
-(NSArray *)columns
{
    NSArray *actors = [NSArray arrayWithObjects:@"|bile|",@"davilla",@"erica",@"mringwal",@"tomcool",nil];
    NSArray *directors = [NSArray arrayWithObjects:@"macTijn",@" ",
                          [[[NSAttributedString alloc]initWithString:@"Art Director" 
                                                          attributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]]autorelease],
                          @"Leddy",nil];
    NSArray *producers = [NSArray arrayWithObjects:@"Alan Quatermain",@"gbooker",@"DHowett",nil];
    BRImage *i = [[BRThemeInfo sharedTheme] hdBadge];
    NSArray *details = [NSArray arrayWithObjects:
                        @"Action & Comedy",
                        @"Released: 2010",
                        [NSArray arrayWithObjects:
                         i,
                         [[[NSAttributedString alloc] initWithString:@" 2" attributes:[[BRThemeInfo sharedTheme]metadataTitleAttributes]]autorelease],
                         i,nil],
                        @"Run Time: Years",
                        [[SMFThemeInfo sharedTheme]fourPointFiveStars],
                        nil];
    NSArray *objects = [NSArray arrayWithObjects:details,actors,directors,producers,nil];
    return objects;
}
-(NSString *)rating
{
    return @"R";
}
-(BRImage *)coverArt
{
    return [BRImage imageWithPath:[self posterPath]];
}
-(NSString *)posterPath
{
    return [[NSBundle bundleForClass:[self class]]pathForResource:@"poster" ofType:@"jpg"];
}
-(BRPhotoDataStoreProvider *)providerForShelf
{
    NSSet *_set = [NSSet setWithObject:[BRMediaType photo]];
    NSPredicate *_pred = [NSPredicate predicateWithFormat:@"mediaType == %@",[BRMediaType photo]];
    BRDataStore *store = [[BRDataStore alloc] initWithEntityName:@"Hello" predicate:_pred mediaTypes:_set];
    NSArray *assets = [SMFPhotoMethods mediaAssetsForPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"Posters" ofType:@""]];
    for (id a in assets) {
        [store addObject:a];
    }
    
    //id dSPfCClass = NSClassFromString(@"BRPhotoDataStoreProvider");
    
    id tcControlFactory = [BRPosterControlFactory factory];
    id provider    = [BRPhotoDataStoreProvider providerWithDataStore:store controlFactory:tcControlFactory];
    [store release];
    return provider; 
}
-(NSArray *)buttons
{
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    BRButtonControl* b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]previewActionImage] 
													   subtitle:@"Preview" 
														  badge:nil];
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]playActionImage] 
									  subtitle:@"Play"
										 badge:nil];
    
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]queueActionImage] 
									  subtitle:@"Queue" 
										 badge:nil];
    
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]rateActionImage] 
									  subtitle:@"More" 
										 badge:nil];
    [buttons addObject:b];
    return [buttons autorelease];
    
}
#pragma mark delegate methods (examples)
-(void)controller:(SMFMoviePreviewController *)c selectedControl:(BRControl *)ctrl {
	NSLog(@"controller of type %@ selected", [ctrl class]);
}
//optional
-(void)controller:(SMFMoviePreviewController *)c buttonSelectedAtIndex:(int)index {
	NSLog(@"button at index %d selected", index);
}
-(void)controller:(SMFMoviePreviewController *)c switchedFocusTo:(BRControl *)newControl {
	NSLog(@"controller of type %@ focused", [newControl class]);	
}
-(void)controller:(SMFMoviePreviewController *)c shelfLastIndex:(long)index {
	NSLog(@"last index of shelf was %d", index);	
}
-(void)controllerSwitchToNext:(SMFMoviePreviewController *)c {
	//flash arrow on, then off
	[c switchNextArrowOn];
	[c performSelector:@selector(switchNextArrowOff) withObject:nil afterDelay:0.7f];
}
-(void)controllerSwitchToPrevious:(SMFMoviePreviewController *)c {
	//flash arrow on, then off
	[c switchPreviousArrowOn];
	[c performSelector:@selector(switchPreviousArrowOff) withObject:nil afterDelay:0.7f];
}
-(BOOL)controllerCanSwitchToNext:(SMFMoviePreviewController *)c {
	return YES;
}
-(BOOL)controllerCanSwitchToPrevious:(SMFMoviePreviewController *)c {
	return YES;	
}


@end
