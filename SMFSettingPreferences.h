//
//  SMFSettingPreferences.h
//  SMFramework
//
//  Created by Thomas Cool on 12/19/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import <BackRow/BackRow.h>


@protocol SMFSettingPreferences
+(NSString *)displayName;
-(NSString *)displayName;
+(BRMenuController *)settingsController;
@optional
-(NSString *)summary;
-(BRImage *)art;
@end
