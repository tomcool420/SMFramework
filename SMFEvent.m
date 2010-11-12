//
//  SMFEvent.m
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFEvent.h"


@implementation SMFEvent
+(SMFEvent *)eventWithName:(NSString *)n andKey:(NSString *)k
{
    SMFEvent *e = [[SMFEvent alloc] init];
    [e setKey:k];
    [e setName:n];
    return [e autorelease];
}
@synthesize key;
@synthesize name;
@end
