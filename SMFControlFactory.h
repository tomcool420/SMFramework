//
//  SMFControlFactory.h
//  SMFramework
//
//  Created by Thomas Cool on 2/7/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Backrow/Backrow.h>


@interface SMFControlFactory : BRPhotoControlFactory
{
    BOOL _mainmenu;
    BOOL _poster;
    BOOL _alwaysShowTitles;
}
+(SMFControlFactory *)posterControlFactory;
@property (assign)BOOL _poster;
@property (assign)BOOL _alwaysShowTitles;
-(BRControl *)controlForImage:(BRImage *)image title:(NSString *)title;
@end

@interface SMFPhotoControlFactory : SMFControlFactory
@end

