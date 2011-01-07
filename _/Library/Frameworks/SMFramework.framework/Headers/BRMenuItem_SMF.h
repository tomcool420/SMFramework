//
//  BRMenuItem.h
//  SMFramework
//
//  Created by Thomas Cool on 10/24/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

//NOTE: should note be used ... use SMFMenuItem instead
#import <Backrow/Backrow.h>

@interface BRMenuItem (SMFExtensions) 
+(BRMenuItem *)smfFolderMenuItem;
+(BRMenuItem *)smfMenuItem;
-(void)setTitle:(NSString *)title;
@end
