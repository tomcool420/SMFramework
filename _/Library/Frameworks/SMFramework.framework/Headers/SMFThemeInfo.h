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
-(BRImage *)blackImage;

//The CGColorRefs have been autoreleased
-(CGColorRef)blackColor;
-(CGColorRef)whiteColor;
-(CGColorRef)colorWithRed:(float)r withGreen:(float)g withBlue:(float)b withAlpha:(float)a;
@end
