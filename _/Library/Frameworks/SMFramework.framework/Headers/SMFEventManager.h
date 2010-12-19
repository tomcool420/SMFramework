//
//  SMFEventManager.h
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SynthesizeSingleton.h"
#import "SMFEvent.h"
@protocol SMFEventDelegate
-(void)actionForEvent:(SMFEvent *)event;
-(NSString *)displayName;
@optional
-(BRImage *)icon;
-(NSString *)displayNameForEventKey:(NSString *)event;
@end


@interface SMFEventManager : NSObject {
    NSMutableDictionary * _delegates;
    NSMutableDictionary * _keys;
    NSMutableDictionary * _remoteActionKeys;
    NSMutableDictionary * _listeners;
    NSMutableSet        * _listenerSet;
    BOOL                  _learning;
}
+(SMFEventManager *)sharedManager;
-(void)registerListener:(id<SMFEventDelegate>)listener forName:(NSString *)name;
-(void)registerListener:(id<SMFEventDelegate>)listener forNames:(NSArray*)names;

-(void)setKey:(NSString *)key forName:(NSString *)name;
-(void)setRemoteAction:(int)action forName:(NSString *)name;
-(void)callEventForAction:(NSString *)key;
-(BOOL)callEventForRemoteAction:(int)action;
-(void)callEventForBREvent:(BREvent *)event;
-(BOOL)actionDefinedForKey:(NSString *)key;
-(BOOL)actionDefinedForAction:(int)action;
-(NSArray *)listeners;
-(NSArray *)eventsForListener:(id<SMFEventDelegate>)listener;
-(void)startLearning;
-(void)stopLearning;
-(void)loadInformation;
@end
@interface SMFDefaultEvents : NSObject<SMFEventDelegate>
{
}
+(SMFDefaultEvents *)sharedDefaults;
-(void)takeScreenshot;
-(void)restartLowtide;
-(void)configureEventManager;
-(void)startSlideshowController;
-(void)test1;
-(void)test2;

@end

