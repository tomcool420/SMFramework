//
//  SMFMenuItem.h
//  SMFramework
//
//  Created by Thomas Cool on 10/26/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import <Backrow/Backrow.h>

@interface SMFMenuItem : BRMenuItem {

}
+(SMFMenuItem *)folderMenuItem;
+(SMFMenuItem *)menuItem;
+(SMFMenuItem *)shuffleMenuItem;
+(SMFMenuItem *)refreshMenuItem;
+(SMFMenuItem *)syncMenuItem;
+(SMFMenuItem *)lockMenuItem;
+(SMFMenuItem *)progressMenuItem;
+(SMFMenuItem *)downloadMenuItem;
+(SMFMenuItem *)computerMenuItem;
-(void)setTitle:(NSString *)title;
-(void)setRightText:(NSString *)txt;
-(void)setSelectedImage:(BOOL)b;
@end
