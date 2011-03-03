//
//  SMFComplexProcessDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 2/28/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFComplexDropShadowControl.h"


@interface SMFComplexProcessDropShadowControl : SMFComplexDropShadowControl {
    NSString *ap;
    BOOL finished;
    int returnCode;
}
@property (readwrite,copy)NSString *ap;
@property (readonly) int returnCode;
@property (readonly) BOOL finished;
@end
