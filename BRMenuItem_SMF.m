//
//  BRMenuItem.m
//  SMFramework
//
//  Created by Thomas Cool on 10/24/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "BRMenuItem_SMF.h"


@implementation BRMenuItem (SMFExtensions) 
+(BRMenuItem *)smfFolderMenuItem
{
    BRMenuItem *i = [[BRMenuItem alloc] init];
    [i addAccessoryOfType:1];
    return [i autorelease];
}
+(BRMenuItem *)smfMenuItem
{
    BRMenuItem *i = [[BRMenuItem alloc] init];
    [i addAccessoryOfType:0];
    return [i autorelease];
}
-(void)setTitle:(NSString *)title
{
    [self setText:title withAttributes:[[BRThemeInfo sharedTheme]menuItemTextAttributes]];
}
@end
