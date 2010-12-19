//
//  SMFHelper.m
//  SMFHelper
//
//  Created by Thomas Cool on 2/4/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//
#include <sys/types.h>
#include <unistd.h>
#import <Foundation/Foundation.h>
#import <Backrow/Backrow.h>
#import "../SynthesizeSingleton.h"
@interface SMFHelperClass : NSObject
//-(SMFHelperClass *)sharedInstance;
-(int)setSysValue:(NSString *)val forKey:(NSString *)key;
@end

@implementation SMFHelperClass
//SYNTHESIZE_SINGLETON_FOR_CLASS(SMFHelperClass,sharedInstance)
-(int)setSysValue:(NSString *)val forKey:(NSString *)key
{
    return system([[NSString stringWithFormat:@"sysctl -w %@=%@",key,val,nil] UTF8String]);
}

@end


int main (int argc, const char * argv[]) {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];	
	//NSRunLoop *rl = [NSRunLoop currentRunLoop];
	
	//[rl configureAsServer];
    setuid(0);
    setgid(0);
	if (argc < 3){
		printf("Segmentation Fault");
		printf("\n");
        return 2;
    }
		NSString *option = [NSString stringWithUTF8String:argv[1]]; //argument 1
		NSString *value = [NSString stringWithUTF8String:argv[2]]; //argument 2
    int rvalue=0;
    SMFHelperClass *c = [[SMFHelperClass alloc] init];
    rvalue=[c setSysValue:value forKey:option];
    [c release];
    [pool release];
    return rvalue;
}

