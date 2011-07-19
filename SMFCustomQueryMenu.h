//
//  SMFCustomQueryMenu.h
//  SMFramework
//
//  Created by Thomas Cool on 5/10/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Backrow/AppleTV.h"
#import "SMFMediaMenuController.h"
typedef enum _kSMFSearchStatus
{
    kSMFSearchStarted=0,
    kSMFSearchDone,
}kSMFSearchStatus;
@class SMFCustomQueryMenu;
@protocol  SMFCustomQueryMenuDelegate
-(void)queryMenu:(SMFCustomQueryMenu *)q itemSelected:(NSObject *)it;
@end

@interface SMFCustomQueryMenu : BRMediaMenuController {
    BRTextEntryControl  * _entryControl;
    NSString *              _lastSearchedQuery;
    NSObject<SMFCustomQueryMenuDelegate> * _delegate;
    BRWaitSpinnerControl *_spi;
}
@property (copy)NSString *lastSearchedQuery;
@property (assign)NSObject<SMFCustomQueryMenuDelegate> * delegate;
@property (readonly)BRWaitSpinnerControl * spinner;
-(void)search:(NSString *)searchString;
@end
