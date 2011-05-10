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
#import <BackRow/BackRow.h>
#include <substrate.h>
@interface ATVSettingsFacade
@end
@interface ATVScreenSaverPrefetchTask
@end
@interface ATVScreenSaverArchiver
@end
//#import "/opt/theos/include/BackRow/BackRow.h"
#import "../SMFramework.h"
#import "../SMFCommonTools.h"
#import "../SMFControllerPasscodeController.h"
%hook BRApplianceManager
//- (void)_loadApplianceAtPath:(id)path	// 0x315924f1
//{
//    if([[path lastPathComponent] isEqualToString:@"nitoTV.frappliance"])
//        return;
//    %log;
//    %orig;
//}
//- (void)_loadAppliancesInFolder:(id)folder	// 0x315923b1
//{
//    %log;
//    %orig;
//}
//- (void)loadAppliances	// 0x31592359
//{
//    %log;
//    %orig;
//}
%end


%hook BRAccount
- (id)initWithAccountName:(id)accountName
{
    //NSLog(@"Seatbelt status: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
-(id)initWithCoder:(id)coder
{
     //NSLog(@"Seatbelt status coder: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
-(id)init
{
    // NSLog(@"Seatbelt status init: %d",[[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]);
    if([[SMFCommonTools sharedInstance] syscallSeatbeltEnabled]!=1)
    {
        NSLog(@"Seatbelt is disabled ... stopping account from starting");
        return nil;
    }
    return %orig;
}
%end

/*%hook BRPopUpManager
- (id)init{	// 0x3162de75
%log;
%orig;
}
- (void)_addControlToQueue:(id)queue{	// 0x3162d50d
%log;
%orig;
}
- (void)_animateRemovePopupWithIdentifier:(id)identifier{	// 0x3162d9d9
%log;
%orig;
}
- (BOOL)_canDisplay{	// 0x3162de35
%log;
%orig;
}
- (void)_displayPopUp:(id)up{	// 0x3162d611
%log;
%orig;
}
- (id)_popUpForIdentifier:(id)identifier{	// 0x3162d569
%log;
%orig;
}
- (void)_processPopUps{	// 0x3162d789
%log;
%orig;
}
- (void)_removeAnimationFinished:(id)finished{	// 0x3162d831
%log;
%orig;
}
- (void)_removeControlFromQueue:(id)queue{	// 0x3162d4bd
%log;
%orig;
}
- (void)_removePopup:(id)popup{	// 0x3162d8d1
%log;
%orig;
}
- (void)_removePopupWithIdentifier:(id)identifier{	// 0x3162d9a5
%log;
%orig;
}
- (void)_updateActivity{	// 0x3162ddf9
%log;
%orig;
}
- (void)dealloc{	// 0x3162dd65
%log;
%orig;
}
- (void)postPopUpWithControl:(id)control identifier:(id)identifier position:(unsigned)position size:(CGSize)size options:(id)options{	// 0x3162df01
%log;
%orig;
}
- (void)removePopUpWithIdentifier:(id)identifier{	// 0x3162db35
%log;
%orig;
}
%end*/

//%hook BRDropShadowControl
//- (void)setContent:(id)content
//{
//NSLog(@"content: %@",content);
//if([content respondsToSelector:@selector(content)])
//    NSLog(@"content content: %@",[content content]);
//NSLog(@"controls: %@",[content controls]);
//%orig;
//%log;
//
//}
//- (void)setFrame:(CGRect)frame
//{
//%log;
//return %orig;
//}
//- (id)init
//{
//%log;
//return %orig;
//
//
//}

//%end

//%hook BRControllerStack
//-(void)pushController:(BRController*)controller
//{
//    %log;
//    BRController *ctrl = [self peekController];
//    if([ctrl isKindOfClass:[BRMainMenuController class]])
//    {
//        
//        BRMainMenuControl *mm = MSHookIvar<BRMainMenuControl*>(ctrl,"_browser");
//        id<BRAppliance> active = MSHookIvar<id>(mm,"_currentAppliance");
//        %orig([SMFControllerPasscodeController controllerPasscodeControllerForController:controller withPasscode:0000]);
//    }
//    else
//        %orig;
//}
//%end
%hook BRTabControl
-(void)setFrame:(CGRect )frame
{
    %log;
    %orig;
}
%end
%hook BRTabControlItem

-(void)setLabel:(id)label
{
    %log;
    %orig;
}
-(void)setLabelAttributes:(id)labelAttributes
{
    %log;
    %orig;
}
-(void)setLabelIdentifier:(id)identifier
{
    %log;
    %orig;
}
%end
%hook BRControllerStack
-(void)pushController:(id)controller
{
    %log;
    %orig;
}
%end
%hook BRWindow
+ (BOOL)dispatchEvent:(id)event {
    //%log;
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
}
%end
