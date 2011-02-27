//
//  SMFControllerPasscodeController.h
//  SMFramework
//
//  Created by Thomas Cool on 2/20/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFPasscodeController.h"

@interface SMFControllerPasscodeController : SMFPasscodeController {
    BRController *blockedController;
    int _passcode;
    
}
+ (SMFControllerPasscodeController *)controllerPasscodeControllerForController:(BRController *)controller withPasscode:(int)passcode;
- (id)initForController:(BRController *)controller withPasscode:(int)passcode;
@property (retain)BRController *blockedController;
@end
