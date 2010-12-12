//
//  SMFEventManager.m
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFEventManager.h"
#import "SMFScreenCapture.h"
#import "SMFEventConfiguration.h"
#import "SMFPhotoMethods.h"
#define eventsPlist (CFStringRef)@"org.tomcool.SMFramework.eventManager"
#define eventString @"org.tomcool.SMFramework.eventManager"
#define remoteActionDict (CFStringRef)@"remoteActions"
#define keyDict     (CFStringRef)@"keyboardKeys"

#define kSMFEventDefaultScreenshot  @"defaults.screenshot"
#define kSMFEventDefaultRestartLowtide  @"defaults.restartLowtide"
#define kSMFEventDefaultSetup       @"defaults.setup"
#define kSMFEventDefaultSlideshow   @"defaults.slideshow"

@implementation SMFEventManager
SYNTHESIZE_SINGLETON_FOR_CLASS(SMFEventManager,sharedManager)
-(id)init
{
    self = [super init];
    _delegates=[[NSMutableDictionary alloc] init];
    [self loadInformation];
    _listeners=[[NSMutableDictionary alloc]init];
    _listenerSet=[[NSMutableSet alloc]init];
    [SMFScreenCapture sharedInstance];
    [SMFDefaultEvents sharedDefaults];
    _learning=NO;
    return self;
}
-(void)registerListener:(id<SMFEventDelegate>)listener forName:(NSString *)name
{
    [_listenerSet addObject:listener];
    [_delegates setObject:listener forKey:name];
}
-(void)registerListener:(id<SMFEventDelegate>)listener forNames:(NSArray*)names
{
    [_listenerSet addObject:listener];
    for(NSString *name in names)
    {
        [_delegates setObject:listener forKey:name];
    }
}

-(void)loadInformation
{
    _remoteActionKeys=[(NSDictionary *) CFPreferencesCopyAppValue(remoteActionDict, eventsPlist)mutableCopy];
    if (_remoteActionKeys==nil) {
        _remoteActionKeys=[[NSMutableDictionary alloc]init];
    }
    _keys=[(NSDictionary *) CFPreferencesCopyAppValue(keyDict, eventsPlist)mutableCopy];
    if (_keys==nil) {
        _keys=[[NSMutableDictionary alloc]init];
    }
}
-(void)startLearning
{
    _learning=YES;
}
-(void)stopLearning
{
    _learning=NO;
}
-(NSArray *)listeners
{    
    return [_listenerSet allObjects];
}
-(NSArray *)eventsForListener:(id<SMFEventDelegate>)listener
{
    NSMutableArray *a = [NSMutableArray array];
    for(NSString *k in [_delegates allKeys])
    {
        if ([_delegates objectForKey:k]==listener) {
            [a addObject:k];
        }
    }
    return a;
}
-(void)setKey:(NSString *)key forName:(NSString *)name
{
    [_keys setObject:name forKey:key];
    CFPreferencesSetAppValue(keyDict, (CFDictionaryRef)_keys, eventsPlist);
    CFPreferencesAppSynchronize(eventsPlist);
}
-(void)setRemoteAction:(int)action forName:(NSString *)name
{
    [_remoteActionKeys setObject:name forKey:[NSString stringWithFormat:@"%d",action,nil]];
    CFPreferencesSetAppValue(remoteActionDict, (CFDictionaryRef)_remoteActionKeys, eventsPlist);
    CFPreferencesAppSynchronize(eventsPlist);
}
-(void)callEventForAction:(NSString *)key
{
    if ([[_keys allKeys] containsObject:key]) 
    {
        NSString *name = [_keys objectForKey:key];
        if ([[_delegates allKeys] containsObject:name]) 
        {
            id<SMFEventDelegate>listener = [_delegates objectForKey:name];
            SMFEvent *e = [SMFEvent eventWithName:name andKey:key];
            [listener actionForEvent:e];
        }
    }
}
-(void)callEventForBREvent:(BREvent *)event
{
    NSDictionary *d = [event eventDictionary];
    NSString *s = [d objectForKey:@"kBRKeyEventCharactersKey"];
    if (d!=nil && s!=nil) {
        [self callEventForAction:s];
    }
    else if([event value]==0x01)
    {
        [self callEventForRemoteAction:[event remoteAction]];
    }
    
}
-(BOOL)callEventForRemoteAction:(int)action
{
    
    NSString *key=[NSString stringWithFormat:@"%d",action,nil];
    if ([[_remoteActionKeys allKeys] containsObject:key]) 
    {
        NSString *name = [_remoteActionKeys objectForKey:key];
        if ([[_delegates allKeys] containsObject:name]) 
        {
            id<SMFEventDelegate>listener = [_delegates objectForKey:name];
            SMFEvent *e = [SMFEvent eventWithName:name andKey:key];
            [listener actionForEvent:e];
            return YES;
        }
        else
            return NO;
    }
    else 
        return NO;
}
-(BOOL)actionDefinedForBREvent:(BREvent *)event
{
    if (_learning)
        return NO;
    if ([event remoteAction]==47) {
        NSDictionary *d = [event eventDictionary];
        NSString *s = [d objectForKey:@"kBRKeyEventCharactersKey"];
        if (d!=nil && s!=nil)
        {
            if ([s isEqualToString:@" "] && [[BRMediaPlayerManager singleton]_presentedPlayerController]==[[[BRApplicationStackManager singleton] stack]peekController]) {
                return YES;
            }
            else
                return [self actionDefinedForKey:s];
        }
        else
            return NO;
    }
    else if([event value]==0x01)
    {
        return [self actionDefinedForAction:[event remoteAction]];
    }
    return NO;
}
-(BOOL)actionDefinedForKey:(NSString *)key
{
    if(_learning)
        return NO;
    return [[_keys allKeys] containsObject:key];
}
-(BOOL)actionDefinedForAction:(int)action
{
    if (_learning)
        return NO;
    NSString *key=[NSString stringWithFormat:@"%d",action,nil];
    return [[_remoteActionKeys allKeys]containsObject:key];
    
}

@end
@implementation SMFDefaultEvents
SYNTHESIZE_SINGLETON_FOR_CLASS(SMFDefaultEvents,sharedDefaults)
-(id)init
{
    self=[super init];
    [[SMFEventManager sharedManager]registerListener:self 
                                            forNames:[NSArray arrayWithObjects:
                                                      kSMFEventDefaultScreenshot,
                                                      kSMFEventDefaultRestartLowtide,
                                                      kSMFEventDefaultSetup,
                                                      kSMFEventDefaultSlideshow,
                                                      nil]];
    [[SMFEventManager sharedManager]setRemoteAction:63265 forName:kSMFEventDefaultScreenshot];
    [[SMFEventManager sharedManager]setRemoteAction:63266 forName:kSMFEventDefaultRestartLowtide];
    [[SMFEventManager sharedManager]setRemoteAction:63267 forName:kSMFEventDefaultSlideshow];
    [[SMFEventManager sharedManager]setRemoteAction:18 forName:kSMFEventDefaultScreenshot];
    [[SMFEventManager sharedManager]setRemoteAction:15 forName:kSMFEventDefaultScreenshot];

    [[SMFEventManager sharedManager]setKey:@"=" forName:kSMFEventDefaultSetup];
    return self;
    
}
-(NSString *)displayName
{
    return @"Default Settings";
}
-(void)restartLowtide
{
    [[BRApplication sharedApplication] terminate];
}
-(void)actionForEvent:(SMFEvent *)event
{
//    NSLog(@"%@ %@ %@ %@",kSMFEventDefaultScreenshot,kSMFEventDefaultRestartLowtide,kSMFEventDefaultSetup,kSMFEventDefaultSlideshow);
//    NSLog(@"event: %@ %@",event,[event name]);
    
    if ([[event name] isEqualToString:kSMFEventDefaultScreenshot])
        [self takeScreenshot];
    else if ([[event name] isEqualToString:kSMFEventDefaultRestartLowtide])
        [self restartLowtide];
    else if ([[event name] isEqualToString:kSMFEventDefaultSetup])
        [self configureEventManager];
    else if ([[event name] isEqualToString:kSMFEventDefaultSlideshow])
        [self startSlideshowController];
        
}
-(NSString *)displayNameForEventKey:(NSString *)key
{
    if ([key isEqualToString:kSMFEventDefaultScreenshot])
        return @"Screenshot";
    else if ([key isEqualToString:kSMFEventDefaultRestartLowtide])
        return @"Restart Lowtide";
    else if ([key isEqualToString:kSMFEventDefaultRestartLowtide])
        return @"Configure Events Triggers";
    return nil;
}
-(void)takeScreenshot
{
    NSFileManager *man = [NSFileManager defaultManager];
    BOOL good=TRUE;
    NSString *path=@"/screenshot.png";
    if ([man fileExistsAtPath:@"/screenshot.png"]) {
        good =FALSE;
    }
    int i =1;
    while (!good) {
        i++;
        path = [NSString stringWithFormat:@"/screenshot_%i.png",i,nil];
        if (![man fileExistsAtPath:path])
            good=TRUE;
    }
    [SMFScreenCapture saveScreenToFile:path];
}
-(void)startSlideshowController
{
    NSLog(@"slideshow");
    //BRDataStore *store = [SMFPhotoMethods dataStoreForPath:@"/System/Library/PrivateFrameworks/AppleTV.framework/DefaultAnimalPhotos/"];
    BRDataStore *store = [SMFPhotoMethods dataStoreForPath:@"/nature"];
    NSLog(@"store: %@",store);
    BRPhotoControlFactory* controlFactory = [BRPhotoControlFactory standardFactory];
    SMFPhotoCollectionProvider* provider    = [SMFPhotoCollectionProvider providerWithDataStore:store controlFactory:controlFactory];//[[ATVSettingsFacade sharedInstance] providerForScreenSaver];//[collection provider];
    SMFPhotoBrowserController* pc  = [SMFPhotoBrowserController controllerForProvider:provider];
    [pc setTitle:@"DefaultAnimalPhotos"];
    [[[BRApplicationStackManager singleton] stack] pushController:pc];
}
-(void)configureEventManager
{
    SMFEventConfiguration *c = [[[SMFEventConfiguration alloc] init] autorelease];
    [[[BRApplicationStackManager singleton] stack]pushController:c];
}
-(void)test1
{
    
}
-(void)test2
{
    
}
@end