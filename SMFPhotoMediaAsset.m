//
//  SMFPhotoMediaAsset.m
//  SMFramework
//
//  Created by Thomas Cool on 2/15/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFPhotoMediaAsset.h"


@implementation SMFPhotoMediaAsset
-(id)initWithPath:(NSString *)path
{
    self=[super init];
    [self setFullURL:path];
    [self setThumbURL:path];
    [self setCoverArtURL:path];
    [self setIsLocal:YES];
    _title=[@"" retain];
    return self;
    
}
-(NSString *)title
{
    return _title;
}
-(void)setTitle:(NSString *)title
{
    if (title==nil && ![title isKindOfClass:[NSString class]]) 
        return;
    [_title release];
    _title=nil;
    _title=[title retain];
}
-(void)dealloc
{
    [_title release];
    [super dealloc];
}
@end
