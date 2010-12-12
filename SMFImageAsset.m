//
//  SMFImageAsset.m
//  SMFramework
//
//  Created by Thomas Cool on 12/11/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFImageAsset.h"
#import "SMFPhotoMethods.h"
#import "SMFMediaPreview.h"
@implementation SMFImageAsset
-(id)initWithPath:(NSString *)path
{
    if (![SMFPhotoMethods isImageAtPath:path])
        return nil;
    self=[super init];
    [_image release];
    _image=[[BRImage imageWithPath:path] retain];
    _path = [path retain];
    [self setTitle:[_path lastPathComponent]];
    return self;
    
}
-(NSDictionary *)orderedDictionary
{
    NSMutableDictionary *a=[[NSMutableDictionary alloc] init];
    if([_meta objectForKey:METADATA_TITLE]!=nil)
        [a setObject:[_meta objectForKey:METADATA_TITLE] forKey:METADATA_TITLE];
    NSArray *keys = [NSArray arrayWithObjects:@"Width",@"Height",@"Size",nil];
    CGSize s = [_image pixelBounds];
    NSArray *objects = [NSArray arrayWithObjects:
                        [NSString stringWithFormat:@"%d Pixels",(int)s.width,nil],
                        [NSString stringWithFormat:@"%d Pixels",(int)s.height,nil],
                        [self fileSize],
                        nil];
    [a setObject:keys forKey:METADATA_CUSTOM_KEYS];
    [a setObject:objects forKey:METADATA_CUSTOM_OBJECTS];
    return [a autorelease];
}
-(NSString *)fileSize
{
    NSDictionary *att = [[NSFileManager defaultManager] attributesOfItemAtPath:_path error:nil];
    double size = [[att objectForKey:NSFileSize] doubleValue];
    int mod=0;
    while (size>1024.0f) {
        size=size/1024.0f;
        mod++;
    }
    NSString *ext=@"B";
    if (mod==1) 
        ext=@"KB";
    else if(mod==2)
        ext=@"MB";
    else if(mod==2)
        ext=@"GB";
    else if(mod==2)
        ext=@"TB";
    return [NSString stringWithFormat:@"%.2f%@",size,ext,nil];
    
}
@end
