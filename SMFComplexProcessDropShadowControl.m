//
//  SMFComplexProcessDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFComplexProcessDropShadowControl.h"


@implementation SMFComplexProcessDropShadowControl
@synthesize ap;
-(void)controlWasActivated
{

    [super controlWasActivated];
    [self performSelectorInBackground:@selector(runProcess) withObject:nil];
}
-(void)runProcess
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    char line[200];
    
    FILE* fp = popen([ap UTF8String], "r");
    NSMutableArray *lines = [[NSMutableArray alloc]init];
    if (fp)
    {
        while (fgets(line, sizeof line, fp))
        {
            NSString *s = [NSString stringWithCString:line encoding:NSUTF8StringEncoding];
//            NSLog(@"s: %@",s);
            [self performSelectorOnMainThread:@selector(appendToText:) withObject:[s stringByAppendingString:@"\n"] waitUntilDone:YES];
        }
    }
    pclose(fp);
	[pool release];
}
@end
