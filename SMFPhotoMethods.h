//
//  SMFPhotoMethods.h
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//


#import <Backrow/Backrow.h>

@interface SMFPhotoMethods : NSObject {
    
}
+(BOOL)isImageAtPath:(NSString *)path;
/*
 *  returns an NSArray filled with BRPhotoMediaAssets corresponding 
 *  to the different images in folder
 */
+(NSArray *)mediaAssetsForPath:(id)path;

+(NSArray *)photoPathsForPath:(id)path showHidden:(BOOL)hidden;
/*
 *  returns an NSArray with all the photos in the path
 */
+(NSArray *)photoPathsForPath:(id)path;

+(NSArray *)imageProxiesForPath:(NSString *)path;
+(NSMutableArray *)loadImagePathsForPath:(NSString *)path;
+(BRImage *)firstPhotoForPath:(NSString *)path;
+(id)photoCollectionForPath:(NSString *)path;
+(BRDataStore *)dataStoreForAssets:(NSArray *)assets;
+(BRDataStore *)dataStoreForPath:(NSString *)path;
+(BRPhotoMediaAsset *)assetForPhotoFile:(NSString *)pathToPhoto;
+(NSArray *)imageProxiesForPath:(NSString *)path nbImages:(NSInteger)nb;
+(int)imagesCountForPath:(NSString *)path;
@end

@interface SMFPhotoMediaCollection : BRPhotoMediaCollection
@end

@interface SMFPhotoControlFactory : BRPhotoControlFactory
{
    BOOL _mainmenu;
}
@end

@interface SMFPhotoCollectionProvider : BRPhotoDataStoreProvider
{
    int padding[32];
}
@end

@interface SMFPhotoBrowserController : BRPhotoBrowserController 
{
    int		padding[32];
}
-(void)removeSButton;

@end


