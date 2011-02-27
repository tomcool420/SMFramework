//
//  SMFPhotoMethods.m
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFPhotoMethods.h"
#import "Classes/BackRowExtras.h"
#import "SMFBaseAsset.h"
#import "SMFPhotoMediaAsset.h"

@implementation SMFPhotoMethods
static NSArray *coverArtExtention=nil;
+(void)initialize
{
    coverArtExtention=[[NSArray alloc] initWithObjects:
                       @"jpg",
                       @"jpeg",
                       @"tif",
                       @"tiff",
                       @"png",
                       @"gif",
                       nil];
}
+(BOOL)isImageAtPath:(NSString *)path
{
    if([coverArtExtention containsObject:[[path pathExtension] lowercaseString]])
        return YES;
    return NO;
}
+(NSArray *)photoPathsForPath:(id)path showHidden:(BOOL)hidden
{
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
    NSMutableArray *files = [NSMutableArray array];
    for(NSString *file in contents)
    {
        if ([coverArtExtention containsObject:[[file pathExtension] lowercaseString]]&&
            (hidden || ![file hasPrefix:@"."])&&
            ![file hasPrefix:@":2e"]) {
            [files addObject:[path stringByAppendingPathComponent:file]];
        }
    }
    return files;
}
+(NSArray *)photoPathsForPath:(id)path
{
    return [SMFPhotoMethods photoPathsForPath:path showHidden:YES];
}

+(int)imagesCountForPath:(NSString *)path
{
    return [[SMFPhotoMethods photoPathsForPath:path showHidden:YES]count];
}
+(BRPhotoMediaAsset *)assetForPhotoFile:(NSString *)pathToPhoto
{
    if([coverArtExtention containsObject:[[pathToPhoto pathExtension] lowercaseString]])
    {
        BRPhotoMediaAsset * asset = [[BRPhotoMediaAsset alloc] init];
        [asset setFullURL:pathToPhoto];
        [asset setThumbURL:pathToPhoto];
        [asset setCoverArtURL:pathToPhoto];
        [asset setIsLocal:YES];
        return [asset autorelease];
    }
    return nil;
}
+(NSArray *)mediaAssetsForPath:(id)path
{
    
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];
	long i, count = [contents count];	
	NSMutableArray *assets =[NSMutableArray array];
	for ( i = 0; i < count; i++ )
	{
		NSString *idStr = [contents objectAtIndex:i];
		if([coverArtExtention containsObject:[[idStr pathExtension] lowercaseString]])
		{
            SMFPhotoMediaAsset *asset = [[SMFPhotoMediaAsset alloc]initWithPath:[path stringByAppendingPathComponent:idStr]];
            [asset setTitle:[idStr stringByDeletingPathExtension]];
//			BRPhotoMediaAsset * asset = [[BRPhotoMediaAsset alloc] init];
//			[asset setFullURL:[path stringByAppendingPathComponent:idStr]];
//			[asset setThumbURL:[path stringByAppendingPathComponent:idStr]];
//			[asset setCoverArtURL:[path stringByAppendingPathComponent:idStr]];
//			[asset setIsLocal:YES];
//			[assets addObject:asset];
//            [asset release];
            [assets addObject:asset];
            [asset release];
		}
	}
	return assets;
}
+(NSArray *)imageProxiesForPath:(NSString *)path
{
    return [SMFPhotoMethods imageProxiesForPath:path nbImages:-1];
}
+(NSArray *)imageProxiesForPath:(NSString *)path nbImages:(NSInteger)nb
{
    NSArray *assets = [SMFPhotoMethods mediaAssetsForPath:path];
    NSMutableArray *proxies = [[NSMutableArray alloc] init];
    if (nb<0 || nb>(NSInteger)[assets count]) 
    {nb=[assets count];}
    int i;
    for (i=0;i<nb;i++)
    {
        [proxies addObject:[NSClassFromString(@"BRXMLImageProxy") imageProxyForAsset:[assets objectAtIndex:i]]];
    }
    return [(NSArray *)proxies autorelease];
}
+(NSMutableArray *)loadImagePathsForPath:(NSString *)path
{
//    NSArray *contents = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];

    NSMutableArray *imagePaths = [NSMutableArray array];
    long i, count = [contents count];	
    for ( i = 0; i < count; i++ )
    {
        NSString *idStr = [contents objectAtIndex:i];
        if([coverArtExtention containsObject:[[idStr pathExtension] lowercaseString]])
            [imagePaths addObject:[path stringByAppendingPathComponent:idStr]];
    }
    return imagePaths;
}

+(BRImage *)firstPhotoForPath:(NSString *)path
{
//    NSArray *contents = [[NSFileManager defaultManager] directoryContentsAtPath:path];
    NSArray *contents = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:path error:nil];

    long i, count = [contents count];	
    
    for ( i = 0; i < count; i++ )
    {
        NSString *idStr = [contents objectAtIndex:i];
        if([coverArtExtention containsObject:[[idStr pathExtension] lowercaseString]])
        {
            return [BRImage imageWithPath:[path stringByAppendingPathComponent:idStr]];
        }
    }
    return nil;
}
+(id)photoCollectionForPath:(NSString *)path
{
    NSArray *assets = [SMFPhotoMethods mediaAssetsForPath:path];
    id collection = [[SMFPhotoMediaCollection alloc]init];
    [collection setMediaAssets:assets];
    if([assets count]>0)
        [collection setKeyAssetID:[[assets objectAtIndex:0] assetID]];
    [collection setCollectionName:[path lastPathComponent]];
    [collection setCollectionType:[BRMediaCollectionType iPhotoSlideshow]];
    return [collection autorelease];
}

+(BRDataStore *)dataStoreForAssets:(NSArray*)assets
{
    NSSet *_set = [NSSet setWithObject:[BRMediaType photo]];
    
    NSPredicate *_pred = [NSPredicate predicateWithFormat:@"mediaType == %@",[BRMediaType photo]];
    BRDataStore *store = [[BRDataStore alloc] initWithEntityName:@"PhotoDataStore" predicate:_pred mediaTypes:_set];
    NSInteger i =0;
    for (i=0;i<(NSInteger)[assets count];i++)
    {
        [store addObject:[assets objectAtIndex:i]];
    }
    return [store autorelease];
}
+(BRDataStore *)dataStoreForPath:(NSString *)path
{
    return [SMFPhotoMethods dataStoreForAssets:[SMFPhotoMethods mediaAssetsForPath:path]];
}
@end

@implementation SMFPhotoMediaCollection
-(id)imageProxy                 {return [BRPhotoImageProxy imageProxyWithAsset:[self keyAsset]];}
-(BOOL)isLocal                  {return YES;}
-(id)description                {return @"SoftwareMenuFramework Collection";}
-(unsigned int)hash             {return 10;}
-(int)count                     {return [[self mediaAssets]count];}
-(id)provider                   {return [BRImageProxyProvider providerWithAssets:[self mediaAssets]];}
-(id)archivableCollectionInfo   {return @"200";}
-(id)collectionID               {return @"200";}
@end


@implementation SMFPhotoCollectionProvider
//Adding something to return a collection
-(BOOL)canHaveZeroData
{
    return NO;
}
-(id)collection
{
    BRPhotoMediaCollection *collection = [BRPhotoMediaCollection collectionWithCollectionInfo:[NSDictionary dictionary]];
    [collection setMediaAssets:[[self dataStore] data]];
    [collection setCollectionName:@"PhotoCollection"];
    [collection setCollectionType:[BRMediaCollectionType iPhotoFolder]];
    return collection;
}
@end
@implementation SMFPhotoBrowserController

- (void)_handleSlideshowSelection:(id)arg1
{

    //    NSMutableDictionary *dict = [[[BRSettingsFacade singleton] slideshowPlaybackOptions] mutableCopy];
    //    BOOL b = [SMPreferences playsMusicInSlideShow];
    //    if(b)
    //    {
    //        NSLog(@"play music");
    //    }
    // [dict setObject:@"YES" forKey:@"PlayMusic"];
    
    //id someClass = NSClassFromString(@"BRMediaPlayerController");
    //int b;
    // id player = [[BRPhotoPlayer alloc ]init ];
    
    //[player setPlayerSpecificOptions:dict];
    // NSLog(@"optionsDict: %@",dict);
    //[player setMediaAtIndex:0 inCollection:[SMImageReturns photoCollectionForPath:[SMPreferences photoFolderPath]] error:nil];
    
    // id controller_two = [someClass controllerForPlayer:player];
    //BRPhotoControlFactory* controlFactory = [BRPhotoControlFactory standardFactory];
    //SMPhotoCollectionProvider* provider    = [SMPhotoCollectionProvider providerWithDataStore:[SMImageReturns dataStoreForPath:[SMPreferences photoFolderPath]] controlFactory:controlFactory];
    id<BRPhotoProviderForCollection> hello = MSHookIvar<id>(self, "_provider");
    id controller_three = [BRFullScreenPhotoController fullScreenPhotoControllerForProvider:hello/*[self provider]*/ startIndex:0];
    [[self stack] pushController:controller_three];
    [controller_three _startSlideshow];
    //[[BRMediaPlayerManager singleton] presentMediaAssetAtIndex:0 inCollection:[SMImageReturns photoCollectionForPath:[SMPreferences photoFolderPath]] options:nil];
    //[[BRFullScreenPhotoController fullScreenPhotoControllerForProvider: startIndex:0] ]
}

//Nothing Really
- (void)removeSButton
{
//    [_slideshowButton setText:@"Play"];
//    NSLog(@"grid: %@",_grid);
//    NSLog(@"controls: %@",[self controls]);
//    NSLog(@"grid controls: %@",[_grid controls]);
//    NSLog(@"grid requester: %@",[_grid providerRequester]);
}

@end