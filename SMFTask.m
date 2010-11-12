//
//  SMFTask.m
//  SMFramework
//
//  Created by Thomas Cool on 11/11/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFTask.h"


@implementation SMFTask
-(void)waitUntilExit
{
    int pid=[self processIdentifier];
    waitpid(pid);
}
@end
