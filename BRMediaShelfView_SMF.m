//
//  BRMediaShelfView_SMF.m
//  SMFramework
//
//  Created by Thomas Cool on 7/11/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "BRMediaShelfView_SMF.h"

@implementation BRMediaShelfView (SMF)
-(long)focusedIndex
{
    return (long)[[self focusedIndexPath] indexAtPosition:1];
}
-(void)setFocusedIndex:(long)index
{
    NSIndexPath *pp = [NSIndexPath indexPathWithIndex:0];
    pp=[pp indexPathByAddingIndex:index];
    
    [self setFocusedIndexPath:pp];
}
@end
