//
//  SMFEventConfiguration.h
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SMFMediaMenuController.h"
#import "SMFEventManager.h"
@interface SMFEventConfiguration : SMFMediaMenuController {
    NSArray *_listeners;
}

@end

@interface SMFListenerConfiguration: SMFMediaMenuController
{
    NSArray *_events;
    id<SMFEventDelegate>listener;
}
-(id)initForListener:(id<SMFEventDelegate>)l;
@end
@interface SMFKeySelectMenu:BRAlertController
{
    NSString *_event;
    NSString *_eventName;
    NSString *_eventDescription;
    NSString *_currentKey;
    int currentAction;
}
-(void)setEvent:(NSString *)event;
@end