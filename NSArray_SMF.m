//
//  NSArray_SMF.m
//  SMFramework
//
//  Created by Thomas Cool on 12/27/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "NSArray_SMF.h"


@implementation NSArray (SMFramework)
- (NSArray *) SMFShuffled
{
	// create temporary autoreleased mutable array
	NSMutableArray *tmpArray = [NSMutableArray arrayWithCapacity:[self count]];
    
	for (id anObject in self)
	{
		NSUInteger randomPos = arc4random()%([tmpArray count]+1);
		[tmpArray insertObject:anObject atIndex:randomPos];
	}
    
	return [NSArray arrayWithArray:tmpArray];  // non-mutable autoreleased copy
}
@end
