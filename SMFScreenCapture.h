//
//  SMFScreenCapture.h
//  SMFramework
//
//  Created by Thomas Cool on 10/27/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import "SynthesizeSingleton.h"
#import <Backrow/Backrow.h>
#import "SMFEventManager.h"

@interface SMFScreenCapture : NSObject<SMFEventDelegate> {

}
+(SMFScreenCapture *)sharedInstance;
-(void)actionForEvent:(SMFEvent *)event;
+(void)saveScreenToFile:(NSString *)path;
+(NSData *)pngScreenData;
+(NSData *)controlPlaneData;

@end
