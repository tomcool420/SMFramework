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
-(BRImage *)colorAppleTVNameImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"colorAppleTVNameImage" ofType:@"png"]];
}
-(BRImage *)keyboardIcon
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"Keyboard" ofType:@"png"]];
}
-(BRImage *)btstackIcon
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"btstack" ofType:@"png"]];
}
-(BRImage *)packageImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"package" ofType:@"png"]];
}
-(BRImage *)seatbeltImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"seatbelt" ofType:@"png"]];
}
-(BRImage *)seatbeltLogoImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"seatbeltLogo" ofType:@"png"]];
}
-(BRImage *)mainMenuSettings
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"mainmenusettings" ofType:@"png"]];
}
@end
