//
//  SMFThemeInfo.m
//  SMFramework
//
//  Created by Thomas Cool on 10/30/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFThemeInfo.h"


@implementation SMFThemeInfo
SYNTHESIZE_SINGLETON_FOR_CLASS(SMFThemeInfo,sharedTheme)
-(BRImage *)selectedImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"selsettings" ofType:@"png"]];
}
@end
