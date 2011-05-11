//
//  SMFControllerPasscodeController.h
//  SMFramework
//
//  Created by Thomas Cool on 2/20/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFPasscodeController.h"
/**
 *Special subclass of SMFPasscodeController made to block a controller
 *
 *It is made for ease of use. It only has one class or instance method and that is the initialization
 *
 *If the user returns the wrong passcode, nothing happens, the controller is simply popped
 */
@interface SMFControllerPasscodeController : SMFPasscodeController {
    BRController *blockedController;
    int _passcode;
    
}
/**
 *Creating the passcode controller 
 *@param controller the controller to block (should not be pushed to stack but should have been autoreleased)
 *@param passcode the passcode to unlock the controller
 *@return the controller to be pushed to the BRApplicationStack
 *@see initForController:withPasscode:
 */
+ (SMFControllerPasscodeController *)controllerPasscodeControllerForController:(BRController *)controller withPasscode:(int)passcode;
/**
 *Creating the passcode controller 
 *@param controller the controller to block (should not be pushed to stack but should have been autoreleased)
 *@param passcode the passcode to unlock the controller
 *@return the controller to be pushed to the BRApplicationStack
 *@see controllerPasscodeControllerForController:withPasscode:
 */
- (id)initForController:(BRController *)controller withPasscode:(int)passcode;
@property (retain)BRController *blockedController;
@end
