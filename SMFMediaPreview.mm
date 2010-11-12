//
//  SMFMediaPreview.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 11/9/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//


#import "SMFMediaPreview.h"
#import "SMFBaseAsset.h"
#import "Classes/BackRowExtras.h"
@interface BRCoverArtImageLayer (compat)
-(id)texture;
@end

/*These interfaces are to access variables not available*/
//@interface BRMetadataControl (protectedAccess)
//- (NSArray *)gimmieMetadataObjs;
//@end
//
//
///* There is no BRMetadataLayer class in ATV2.0 anymore, it seems to be BRMetadataControl now*/
///* So just do the same stuff as above, but for BRMetadataControl*/
//
//@implementation BRMetadataControl (protectedAccess)
//	-(NSArray *)gimmieMetadataObjs {
//	Class klass = [self class];
//	Ivar ret = class_getInstanceVariable(klass, "_metadataObjs");
//	return *(NSArray * *)(((char *)self)+ret->ivar_offset);
//}
//@end


@interface BRMetadataPreviewControl (compat)
- (void)_populateMetadata;
- (void)_updateMetadataLayer;
- (id) _loadCoverArt;
@end

@interface BRMetadataPreviewControl (protectedAccess)
- (BRMetadataControl *)gimmieMetadataLayer;
@end

@implementation BRMetadataPreviewControl (protectedAccess)
- (BRMetadataControl *)gimmieMetadataLayer
{
//	Class myClass = [self class];
//	Ivar ret = class_getInstanceVariable(myClass,"_metadataLayer");
//	
	return MSHookIvar<BRMetadataControl *>(self, "_metadataLayer");
}
@end

@interface SMFMediaPreview (Custom)
- (void)doPopulation;
- (NSString *)coverArtForPath;
@end

@implementation SMFMediaPreview

/*List of extensions to look for cover art*/
static NSSet *coverArtExtentions = nil;

+ (void)initialize
{
	/*Initialize the set of cover art extensions*/
	coverArtExtentions = [[NSSet alloc] initWithObjects:
		@"jpg",
		@"jpeg",
		@"tif",
		@"tiff",
		@"png",
		@"gif",
		nil];
}
-(BRCoverArtImageLayer *)coverArtLayer
{
	return MSHookIvar<BRCoverArtImageLayer *>(self, "_coverArtLayer");
}
- (id)init
{
    self=[super init];
    meta=[[NSMutableDictionary alloc] init];
    
    [meta setObject:@"No Title" forKey:METADATA_TITLE];
    image=[[BRThemeInfo sharedTheme] appleTVIcon];
    [image retain];
    return self;
}

- (void)dealloc
{
	[meta release];
    [image release];
    //[coverArtExtentions release];
	//[dirMeta release];
	[super dealloc];
}

//- (void)setUtilityData:(NSMutableDictionary *)newMeta
//{
//	[meta release];
//	meta=[newMeta retain];
//	SMFMedia *asset  =[SMFMedia alloc];
//	[asset setDefaultImage];
//	[self setAsset:asset];
//
//}

- (void)setImage:(BRImage *)currentImage
{
    [image release];
    image=[currentImage retain];
//    NSLog(@"%@",_asset);
//    [_asset setBRImage:image];
//    if (_asset!=nil && [_asset respondsToSelector:@selector(setBRImage:)])
//        [_asset setBRImage:image];
    BRCoverArtImageLayer * c = [self coverArtLayer];
    [c setImage:image];
//    [_reflectionLayer setImage:image];
//    [_reflectionLayer setReflectionAmount:0.337531];
}
- (void)setImagePath:(NSString *)path
{
    if([[NSFileManager defaultManager] fileExistsAtPath:path] && [coverArtExtentions containsObject:[path pathExtension]])
    {
        [self setImage:[BRImage imageWithPath:path]];
    }
    
}

- (void)setAsset:(id)a
{
    //NSLog(@"assetMeta: %@",asset);
    MetaDataType=kMetaTypeAsset;
    [super setAsset:a];
    BRReflectionControl *c = MSHookIvar<BRReflectionControl *>(self, "_reflectionLayer");
    [c setImage:[a coverArt]];
    [c setReflectionAmount:0.337531];
    
    [[self coverArtLayer] setImage:[a coverArt]];
    
    //[_coverArtLayer setImage:[asset coverArt]];
    //NSLog(@"_asset: %@",_asset);
    
    //[self _updateMetadataLayer];
}
-(void)setAssetMeta:(id)a
{
    [self setAsset:a];
}




- (id)coverArtForPath
{
    if (image!=nil)
        return image;
    image=[[self asset] coverArt];
    if (image!=nil)
        return image;
	return [[BRThemeInfo sharedTheme] appleTVIcon];
}


- (id)_loadCoverArt
{
    //NSLog(@"loading cover art");
	[super _loadCoverArt];
	if([[self coverArtLayer] texture] != nil)
		return nil;
	id localImage = [self coverArtForPath];
    
    BRReflectionControl *c = MSHookIvar<BRReflectionControl *>(self, "_reflectionLayer");
    [c setImage:localImage];
    [c setReflectionAmount:0.337531];
    
    [[self coverArtLayer] setImage:localImage];
    
	return nil;
}

- (void)_populateMetadata
{
    //NSLog(@"_populate");
	[super _populateMetadata];
	[self doPopulation];
}


- (void)_updateMetadataLayer
{
    //NSLog(@"update");
	[super _updateMetadataLayer];
	[self doPopulation];
}

- (void)doPopulation
{
    //NSLog(@"doPopulation");
    BRMetadataControl *metaLayer = [self gimmieMetadataLayer];
    switch (MetaDataType) {
        case kMetaTypeAsset:
        {
            id a = [self asset];
            if ([a respondsToSelector:@selector(orderedDictionary)]) {
                NSDictionary *assetDict=[a orderedDictionary];
                if([[assetDict allKeys] containsObject:METADATA_TITLE])
                    [metaLayer setTitle:[assetDict objectForKey:METADATA_TITLE]];
                if([[assetDict allKeys] containsObject:METADATA_SUMMARY])
                    [metaLayer setSummary:[assetDict objectForKey:METADATA_SUMMARY]];
                if([[assetDict allKeys] containsObject:METADATA_CUSTOM_KEYS])
                {
                    //NSLog(@"%@",[assetDict objectForKey:METADATA_CUSTOM_OBJECTS]);
                    //NSLog(@"%@",[assetDict objectForKey:METADATA_CUSTOM_KEYS]);
                    [metaLayer setMetadata:[assetDict objectForKey:METADATA_CUSTOM_OBJECTS] withLabels:[assetDict objectForKey:METADATA_CUSTOM_KEYS]];
                }
            }
            break;
        }
        default:
        {
            [metaLayer setTitle:[meta objectForKey:METADATA_TITLE]];
            [metaLayer setSummary:[meta objectForKey:METADATA_SUMMARY]];
            break;
        }
           
    }
    //`NSLog(@"donePopulating");
	
	

}


- (BOOL)_assetHasMetadata
{
	return YES;
}

@end



