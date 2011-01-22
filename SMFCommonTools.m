//
//  SMFCommonTools.m
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFCommonTools.h"
#import "SMFPhotoMethods.h"
#import "SynthesizeSingleton.h"
#import <CoreGraphics/CoreGraphics.h>
static void daemonRunCode(int type, NSString *codeString){
	
	CFMessagePortRef daemonPort = 0;
	NSMutableDictionary *d = [[NSMutableDictionary alloc]init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [d setObject:codeString forKey:@"command"];
    CFDataRef data= CFPropertyListCreateData (
                                              NULL,
                                              (CFDictionaryRef)d,
                                              kCFPropertyListXMLFormat_v1_0,
                                              0,
                                              NULL);
    NSLog(@"sending info");
	if (!daemonPort || !CFMessagePortIsValid(daemonPort)) {
        NSLog(@"searching for port");
		daemonPort = CFMessagePortCreateRemote(NULL, CFSTR("org.tomcool.lowtide.daemon"));
	}
	if (!daemonPort) return;
	NSLog(@"found port");
	// create and send message
	CFMessagePortSendRequest(daemonPort, type, data, 1, 1, NULL, NULL);
    if (data) {
        CFRelease(data);
    }
}

@implementation SMFCommonTools
SYNTHESIZE_SINGLETON_FOR_CLASS(SMFCommonTools,sharedInstance)
-(void)test
{
//    NSLog(@"facade singleton: %@",[ATVSettingsFacade singleton]);
//    [[ATVSettingsFacade singleton] setScreenSaverPhotoCollection:[SMFPhotoMethods photoCollectionForPath:@"/var/root/pf"]];
}
+(id)popupControlWithLines:(NSArray *)array andImage:(BRImage *)image
{
    id ctrl =[[NSClassFromString(@"SMFPopupInfo") alloc] init];
    if (image==nil) 
        return nil;
    NSDictionary *dict;
    if (array==nil) {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                              image,@"Image",
                              nil];
    }
    else {
        dict = [NSDictionary dictionaryWithObjectsAndKeys:
                image,@"Image",
                array,@"Lines",nil];
        
    }
    [ctrl setObject:dict];
    return [ctrl autorelease];
}
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withWidth:(float)width withHeight:(float)height
{
    if (width<=0.0f)
        width=0.9;
    if (height<=0.0f)
        height=0.15;
    [SMFCommonTools showPopup:popup withTimeout:timeout withPosition:position withSize:CGSizeMake(width, height)];

}
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withSize:(CGSize)size
{
    if (popup==nil)
        return;
//    if (size==nil) 
//        size=CGSizeMake(0.9,0.15);
    if (position <0)
        position=6;
    if (timeout<=0)
        timeout=8;
    id manager  = [BRPopUpManager sharedInstance];
    if (manager==nil) {
        [BRPopUpManager setSingleton:[[BRPopUpManager alloc]init]];
    }
    [[BRPopUpManager sharedInstance] postPopUpWithControl:popup 
                                               identifier:@"SMFPopup" 
                                                 position:(int)position 
                                                     size:size
                                                  options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"BRPopUpPostImmediately",
                                                           [NSNumber numberWithInt:timeout],@"BRPopUpTimeoutValueKey",nil]];
    
}
+(void)showPopup:(id)popup
{
    [SMFCommonTools showPopup:popup withTimeout:8 withPosition:6 withSize:CGSizeMake(0.9,0.15)];
}

-(NSArray *)returnForProcess:(NSString *)call
{
    if (call==nil) 
        return 0;
    char line[200];
    
    FILE* fp = popen([call UTF8String], "r");
    NSMutableArray *lines = [[NSMutableArray alloc]init];
    if (fp)
    {
        while (fgets(line, sizeof line, fp))
        {
            NSString *s = [NSString stringWithCString:line encoding:NSUTF8StringEncoding];
            [lines addObject:s];
        }
    }
    pclose(fp);
    return [lines autorelease];
}
-(int)syscallSeatbeltEnabled
{
    NSArray *lines = [self returnForProcess:@"sysctl security.mac.vnode_enforce"];
    if ([lines count]>0) {
        for (NSString *line in lines) {
            NSArray *parts = [line componentsSeparatedByString:@": "];
            if ([parts count]>1) {
                if ([(NSString *)[parts objectAtIndex:0] isEqualToString:@"security.mac.vnode_enforce"]) {
                    int r = [(NSString *)[parts objectAtIndex:1] intValue];
                    return r;
                }
            }
        }
    }
    return -1;
}

-(int)disableSeatbelt
{
     daemonRunCode(0, @"SMFHelper security.mac.vnode_enforce 0");
    return 0;
    //return system("SMFHelper security.mac.vnode_enforce 0");
}
-(int)enableSeatbelt
{
    return system("SMFHelper security.mac.vnode_enforce 1");
}

-(void)restartLowtide
{
    [[BRApplication sharedApplication]terminate];
}
@end
