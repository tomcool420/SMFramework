//
//  SMFThemeInfo.h
//  SMFramework
//
//  Created by Thomas Cool on 10/30/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SynthesizeSingleton.h"

@interface SMFThemeInfo : NSObject {

}
+(SMFThemeInfo *)sharedTheme;
-(BRImage *)selectedImage;
-(BRImage *)colorAppleTVNameImage;
-(BRImage *)keyboardIcon;
-(BRImage *)btstackIcon;
-(BRImage *)packageImage;
-(BRImage *)seatbeltImage;
-(BRImage *)seatbeltLogoImage;
-(BRImage *)mainMenuSettings;

/*
 *  A simple black image of size 1280*720 
 *  Useful to use to darken an image by applying a transparency filter
 */
-(BRImage *)blackImage;

//The CGColorRefs have been autoreleased
-(CGColorRef)blackColor;
-(CGColorRef)blueColor;
-(CGColorRef)brownColor;
-(CGColorRef)cyanColor;
-(CGColorRef)darkGrayColor;
-(CGColorRef)greenColor;
-(CGColorRef)lightGrayColor;
-(CGColorRef)magentaColor;
-(CGColorRef)orangeColor;
-(CGColorRef)purpleColor;
-(CGColorRef)redColor;
-(CGColorRef)whiteColor;
-(CGColorRef)yellowColor;

/* Method used to easily create CGColors
 *
 *  r,g,b,a are floats 0.0<value<1.0
 *
 *  return: autoreleased CGColorRef
 */
-(CGColorRef)colorWithRed:(float)r withGreen:(float)g withBlue:(float)b withAlpha:(float)a;
@end
