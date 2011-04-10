//
//  SMFCommonTools.h
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>

typedef enum _popupPosition{
    kSMFPopupCenterLeft     =0,
    kSMFPopupTopLeft        =1,
    kSMFPopupBottomLeft     =2,
    kSMFPopupCenterFarLeft  =4,
    kSMFPopupTopFarLeft     =5,
    kSMFPopupBottomFarLeft  =6
} PopupPosition;
/**
 *A Compilation of methods to use for popups and other stuff
 */
@interface SMFCommonTools : NSObject {

}
///---
///@name getting the shared object
///---
/**
 *@return the shared objectec
 */
+(SMFCommonTools *)sharedInstance;
///---
///@name Popups
///---

/**
 *@return an SMFPopupInfo object to show using showPopup
 *@param array an NSArray with 1-3 NSStrings inside (can be nil)
 *@param image a BRImage (cannot be nil)
 *@note Important: image must not be nil
 *@see showPopup:
 */
+(id)popupControlWithLines:(NSArray *)array andImage:(BRImage *)image;

/**
 *@returns a SMFPopupInfo to show using showPopup
 *@param dict a NSDictionary with keys `@"Image"` (BRImage) and `@"Lines"` (NSArray of NSStrings)
 *@see showPopup:
 */
+(id)popupControlWithDictionary:(NSDictionary *)dict;


/**
 *Displays a popup using the BRPopupManager
 *@param popup a popup created using popupControlwithLines:andImage: or popupControlWithDictionary:
 *Calls `[SMFCommonTools showPopup:popup withTimeout:8 withPosition:6 withSize:CGSizeMake(0.9,0.15)];`
 *@see showPopup:withTimeout:withPosition:withSize:
 *  
 */
+(void)showPopup:(id)popup;

/**
 *Displays a popup using the BRPopupManager
 *adds more customizability to the +(void)showPopup: method
 *
 *@param popup a popup created using popupControlwithLines:andImage:
 *@param timeout display duration in seconds (integer)
 *@param position a position integer
 *@param size CGSize confusing
 *
 */
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withSize:(CGSize)size;
/**
 *  Displays a popup using the BRPopupManager
 *  adds more customizability to the +(void)showPopup: method
 *@param popup a popup created using popupControlwithLines:andImage:
 *@param timeout display duration in seconds
 *@param position a position integer (see showPopup:withTimeout:withPosition:withSize:)
 *@param width a relative width
 *@param height a relative height
 *@see showPopup:withTimeout:withPosition:withSize:
 */
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withWidth:(float)width withHeight:(float)height;


///---
///@name Processes
///---
/**
 *  Runs a task with popen parsing the output
 *@param call   the call to be passed. eg: @"/usr/bin/screencapture -s 10"
 *  @return the output text from the call seperated into lines into an array
 */
-(NSArray *)returnForProcess:(NSString *)call;

/*
 *  checks if seatbelt is enabled
 *  @return: 0  if it's disabled
 *           1  if it's enabled
 *          -1  if the status cannot be determined
 */
-(int)syscallSeatbeltEnabled;

/*
 *  disables seatbelt
 *  @return: return from the system call
 */
-(int)disableSeatbelt;

/*
 *  enables seatbelt
 *  @return: return from the system call
 */
-(int)enableSeatbelt;

/*
 *  method put in place to test stuff
 */
-(void)test;

/*
 *  A simple way to restart lowtide for people to lazy to remember the proper BRCall (me)
 */
-(void)restartLowtide;
@end
