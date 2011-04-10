//
//  SMFMediaPreview.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 11/9/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//
/**
 *  SMFMediaPreview is a high level class to be used in conjunction with SMFBaseAsset and it subclasses
 *  It is used to display metadata in media menus (Subclasses of BRmediaMenuController and SMFMediaMenuController)
 *
 *
 *
 */
#import <Backrow/Backrow.h>
#import <Foundation/Foundation.h>
#define METADATA_IMAGE_URL      @"ImageURL"
#define METADATA_TITLE          @"Name"
#define METADATA_SUMMARY        @"Summary"
#define METADATA_CUSTOM_KEYS    @"KeysArray"
#define METADATA_CUSTOM_OBJECTS @"ObjectsArray"
@class SMFBaseAsset, BRMetadataPreviewControl;
@interface SMFMediaPreview : BRMetadataPreviewControl{
    BRImage                     *image;
}

/**
 *Creating a quick media preview that does not require the creation of an SMFBaseAsset.
 *
 *A BRBase Asset is created internaly. it is equivalent to creating this Asset, and adding 
 *using mediaPreviewWithAsset:
 *
 *Adding an asset will overwrite the information generated using this method
 *@param title   title for the preview
 *  An NSString representing the title. 
 *  It will be put in bold over the top line of the preview
 *@param summary text summary (longish text)
 *  General summary, description, or other informative text, newlines are ignored.
 *@param img    a BRImage representing the poster
 *@see mediaPreviewWithAsset:
 */
+(SMFMediaPreview *)simplePreviewWithTitle:(NSString *)title withSummary:(NSString *)summary withImage:(BRImage *)img;
/**
 *Creates an autoreleased SMFMediaPreview with an asset.
 * 
 *Cannot use a BRBaseAsset subclass. It has to be a SMFBaseAsset
 *@param a the asset to be used;
 *@return autoreleased instance of SMFMediaPreview with the Asset set
 *@see mediaPreview
 *@see setAsset:
 */
+(SMFMediaPreview *)mediaPreviewWithAsset:(SMFBaseAsset *)a;

/**
 *Creates an autoreleased SMFMediaPreview.
 * 
 *Cannot use a BRBaseAsset subclass. It has to be a SMFBaseAsset
 *@return autoreleased instance of SMFMediaPreview with no Asset
 *@see mediaPreviewWithAsset:
 *@see simplePreviewWithTitle:withSummary:withImage:
 */
+(SMFMediaPreview *)mediaPreview;

- (id)coverArtForPath;
- (void)setImage:(BRImage *)currentImage;
- (void)setImagePath:(NSString *)path;
/**
 *Add an Asset (SMFBaseAsset) to the preview.
 *
 *@param a the instance of SMFBaseAsset to add to the preview
 *@see asset
 */
-(void)setAsset:(SMFBaseAsset *)a;
/**
 *The Asset containing all the information used to draw the preview
 *
 *@return the saved Asset
 *@see setAsset:
 */
-(SMFBaseAsset *)asset;


@end
