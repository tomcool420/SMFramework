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
+(void)showPopup:(id)popup
{
    if (popup==nil) {
        return;
    }
    id manager  = [BRPopUpManager sharedInstance];
    if (manager==nil) {
        [BRPopUpManager setSingleton:[[BRPopUpManager alloc]init]];
    }
    [[BRPopUpManager sharedInstance] postPopUpWithControl:popup 
                                               identifier:@"SMFPopup" 
                                                 position:6 
                                                     size:CGSizeMake(0.9, 0.15)
                                                  options:[NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:1],@"BRPopUpPostImmediately",
                                                           [NSNumber numberWithInt:8],@"BRPopUpTimeoutValueKey",nil]];
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
    return system("SMFHelper security.mac.vnode_enforce 0");
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
