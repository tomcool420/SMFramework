//
//  SMFPhotoMethods.h
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//


#import "Backrow/AppleTV.h"
#import "SMFControlFactory.h"
/**
 *Convenience methods to work with pictures on ATV 2
 */
@interface SMFPhotoMethods : NSObject {
    
}
///-----------------------------------
/// @name Checks
///-----------------------------------
/**
 *Checks if the file extention is that of a readable image (png,jpeg,tiff,bmp,gif,jpg)
 *@return `YES` if it is. `NO` otherwise
 *@todo check if it exists
 *@param path of file to check
 */
+(BOOL)isImageAtPath:(NSString *)path;

/**
 *@param path the path to a FOLDER
 *@return the number of image in the folder given by path
 */
+(int)imagesCountForPath:(NSString *)path;
///------------------------------------
/// @name Getting Image Paths
///------------------------------------

/**
 *@param path the path to a FOLDER
 *@param hidden include hidden images?
 *@return an NSArray filled with NSStrings corresponding 
 *  to the different images in folder
 *@see mediaAssetsForPath:
 */
+(NSArray *)photoPathsForPath:(NSString *)path showHidden:(BOOL)hidden;
/**
 *@param path the path to a FOLDER
 *@return an NSArray filled with NSStrings corresponding 
 *  to the different images in folder
 *@see photoPathsForPath:showHidden:
 *@note calls photoPathsForPath:showHidden with `hidden=YES`
 */
+(NSArray *)photoPathsForPath:(NSString *)path;

///-----------------------------------
/// @name Loading Images
///-----------------------------------

/**
 *@param path path to a FOLDER
 *@return an NSArray filled with BRXMLImageProxy instances 
 *  corresponding to the images in the folder
 *@see imageProxiesForPath:nbImages:
 *@note calls imagesProxiesForPath:nbImages: with nb=-1
 */
+(NSArray *)imageProxiesForPath:(NSString *)path;
/**
 *@param path path to a FOLDER
 *@param nb number of images to load
 *  - if -1, load all images
 *  - if greater than number of images, load maximum available
 *@return an NSArray filled with BRXMLImageProxy instances 
 *  corresponding to the images in the folder
 *@see imageProxiesForPath:
 */
+(NSArray *)imageProxiesForPath:(NSString *)path nbImages:(NSInteger)nb;


/**
 *@param path the path to a FOLDER
 *@return an NSArray filled with BRPhotoMediaAssets corresponding 
 *  to the different images in folder excluding hidden pictures
 *@see assetForPhotoFile:
 */
+(NSArray *)mediaAssetsForPath:(id)path;

/**
 *@param path the path to a FOLDER
 *@returns a BRImage with the first image (alphabetical) in the folder 
 */
+(BRImage *)firstPhotoForPath:(NSString *)path;
/**
 *Creates a SMFPhotoMediaCollection (BRPhotoMediaCollection subclass) populated with the images 
 *  from path and returns it
 *@param path The path to a FOLDER
 *@return the Collection
 */
+(BRPhotoMediaCollection *)photoCollectionForPath:(NSString *)path;
/**
 *Create a BRDataStore for Assets (BRBaseAsset subclasses)
 *@param assets NSArray containing BRBaseAsset objects
 *@return a BRDataStore object
 */
+(BRDataStore *)dataStoreForAssets:(NSArray *)assets;
/**
 *Create a BRDataStore for a Path
 *@param path to a FOLDER containing images
 *@return a BRDataStore object
 *@note calls mediaAssetsForPath: and dataStoreForAssets:
 *@see mediaAssetsForPath:
 *@see dataStoreForAssets:
 */
+(BRDataStore *)dataStoreForPath:(NSString *)path;
/**
 *creates a BRPhotoMediaAsset with a picture file
 *@param pathToPhoto path to a picture
 *@return a BRPhotoMediaAsset with picture data in it
 *@see assetForPhotoFile:
 *
 */
+(BRPhotoMediaAsset *)assetForPhotoFile:(NSString *)pathToPhoto;




///-----------------------
/// @name deprecated
///-----------------------
/**
 *Same as photoPathsForPath:
 *@bug Warning: deprecated
 */
+(NSMutableArray *)loadImagePathsForPath:(NSString *)path;
@end

@interface SMFPhotoMediaCollection : BRPhotoMediaCollection
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


