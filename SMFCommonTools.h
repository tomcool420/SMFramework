//
//  SMFCommonTools.h
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//



@interface SMFCommonTools : NSObject {

}
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

-(SMFCommonTools *)sharedInstance;
-(NSArray *)returnForProcess:(NSString *)call;
-(int)syscallSeatbeltEnabled;
@end
