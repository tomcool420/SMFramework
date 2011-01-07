//
//  SMFBaseAsset.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/4/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import "SMFBaseAsset.h"
#import "SMFMediaPreview.h"


@implementation SMFBaseAsset
+(SMFBaseAsset *)asset
{
    return [[[SMFBaseAsset alloc ]init] autorelease];
}
-(id)init
{
    self=[super init];
    _meta=[[NSMutableDictionary alloc]init];
    _image=[[BRThemeInfo sharedTheme]appleTVIcon];
    [_image retain];
    return self;
}
-(void)setObject:(id)arg1 forKey:(id)arg2
{
    [_meta setObject:arg1 forKey:arg2];
}
-(void)setTitle:(NSString *)title
{
    [_meta setObject:title forKey:METADATA_TITLE];
}
-(void)setSummary:(NSString *)summary
{
    [_meta setObject:summary forKey:METADATA_SUMMARY];
}
-(void)setCustomKeys:(NSArray *)keys forObjects:(NSArray *)objects
{
    if([keys count]==[objects count])
    {
        [_meta setObject:keys forKey:METADATA_CUSTOM_KEYS];
        [_meta setObject:objects forKey:METADATA_CUSTOM_OBJECTS];
    }
}
-(BRImage *)coverArt
{
    return _image;
}
-(void)setCoverArt:(BRImage *)coverArt
{
    //[_image release];
    _image=[coverArt retain];
}
-(void)setCoverArtPath:(NSString *)path
{
    if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
        [_image release];
        _image=[[BRImage imageWithPath:path] retain];
    }

}
-(NSDictionary *)orderedDictionary
{
    NSMutableDictionary *a=[[NSMutableDictionary alloc] init];
    if([_meta objectForKey:METADATA_TITLE]!=nil)
        [a setObject:[_meta objectForKey:METADATA_TITLE] forKey:METADATA_TITLE];
    if([_meta objectForKey:METADATA_SUMMARY]!=nil)
        [a setObject:[_meta objectForKey:METADATA_SUMMARY] forKey:METADATA_SUMMARY];
    if ([_meta objectForKey:METADATA_CUSTOM_KEYS]!=nil && [_meta objectForKey:METADATA_CUSTOM_OBJECTS]!=nil) {
        [a setObject:[_meta objectForKey:METADATA_CUSTOM_KEYS] forKey:METADATA_CUSTOM_KEYS];
        [a setObject:[_meta objectForKey:METADATA_CUSTOM_OBJECTS] forKey:METADATA_CUSTOM_OBJECTS];
        
    }
    return [a autorelease];
}
- (id)mediaType
{
    return [BRMediaType movie];
}
-(id)assetID
{
    return @"BaseAsset";
}
-(id)title
{
    return [_meta objectForKey:METADATA_TITLE];
}
-(id)summary
{
    return [_meta objectForKey:METADATA_SUMMARY];
}
- (BOOL)hasCoverArt
{
	return YES;
}
- (void)dealloc
{
    [_image release];
    [_meta release];
    [super dealloc];
}
@end
