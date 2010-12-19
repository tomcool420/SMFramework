//
//  SMFQueryMenu.h
//  SMFramework
//
//  Created by Thomas Cool on 11/5/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SMFramework.h"
@class SMFQueryMenu;
@protocol SMFQueryDelegate

-(void)queryMenu:(SMFQueryMenu *)q itemSelected:(NSString *)it;

@end
@interface SMFQueryMenu : BRMenuController {
    BRTextEntryControl  * _entryControl;
    NSMutableArray      * _items;
    NSMutableArray      * _filteredArray;
    id<SMFQueryDelegate>  _delegate;
}
-(void)setDelegate:(id<SMFQueryDelegate>)d;
-(id<SMFQueryDelegate>)delegate;
@end



