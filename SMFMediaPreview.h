//
//  SMFMediaPreview.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 11/9/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//
#import <Backrow/Backrow.h>
#define METADATA_IMAGE_URL      @"ImageURL"
#define METADATA_TITLE          @"Name"
#define METADATA_SUMMARY        @"Summary"
#define METADATA_CUSTOM_KEYS    @"KeysArray"
#define METADATA_CUSTOM_OBJECTS @"ObjectsArray"
@class SMFBaseAsset;
@interface SMFMediaPreview : BRMetadataPreviewControl{
    BRImage                     *image;
}
/*
 *  A nice and simple autoreleased media preview already populated with an asset
 */
+(SMFMediaPreview *)simplePreviewWithTitle:(NSString *)title withSummary:(NSString *)summary withImage:(BRImage *)img;
+(SMFMediaPreview *)mediaPreviewWithAsset:(SMFBaseAsset *)a;
+(SMFMediaPreview *)mediaPreview;

- (id)coverArtForPath;
- (void)setImage:(BRImage *)currentImage;
- (void)setImagePath:(NSString *)path;


@end
