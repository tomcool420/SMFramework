//
//  SMFThemeInfo.h
//  SMFramework
//
//  Created by Thomas Cool on 10/30/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SynthesizeSingleton.h"

@interface SMFThemeInfo : NSObject {

}
+(SMFThemeInfo *)sharedTheme;
-(BRImage *)selectedImage;
-(BRImage *)colorAppleTVNameImage;
-(BRImage *)keyboardIcon;
-(BRImage *)btstackIcon;
@end
