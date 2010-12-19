//
//  SMFMenuItem.m
//  SMFramework
//
//  Created by Thomas Cool on 10/26/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFMenuItem.h"


@implementation SMFMenuItem
+(SMFMenuItem *)folderMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:1];
    return [i autorelease];
}
+(SMFMenuItem *)menuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:0];
    return [i autorelease];
}
+(SMFMenuItem *)shuffleMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:3];
    return [i autorelease];
}
+(SMFMenuItem *)refreshMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:4];
    return [i autorelease];
}
+(SMFMenuItem *)syncMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:5];
    return [i autorelease];
}
+(SMFMenuItem *)lockMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:6];
    return [i autorelease];
}
+(SMFMenuItem *)progressMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:7];
    return [i autorelease];
}
+(SMFMenuItem *)downloadMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:8];
    return [i autorelease];
}
+(SMFMenuItem *)computerMenuItem
{
    SMFMenuItem *i = [[SMFMenuItem alloc] init];
    [i addAccessoryOfType:9];
    return [i autorelease];
}
-(void)setTitle:(NSString *)title
{
    [self setText:title withAttributes:[[BRThemeInfo sharedTheme]menuItemTextAttributes]];
}
-(void)setRightText:(NSString *)txt
{
    [self setRightJustifiedText:txt withAttributes:[[BRThemeInfo sharedTheme] menuItemSmallTextAttributes]];
}
-(void)setSelectedImage:(BOOL)b
{
    if (b) {
        self.image=[[BRThemeInfo sharedTheme]selectedSettingImage];
        self.imageInset=-0.0f;
        self.textPadding=-0.0f;
        self.imageHeight=30.0f;
    }
    else {
        self.image=nil;
    }

}
@end
