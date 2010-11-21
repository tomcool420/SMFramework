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
%hook BRMainMenuSelectionHandler
-(BOOL)handleSelectionForControl:(id)ctrl
{
    %log;
    BOOL r = %orig;
    NSLog(@"control: %@, handle: %d",ctrl,r);
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

%end
%hook LTAppDelegate
-(void)applicationDidFinishLaunching:(id)fp8 {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [SMFEventManager sharedManager];
    [pool release]; 
    %orig;
    // %orig does not return
}
%end