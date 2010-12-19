//
//  SMFPasscodeController.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 4/19/09.
//  Copyright 2009,2010 Thomas Cool. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <Backrow/Backrow.h>
@class BRHeaderControl, BRTextControl,BRScrollingTextControl, BRImageControl, BRPasscodeEntryControl, BRDisplayManager;
@protocol SMFPasscodeControllerDelegate
- (void) textDidEndEditing: (id) sender;
@optional
- (void) textDidChange: (id) sender;
@end


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
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withDelegate:(id)del;
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withKey:(NSString *)k withDomain:(NSString *)dom;






@property (assign) id delegate;
@property (retain) NSString * key;
@property (retain) NSString * domain;
@property (assign) int initialValue;
@property (retain) NSString *description;
@property (assign) int boxes;
@property (retain) BRImage * icon;
@property (retain) NSString *title;
@end

