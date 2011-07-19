//
//  SMFPrefsMenuItemProtocol.h
//  SMFramework
//
//  Created by Thomas Cool on 4/30/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "Backrow/AppleTV.h"


@protocol SMFPrefsMenuItemProtocol

-(NSString *)itemText;
-(NSString *)titleText;
-(BRMenuItem *)menuItem;
-(void)selected;
@optional
-(float)menuItemHeight;
@end
