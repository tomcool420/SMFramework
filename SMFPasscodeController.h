//
//  SMFPasscodeController.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 4/19/09.
//  Copyright 2009,2010 Thomas Cool. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <BackRow/BackRow.h>
@class BRHeaderControl, BRTextControl,BRScrollingTextControl, BRImageControl, BRPasscodeEntryControl, BRDisplayManager;
@protocol SMFPasscodeControllerDelegate
- (void) textDidEndEditing: (id) sender;
@optional
- (void) textDidChange: (id) sender;
@end

/**
 *A simple way to have passcode boxes shown on screen. It comes with multiple ways to save/ check the data but setting a delegate is the recommened way
 */
@interface SMFPasscodeController : BRController
{
	int							padding[16];
	BRImage  *                  icon;
    id                          delegate;
    NSString *                  title;
    NSString *                  description;
    NSString *                  key;
    NSString *                  domain;
    int                         boxes;
    int                         initialValue;
}
- (id)initWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withKey:(NSString *)k withDomain:(NSString *)dom;
/**
 *Recommended way to create a SMFPasscodeController
 *@param t    the title shown at the top of the screen
 *@param desc short description explaining why this is passcode is required (may be nil)
 *@param b    the number of boxes to show (typically 4-6)
 *@param del  the delegate to which the selected passcode will be returned
 *@return autoreleased instance of SMFPasscodeController with set parameters
 *
 */
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withDelegate:(id)del;
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withKey:(NSString *)k withDomain:(NSString *)dom;





/**
 *  Delegate conforming to protocol: SMFPasscodeControllerDelegate
 */
@property (assign) id delegate;
/**
 *  The key to which you see the passcode in the Domain selected in domain
 *@note requires both domain and key to be set and delegate to be nil
 *@see domain
 */
@property (retain) NSString * key;
/**
 *The domain in which you set the passcode
 *@note requires both domain and key
 *@see key
 */
@property (retain) NSString * domain;
/**
 *The initial value selected
 */
@property (assign) int initialValue;
/**
 * short description explaining why this is passcode is required (may be nil)
 */
@property (retain) NSString *description;
/**
 * the number of boxes to show (typically 4-6)
 */
@property (assign) int boxes;
/**
 * Icon to show next to the title
 */
@property (retain) BRImage * icon;
/**
 * Title of the controller
 */
@property (retain) NSString *title;
@end

