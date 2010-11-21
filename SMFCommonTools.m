//
//  SMFCommonTools.m
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFCommonTools.h"


@implementation SMFCommonTools

+(id)popupControlWithLines:(NSArray *)array andImage:(BRImage *)image
{
    id ctrl =[[NSClassFromString(@"SMFPopupInfo") alloc] init];
    if (image==nil) 
        return nil;
    NSDictionary *dict;
    if (array==nil) {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              [[BRThemeInfo sharedTheme]geniusIcon],@"Image",
                              nil];
    }
    else {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                [[BRThemeInfo sharedTheme]geniusIcon],@"Image",
                array,@"Lines",nil];
        
    }
    [ctrl setObject:dict];
    return [ctrl autorelease];
}
+(void)showPopup:(id)popup
{
    if (popup==nil) {
        return;
    }
    id manager  = [BRPopUpManager sharedInstance];
    if (manager==nil) {
        [BRPopUpManager setSingleton:[[BRPopUpManager alloc]init]];
    }
    [[BRPopUpManager sharedInstance] postPopUpWithControl:popup 
                                               identifier:@"SMFPopup" 
                                                 position:6 
                                                     size:CGSizeMake(0.9, 0.15)
                                                  options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"BRPopUpPostImmediately",
                                                           [NSNumber numberWithInt:8],@"BRPopUpTimeoutValueKey",nil]];
}
@end
