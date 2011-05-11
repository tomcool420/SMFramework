//
//  SMFControllerPasscodeController.m
//  SMFramework
//
//  Created by Thomas Cool on 2/20/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFControllerPasscodeController.h"
//#import "BRThemeInfo.h"

@implementation SMFControllerPasscodeController
@synthesize blockedController;
+(SMFControllerPasscodeController *)controllerPasscodeControllerForController:(BRController *)controller withPasscode:(int)passcode
{
    [BRThemeInfo sharedTheme];
    SMFControllerPasscodeController * c = [[[SMFControllerPasscodeController alloc]initForController:controller withPasscode:passcode] autorelease];
    return c;
}
- (id)initForController:(BRController *)controller withPasscode:(int)passcode
{
    if (![controller isKindOfClass:[BRController class]])
        return nil;
	self = [super init];    
    self.delegate = nil;
    self.icon=nil;
    self.title=@"Error, Controller Blocked";
    self.description=[NSString stringWithFormat:@"%@ has been blocked, please enter the passcode",[controller description],nil];
    self.boxes=4;
    self.initialValue=0;
    _passcode=passcode;
    self.blockedController=controller;
	return self;
    
}
- (void) textDidEndEditing: (id) sender
{
    int returnValue=[[sender stringValue] intValue];
    if (returnValue==_passcode) {
        [[self stack] swapController:self.blockedController];
    }
    else {
        NSLog(@"wrong passcode");
        [[self stack]popController];
    }

    
}
-(void)dealloc
{
    self.blockedController=nil;
    [super dealloc];
}
@end
