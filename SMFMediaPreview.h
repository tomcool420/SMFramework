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
typedef enum {
    kMetaTypePlugin=0,
    kMetaTypeCustom=1,
    kMetaTypeSimple=2,
    kMetaTypeAsset=3,
} SMMetaType;

@interface SMFMediaPreview : BRMetadataPreviewControl{
	NSMutableDictionary			*meta;
    SMMetaType                  MetaDataType;
    BRImage                     *image;
    id                          *_assetCustom;
}

//- (NSMutableDictionary *)getPluginMetaData;
//- (void)setUtilityData:(NSMutableDictionary *)newMeta;
- (id)coverArtForPath;
//- (void)setUtilityData:(NSMutableDictionary *)newMeta;
//- (void)setCustomMetaData:(NSMutableDictionary *)customMeta;
- (void)setImage:(BRImage *)currentImage;
- (void)setImagePath:(NSString *)path;
//- (void)setSimpleMetaDataWithTitle:(NSString *)title andSummary:(NSString *)summary;
//- (void)setAssetMeta:(id)asset;

@end
