//
//  SMFPreferences.h
//  SMFramework
//
//  Created by Thomas Cool on 12/6/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//


#import <Backrow/Backrow.h>

@interface SMFPreferences : NSUserDefaults {
	NSString * _applicationID;
	NSDictionary * _registrationDictionary;
}

-(id)initWithPersistentDomainName:(NSString *)domainName;
+(SMFPreferences *)preferences;
@end

