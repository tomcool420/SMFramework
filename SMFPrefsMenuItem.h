//
//  SMFPrefsMenuItem.h
//  SMFramework
//
//  Created by Thomas Cool on 4/29/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFramework.h"
#import "SMFColorSelectionMenu.h"
#import "SMFPrefsMenuItemProtocol.h"
typedef enum _SMFPrefType{
    kSMFPrefTypeString=0,
    kSMFPrefTypeDate,
    kSMFPrefTypeInteger,
    kSMFPrefTypeDouble,
    kSMFPrefTypeLong,
    kSMFPrefTypePath,
    kSMFPrefTypeBool,
    kSMFPrefTypeArray,
    kSMFPrefTypeCustom,
    kSMFPrefTypeColor,
    kSMFPrefTypeNumber,
    kSMFPrefTypeController,
}SMFPrefType;



@interface SMFPrefsMenuItem : NSObject<SMFPrefsMenuItemProtocol,SMFColorSelectionDelegate> {
    NSUserDefaults *_prefs;
    SMFPrefType     _type;
    NSString *      _key;
    NSString *      _title;
    NSString *      _description;
    id              _delegate;
    BRController *  _ctrl;
    NSString *      _notificationName;
}
@property (assign) SMFPrefType type;
@property (copy) NSString *key;
@property (assign) NSUserDefaults *preferences;
@property (copy) NSString *title;
@property (copy) NSString *longDescription;
@property (retain) BRController *ctrl;
@property (assign) id delegate;
@property (retain) NSString *notificationName;
+(SMFPrefsMenuItem *)itemWithType:(SMFPrefType)t forKey:(NSString *)k inPrefs:(NSUserDefaults *)p;
+(SMFPrefsMenuItem *)itemWithType:(SMFPrefType)t forKey:(NSString *)k inPrefs:(NSUserDefaults *)p withTitle:(NSString *)s withDescription:(NSString *)d;



-(void)colorSelected:(NSArray *)rgba forKey:(NSString *)k;
@end
