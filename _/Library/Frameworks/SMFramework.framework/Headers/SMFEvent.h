//
//  SMFEvent.h
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//



@interface SMFEvent : NSObject {
    NSString *key;
    NSString *name;
}
+(SMFEvent *)eventWithName:(NSString *)n andKey:(NSString *)k;
@property (retain)NSString *key;
@property (retain)NSString *name;
@end
