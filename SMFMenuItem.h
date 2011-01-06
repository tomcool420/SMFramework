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
/*
 *  The Following methods create menu items
 *  with different images on the right
 *  return is already autoreleased.
 */
+(SMFMenuItem *)folderMenuItem;
+(SMFMenuItem *)menuItem;
+(SMFMenuItem *)shuffleMenuItem;
+(SMFMenuItem *)refreshMenuItem;
+(SMFMenuItem *)syncMenuItem;
+(SMFMenuItem *)lockMenuItem;
+(SMFMenuItem *)progressMenuItem;
+(SMFMenuItem *)downloadMenuItem;
+(SMFMenuItem *)computerMenuItem;
/*
 *  Convenience method so a NSString can be used instead of an
 *  NSAttributedString
 */
-(void)setTitle:(NSString *)title;
/*
 *  Convenience method so a NSString can be used instead of an
 *  NSAttributedString
 */
-(void)setRightText:(NSString *)txt;
/*
 *  adds a selected checkmark with the proper size so it does not
 *  shift the text and looks like apple's
 */
-(void)setSelectedImage:(BOOL)b;
@end
