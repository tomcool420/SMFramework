/* How to Hook with Logos
Hooks are written with syntax similar to that of an Objective-C @implementation.
You don't need to #include <substrate.h>, it will be done automatically, as will
the generation of a class list and an automatic constructor.

%hook ClassName

// Hooking a class method
+ (id)sharedInstance {
	return %orig;
}

// Hooking an instance method with an argument.
- (void)messageName:(int)argument {
	%log; // Write a message about this call, including its class, name and arguments, to the system log.

	%orig; // Call through to the original function with its original arguments.
	%orig(nil); // Call through to the original function with a custom argument.

	// If you use %orig(), you MUST supply all arguments (except for self and _cmd, the automatically generated ones.)
}

// Hooking an instance method with no arguments.
- (id)noArguments {
	%log;
	id awesome = %orig;
	[awesome doSomethingElse];

	return awesome;
}

// Always make sure you clean up after yourself; Not doing so could have grave conseqeuences!
%end
*/
#import <objc/runtime.h>



#import "/opt/theos/include/BackRow/BackRow.h"
#import "../SMFramework.h"
#import "../SMFCommonTools.h"
%hook BRAccount
- (id)initWithAccountName:(id)accountName
{
    NSLog(@"Seatbelt status: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
-(id)initWithCoder:(id)coder
{
     NSLog(@"Seatbelt status coder: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
-(id)init
{
     NSLog(@"Seatbelt status init: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
%end
%hook BRMainMenuSelectionHandler
-(BOOL)handleSelectionForControl:(id)ctrl
{
    %log;
    BOOL r = %orig;
    return r;
}
%end

%hook BRWindow
+ (BOOL)dispatchEvent:(id)event { 
    if([[SMFEventManager sharedManager]actionDefinedForAction:[event remoteAction]])
    {
        return [[SMFEventManager sharedManager]callEventForRemoteAction:[event remoteAction]];
    }
    else
        return %orig;
}
%end
static CFDataRef popupCallback(CFMessagePortRef local, SInt32 msgid, CFDataRef cfData, void *info) {
	const char *data = (const char *) CFDataGetBytePtr(cfData);
	UInt16 dataLen = CFDataGetLength(cfData);
//	NSString * text=nil;
//	BREvent *event = nil;
//    int value = 1;
    if (dataLen > 0 && data)
    {
        NSDictionary *dd = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:(NSData *)cfData 
                                            mutabilityOption:0 
                                            format:NULL 
                                            errorDescription:nil];
        NSArray *lines = [dd objectForKey:@"info" ];
        BRImage *img=[[SMFThemeInfo sharedTheme] colorAppleTVNameImage];
        if(msgid==1)
            img=[[SMFThemeInfo sharedTheme] keyboardIcon];
        id popup=[SMFCommonTools popupControlWithLines:lines andImage:img];
        [SMFCommonTools showPopup:popup];
        }
        return NULL;  // as stated in header, both data and returnData will be released for us after callback returns
    }

//%hook BRMainMenuController
//-(void)_loadAppliances
//{
//%orig;
//    %log;
//    NSArray *info = MSHookIvar<NSArray *>(self, "_applianceInfos");
//    NSMutableArray *c = [[NSMutableArray alloc]init];
//    for(BRApplianceInfo *i in info)
//    {
//        if([i.key isEqualToString:@"com.apple.frontrow.appliance.settings"])
//        {
//        NSLog(@"changing settings");
//            
//            i.preferredOrder=1.000000;
//            i.primaryAppliance=NO;
//        }
//        else
//        {
//            [c addObject:i];
//        }
//    }
//    //[info release];
////    info=[c retain];
////    [self reloadMainMenu];
//    
//}
//%end

%hook BRMainMenuControl
-(void)_reload
{
    %orig;
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        BRImageControl *img = MSHookIvar<BRImageControl *>(self,"_logo");
        //[img removeFromParent];
        [img setImage:[[SMFThemeInfo sharedTheme]seatbeltLogoImage]];
        //[self addControl:img];
    }
    
    
}
%end
%hook LTAppDelegate
-(void)applicationDidFinishLaunching:(id)fp8 {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    CFMessagePortRef local = CFMessagePortCreateLocal(NULL, CFSTR("org.tomcool.lowtide.popup"), popupCallback, NULL, false);
	CFRunLoopSourceRef source = CFMessagePortCreateRunLoopSource(NULL, local, 0);
	CFRunLoopAddSource(CFRunLoopGetCurrent(), source, kCFRunLoopDefaultMode);
    [SMFEventManager sharedManager];
    [pool release]; 
    %orig;
    NSLog(@"root files: %@",[[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/var/mobile" error:nil]);
    // %orig does not return
}
%end