//
//  SMFEventConfiguration.m
//  SMFramework
//
//  Created by Thomas Cool on 11/4/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFEventConfiguration.h"

#import "SMFMenuItem.h"

@implementation SMFEventConfiguration
-(id)init
{
    self=[super init]; 
    _listeners=[[[SMFEventManager sharedManager] listeners] retain];
    [self setListTitle:@"Event Manager"];
    for(id<SMFEventDelegate> l in _listeners)
    {
        SMFMenuItem *it = [SMFMenuItem folderMenuItem];
        [it setTitle:[l displayName]];
        [_items addObject:it];
        [_options addObject:l];
    }
    return self;
}
-(void)itemSelected:(long)row
{
    SMFListenerConfiguration *l = [[SMFListenerConfiguration alloc] initForListener:[_options objectAtIndex:row]];
    [[self stack] pushController:l];
    [l release];
}
@end

@implementation SMFListenerConfiguration

-(id)initForListener:(id<SMFEventDelegate>)l
{
    self=[super init];
    [self setListTitle:[l displayName]];
    listener=l;
    _events=[[SMFEventManager sharedManager] eventsForListener:listener];
    for(NSString *e in _events)
    {
        SMFMenuItem *it = [SMFMenuItem folderMenuItem];
        [it setTitle:e];
        [_items addObject:it];
        [_options addObject:e];
    }
         return self;
    
}
-(void)itemSelected:(long)selected
{
    SMFKeySelectMenu *k = [[SMFKeySelectMenu alloc] init];
    [k setPrimaryText:[_options objectAtIndex:selected]];
    [k setEvent:[_options objectAtIndex:selected]];
    [k setSecondaryText:@"Please press a key"];
    [[self stack] pushController:k];
}
@end
@implementation SMFKeySelectMenu
-(void)setEvent:(NSString *)event
{
    _event=[event retain];
}
-(id)init
{
    self=[super init];
    currentAction=0;
    return self;
}
-(void)wasPushed
{
    NSLog(@"was  Pushed");
    [[SMFEventManager sharedManager]startLearning];
}
-(void)wasPopped
{
    NSLog(@"was Popped");
    [[SMFEventManager sharedManager]stopLearning];
}
-(BOOL)brEventAction:(BREvent *)action
{
    int c=[action remoteAction];

    NSString *str=nil;
    if (action.value==0x01) {
        if (c==47) 
        {
            str=[[action eventDictionary] objectForKey:@"kBRKeyEventCharactersKey"];
            if (str!=nil) 
            {
                if (_currentKey!=nil && [_currentKey isEqualToString:str] && currentAction==47) {
                    //register key here
                    if (_event!=nil) {
                        NSLog(@"event: %@",_event);
                        [[SMFEventManager sharedManager]setKey:str forName:_event];

                    }
                    NSLog(@"final key = %@",str);
                    [[self stack]popController];
                }
                else {
                    [_currentKey release];
                    _currentKey=nil;
                    currentAction=47;
                    _currentKey=[str retain];
                    [self setSecondaryText:@"Please press same key again"];
                }
                
            }
            else
            {
                [_currentKey release];
                _currentKey=nil;
                currentAction=0;
            }
        }
        else {
            if (currentAction==c) {
                if (_event!=nil) {
                    NSLog(@"event: %@",_event);
                    [[SMFEventManager sharedManager] setRemoteAction:c forName:_event];
                }
                NSLog(@"final remoteAction: %d",c);
                [[self stack] popController];
            }
            else 
            {
                currentAction=c;
                [self setSecondaryText:@"Please press same key again"];
            }
            
        }
        
    }
    

    NSLog(@"Action Pressed: %d",[action remoteAction]);
    return NO;
}
@end