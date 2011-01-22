//
//  SMFThemeInfo.m
//  SMFramework
//
//  Created by Thomas Cool on 10/30/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFThemeInfo.h"

//static float red[]=  {0.0,0.0,0.6,0.0,0.33,0.0,0.66,1.0,1.0,0.5,1.0,1.0,1.0};
//static float green[]={0.0,0.0,0.4,1.0,0.33,1.0,0.66,0.0,0.5,0.0,0.0,1.0,1.0};
//static float blue[] ={0.0,1.0,0.2,1.0,0.33,0.0,0.66,1.0,0.0,0.5,0.0,1.0,0.0};
static NSArray * colors=nil;
@implementation SMFThemeInfo
static SMFThemeInfo *sharedTheme = nil; 

+ (SMFThemeInfo *)sharedTheme 
{ 
	@synchronized(self) 
	{ 
		if (sharedTheme == nil) 
		{ 
			sharedTheme = [[self alloc] init]; 
		} 
	} 
    
	return sharedTheme; 
} 

+ (id)allocWithZone:(NSZone *)zone 
{ 
	@synchronized(self) 
	{ 
		if (sharedTheme == nil) 
		{ 
			sharedTheme = [super allocWithZone:zone]; 
            colors = [[NSArray arrayWithObjects:@"Black",@"Blue",@"Brown",@"Cyan",@"Dark Gray",@"Green",
                       @"Light Gray",@"Magenta",@"Orange",@"Purple",@"Red",@"White",@"Yellow",nil] retain];
			return sharedTheme; 
		} 
	} 
    
	return nil; 
} 
- (id)copyWithZone:(NSZone *)zone   { return self; } 
- (id)retain                        { return self; } 
- (NSUInteger)retainCount           { return NSUIntegerMax;}
- (void)release                     {} 
- (id)autorelease                   { return self; }

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
-(BRImage *)blackImage
{
    return [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"black" ofType:@"png"]];
}
-(CGColorRef)colorWithRed:(float)r withGreen:(float)g withBlue:(float)b withAlpha:(float)a
{
    CGFloat myColor[] = {r, g, b, a};
    CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
    CGColorRef color = CGColorCreate(rgb, myColor);
    CGColorSpaceRelease(rgb);
    [(id)color autorelease];
    return color;
}

-(CGColorRef)blackColor
{
    return [self colorWithRed:0.0 withGreen:0.0 withBlue:0.0 withAlpha:1.0];
}
-(CGColorRef)whiteColor
{
    return [self colorWithRed:1.0 withGreen:1.0 withBlue:1.0 withAlpha:1.0];
}
@end
