//
//  QuDownloadController.h
//  QuDownloader
//
//  Created by Alan Quatermain on 19/04/07.
//  Copyright 2007 AwkwwardTV. All rights reserved.
//
// Updated by nito 08-20-08 - works in 2.x

#import <Foundation/Foundation.h>
//#import <BackRow/BRController.h>
#import <CoreData/CoreData.h>
#define DESCRIPTION_KEY			@"description"
#define TITLE_KEY				@"title"
#define NUMBER_BOXES_KEY		@"numberOfBoxes"
#define KEY_KEY					@"key"
#define DOMAIN_KEY              @"domain"
#define DEFAULT_KEY				@"defaults"
@class BRHeaderControl, BRTextControl,BRScrollingTextControl, BRImageControl, BRPasscodeEntryControl, BRDisplayManager;

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
- (id)initWithTitle:(NSString *)title withDescription:(NSString *)description withBoxes:(int)boxes withKey:(NSString *)key withDomain:(NSString *)domain;
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withDelegate:(id)del;
+ (SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withKey:(NSString *)k withDomain:(NSString *)dom;




#pragma mark Setter Methods
- (void)setTitle:(NSString *)arg1;
- (NSString *)title;

- (void)setDescription:(NSString *)arg1;
- (NSString *)description;

- (void)setBoxes:(int)arg1;
- (int)boxes;

- (void)setDelegate:(id)arg1;
- (id)delegate;

- (void)setKey:(NSString *)arg1;
- (NSString *)key;

- (void)setDomain:(NSString *)arg1;
- (NSString *)domain;

- (void)setInitialValue:(int)value;
- (int)initialValue;

- (void)setIcon:(BRImage *)icon;
- (BRImage *)icon;

#pragma mark entryControl Delegate Methods
- (void) textDidChange: (id) sender;
- (void) textDidEndEditing: (id) sender;


@end

