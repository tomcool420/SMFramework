//
//  SMFControlFactory.m
//  SMFramework
//
//  Created by Thomas Cool on 2/7/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFControlFactory.h"
#import "SMFPhotoMethods.h"

@implementation SMFControlFactory
@synthesize _poster;
@synthesize _alwaysShowTitles;
+(id)mainMenuFactory
{
    return [[[SMFControlFactory alloc] initForMainMenu:YES] autorelease];
}
+(id)standardFactory
{
    SMFControlFactory *a = [[[SMFControlFactory alloc] initForMainMenu:NO] autorelease];
    return a;
}
+(SMFControlFactory *)posterControlFactory
{
    SMFControlFactory *a =[[[SMFControlFactory alloc] initForMainMenu:NO] autorelease];
    a._poster=YES;
    return a;
}
//Returns the control shown on main menu
-(id)initForMainMenu:(BOOL)arg1
{
    self = [super initForMainMenu:arg1];
    _mainmenu = arg1;
    self._poster=NO;
    self._alwaysShowTitles=NO;
    return self;
}
-(id)controlForData:(id)arg1 currentControl:(id)arg2 requestedBy:(id)arg3
{
    id returnObj=nil;
    if([arg1 isKindOfClass:[SMFPhotoMediaCollection class]])
    {
        BRDataStore *store = [SMFPhotoMethods dataStoreForAssets:[arg1 mediaAssets]];
        BRPhotoControlFactory* controlFactory = [BRPhotoControlFactory mainMenuFactory];
        SMFPhotoCollectionProvider* provider    = [SMFPhotoCollectionProvider providerWithDataStore:store controlFactory:controlFactory];
        returnObj = [BRCyclerControl cyclerWithProvider:provider];
        if([[arg1 mediaAssets]count]>0)
            [returnObj setAcceptsFocus:YES];
        [returnObj setObject:arg1];
        [returnObj setStartIndex:0];
    }
    else if([arg1 isKindOfClass:[BRImageProxyProvider class]])
    {
        BRBaseMediaAsset *a = [[arg1 dataAtIndex:0]asset];
        if ([a respondsToSelector:@selector(coverArt)]) {
            returnObj= [self controlForImage:[(BRPhotoMediaAsset *)a coverArt] title:[a title]];
        }
        else 
            returnObj= [ self controlForImage:[[a imageProxy] defaultImage] title:[a title]];

        
    }
    else if([arg1 isKindOfClass:[BRPhotoMediaAsset class]])
    {
        NSString *t = [(BRPhotoMediaAsset *)arg1 title];
        if (t==nil)
            t=[[[arg1 coverArtURL]lastPathComponent] stringByDeletingPathExtension];
        returnObj = [self controlForImage:[arg1 coverArt] title:t];
    }
    else if([arg1 isKindOfClass:[BRBaseMediaAsset class]])
    {
        id proxy = nil;//[arg1 coverArt];
        if ([arg1 respondsToSelector:@selector(coverArt)]) {
            proxy=[arg1 coverArt];
        }
        if(proxy == nil)
            proxy = [arg1 imageProxy];
        if (proxy==nil) 
            return nil;
        
        if (self._poster=YES) {
            BRImage *img = nil;
            if ([proxy conformsToProtocol:@protocol(BRImageProxy)])
                img=[proxy defaultImage];
            else if([proxy isKindOfClass:[BRImage class]])
                img=proxy;
                
            returnObj=[BRPosterControl posterButtonWithImage:img title:[arg1 title]];
            ((BRPosterControl *)returnObj).alwaysShowTitles=self._alwaysShowTitles;
        }
        else {
            if ([proxy conformsToProtocol:@protocol(BRImageProxy)]) 
                returnObj = [[BRAsyncImageControl alloc] initWithImageProxy:proxy];
            else if([proxy isKindOfClass:[BRImage class]])
                returnObj = [[BRAsyncImageControl alloc] initWithImage:proxy];
            if (returnObj!=nil) {
                [returnObj setAcceptsFocus:YES];
                [returnObj autorelease];
            }
        }
    }
    else if([arg1 isKindOfClass:[BRDividerControl class]])
    {
        NSLog(@"divider");
        returnObj=arg1;
    }
    
    
    //returning nothing is also acceptable only for main menu
    return returnObj;
}
-(BRControl *)controlForImage:(BRImage *)image title:(NSString *)title
{
    if (_poster==YES) {
        BRPosterControl *returnObj=[BRPosterControl posterButtonWithImage:image title:title];
        returnObj.alwaysShowTitles=self._alwaysShowTitles;
        returnObj.posterBorderWidth=1.f;
        returnObj.titleWidthScale=1.3999999761581421;
        returnObj.titleVerticalOffset=-0.054999999701976776;
        returnObj.reflectionAmount=0.14000000059604645;
        return returnObj;
    }
    else {
        BRAsyncImageControl *returnObj = [BRAsyncImageControl imageControlWithImage:image];
        [returnObj setAcceptsFocus:YES];
        return returnObj;
    }
}
@end
@implementation SMFPhotoControlFactory
@end