//
//  SMFPreferences.m
//  SMFramework
//
//  Created by Thomas Cool on 12/6/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFPreferences.h"


@implementation SMFPreferences

+(SMFPreferences *)preferences {
    static SMFPreferences *_preferences = nil;
    
    if(!_preferences)
        _preferences = [[self alloc] initWithPersistentDomainName:@"org.tomcool.SMFramework"];
    
    return _preferences;
}

-(id)initWithPersistentDomainName:(NSString *)domainName {
	if((self = [super init]))	{
		_applicationID = [domainName copy];
		_registrationDictionary = nil;		
	}
    
    return self;
}

-(void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
    
	[_applicationID release];
	[_registrationDictionary release];
	[super dealloc];
}

-(id)objectForKey:(NSString *)defaultName {
	id value = [(id)CFPreferencesCopyAppValue((CFStringRef)defaultName, (CFStringRef)_applicationID) autorelease];
	if(value == nil)
		value = [_registrationDictionary objectForKey:defaultName];
	return value;
}

-(void)setObject:(id)value forKey:(NSString *)defaultName {
	CFPreferencesSetAppValue((CFStringRef)defaultName, (CFPropertyListRef)value, (CFStringRef)_applicationID);
    [self synchronize];
}

-(void)removeObjectForKey:(NSString *)defaultName {
	CFPreferencesSetAppValue((CFStringRef)defaultName, NULL, (CFStringRef)_applicationID);
    [self synchronize];
}
-(void)setBool:(BOOL)value forKey:(NSString *)defaultName
{
    CFPreferencesSetAppValue((CFStringRef)defaultName, (CFNumberRef)[NSNumber numberWithBool:value] , (CFStringRef)_applicationID);
    [self synchronize];
}
-(void)setInteger:(NSInteger)value forKey:(NSString *)defaultName
{
    CFPreferencesSetAppValue((CFStringRef)defaultName, (CFNumberRef)[NSNumber numberWithInteger:value], (CFStringRef)_applicationID);
    [self synchronize];
}
-(void)setDouble:(double)value forKey:(NSString *)defaultName
{
    CFPreferencesSetAppValue((CFStringRef)defaultName, (CFNumberRef)[NSNumber numberWithDouble:value], (CFStringRef)_applicationID);
    [self synchronize];
}
-(void)setFloat:(float)value forKey:(NSString *)defaultName
{
    CFPreferencesSetAppValue((CFStringRef)defaultName, (CFNumberRef)[NSNumber numberWithFloat:value], (CFStringRef)_applicationID);
    [self synchronize];
}
-(BOOL)boolForKey:(NSString *)defaultName
{
    id obj = [self objectForKey:defaultName];
    if(obj!=nil && [obj respondsToSelector:@selector(boolValue)])
        return [obj boolValue];
    return [[_registrationDictionary objectForKey:defaultName] boolValue];
}
-(NSInteger)integerForKey:(NSString *)defaultName
{
    id obj = [self objectForKey:defaultName];
    if(obj!=nil && [obj respondsToSelector:@selector(integerValue)])
        return [obj integerValue];
    return [[_registrationDictionary objectForKey:defaultName] integerValue];
}
-(double)doubleForKey:(NSString *)defaultName
{
    id obj = [self objectForKey:defaultName];
    if(obj!=nil && [obj respondsToSelector:@selector(doubleValue)])
        return [obj floatValue];
    return [[_registrationDictionary objectForKey:defaultName] doubleValue];
}
-(float)floatForKey:(NSString *)defaultName
{
    id obj = [self objectForKey:defaultName];
    if(obj!=nil && [obj respondsToSelector:@selector(floatValue)])
        return [obj floatValue];
    return [[_registrationDictionary objectForKey:defaultName] floatValue];
}

-(void)registerDefaults:(NSDictionary *)registrationDictionary {
	[_registrationDictionary release];
	_registrationDictionary = [registrationDictionary retain];
}

-(BOOL)synchronize {
	return CFPreferencesSynchronize((CFStringRef)_applicationID, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
}


@end
