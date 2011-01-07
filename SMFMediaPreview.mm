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




//@interface BRMetadataPreviewControl (protectedAccess)
//- (BRMetadataControl *)gimmieMetadataLayer;
//@end

//@implementation BRMetadataPreviewControl (protectedAccess)
//- (BRMetadataControl *)gimmieMetadataLayer
//{
////	Class myClass = [self class];
////	Ivar ret = class_getInstanceVariable(myClass,"_metadataLayer");
////	
//	return MSHookIvar<BRMetadataControl *>(self, "_metadataLayer");
//}
//@end

@interface SMFMediaPreview (Custom)
- (void)doPopulation;
- (NSString *)coverArtForPath;
@end

@implementation SMFMediaPreview


+(SMFMediaPreview *)simplePreviewWithTitle:(NSString *)title withSummary:(NSString *)summary withImage:(BRImage *)img
{
    SMFBaseAsset *a = [SMFBaseAsset asset];
    if (title)
        [a setTitle:title];
    if(summary)
        [a setSummary:summary];
    if(img)
        [a setCoverArt:img];
    SMFMediaPreview *p = [[SMFMediaPreview alloc] init];
    [p setAsset:a];
    return [p autorelease];
}
+(SMFMediaPreview *)mediaPreview
{
    return [[[SMFMediaPreview alloc] init] autorelease];
}
+(SMFMediaPreview *)mediaPreviewWithAsset:(SMFBaseAsset *)a
{
    SMFMediaPreview *p = [[SMFMediaPreview alloc] init];
    [p setAsset:a];
    return [p autorelease];
}
-(BRCoverArtImageLayer *)coverArtLayer
{
	return MSHookIvar<BRCoverArtImageLayer *>(self, "_coverArtLayer");
}
- (id)init
{
    self=[super init];
    
    image=[[BRThemeInfo sharedTheme] appleTVIcon];
    [image retain];
    return self;
}

- (void)dealloc
{
    [image release];
	[super dealloc];
}


- (void)setImage:(BRImage *)currentImage
{
    [image release];
    image=[currentImage retain];
    BRCoverArtImageLayer * c = [self coverArtLayer];
    [c setImage:image];
}
- (void)setImagePath:(NSString *)path
{
    if([[NSFileManager defaultManager] fileExistsAtPath:path])
    {
        [self setImage:[BRImage imageWithPath:path]];
    }
    
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

- (void)_updateMetadataLayer
{
	[super _updateMetadataLayer];
	[self doPopulation];
}

- (void)doPopulation
{
    //BRMetadataControl *metaLayer = [self gimmieMetadataLayer];
    BRMetadataControl *metaLayer = [self metadataControl];
    id a = [self asset];
    if ([a respondsToSelector:@selector(orderedDictionary)]) {
        NSDictionary *assetDict=[a orderedDictionary];
        if([[assetDict allKeys] containsObject:METADATA_TITLE])
            [metaLayer setTitle:[assetDict objectForKey:METADATA_TITLE]];
        if([[assetDict allKeys] containsObject:METADATA_SUMMARY])
            [metaLayer setSummary:[assetDict objectForKey:METADATA_SUMMARY]];
        if([[assetDict allKeys] containsObject:METADATA_CUSTOM_KEYS])
        {
            [metaLayer setMetadata:[assetDict objectForKey:METADATA_CUSTOM_OBJECTS] withLabels:[assetDict objectForKey:METADATA_CUSTOM_KEYS]];
        }
    }
	
	

}


- (BOOL)_assetHasMetadata
{
    if ([[self asset] respondsToSelector:@selector(orderedDictionary)]) {
        return YES;
    }
    NSLog(@"asset has not meta??");
	return YES;
}

@end



