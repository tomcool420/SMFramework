//
//  SMFPrefsSelectionItem.m
//  SMFramework
//
//  Created by Thomas Cool on 5/9/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFPrefsSelectionItem.h"


@implementation SMFPrefsSelectionItem
@synthesize object;
@synthesize title;
-(NSString *)rightText
{
    if (self.object!=nil)
        return NSStringFromClass([self.object class]);
    return @"";
}
-(NSString *)titleText
{
    if (self.title!=nil)
        return self.title;
    else
        return [NSString stringWithFormat:@"%@",self.object,nil];
}
@end
