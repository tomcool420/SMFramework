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
    __title=[@"" retain];
    return self;
    
}
-(NSString *)title
{
    return __title;
}
-(void)setTitle:(NSString *)title
{
    if (title==nil && ![title isKindOfClass:[NSString class]]) 
        return;
    [__title release];
    __title=nil;
    __title=[title retain];
}
-(void)dealloc
{
    [__title release];
    [super dealloc];
}
@end
