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
@synthesize returnCode;
@synthesize finished;
-(id)init
{
    self=[super init];
    returnCode=YES;
    finished=NO;
    return self;
}
-(void)controlWasActivated
{
    [super controlWasActivated];
    [self performSelectorInBackground:@selector(runProcess) withObject:nil];
}
-(int)runProcess
{
    char line[200];
    
    FILE* fp = popen([ap UTF8String], "r");
//    NSMutableArray *lines = [[NSMutableArray alloc]init];
    if (fp)
    {
        while (fgets(line, sizeof line, fp))
        {
            NSString *s = [NSString stringWithCString:line encoding:NSUTF8StringEncoding];
//            NSLog(@"s: %@",s);
            [self performSelectorOnMainThread:@selector(appendToText:) withObject:[s stringByAppendingString:@"\n"] waitUntilDone:YES];
        }
    }
    returnCode = pclose(fp);
    finished =YES;
    return returnCode;
}
@end
