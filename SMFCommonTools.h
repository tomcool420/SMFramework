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
@interface SMFCommonTools : NSObject {

}
+(SMFCommonTools *)sharedInstance;

/*
 *  Returns a SMFPopupInfo to show using showPopup
 *  @arg1: an NSArray with 1-3 NSStrings inside (can be nil)
 *  @arg2: a BRImage (cannot be nil)
 */
+(id)popupControlWithLines:(NSArray *)array andImage:(BRImage *)image;

/*
 *  Displays a popup using the BRPopupManager
 *  @arg1: a popup created using popupControlwithLines:andImage:
 */
+(void)showPopup:(id)popup;

/*
 *  Displays a popup using the BRPopupManager
 *  adds more customizability to the +(void)showPopup: method
 *  @arg1: a popup created using popupControlwithLines:andImage:
 *  @arg2: timeout in seconds
 *  @arg3: a position integer (needs more detail)
 *  @arg4: CGSize (relative size)
 */
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withSize:(CGSize)size;
/*
 *  Displays a popup using the BRPopupManager
 *  adds more customizability to the +(void)showPopup: method
 *  @arg1: a popup created using popupControlwithLines:andImage:
 *  @arg2: timeout in seconds
 *  @arg3: a position integer (needs more detail)
 *  @arg4: width
 *  @arg5: height
 */
+(void)showPopup:(id)popup withTimeout:(int)timeout withPosition:(PopupPosition)position withWidth:(float)width withHeight:(float)height;

/*
 *  Runs a task with popen parsing the output
 *  @arg1:   the call to be passed. eg: @"/usr/bin/screencapture -s 10"
 *  @return: returns the output text from the call seperated into lines into an array
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
