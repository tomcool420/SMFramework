//
//  SMFCompatibility.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SMFCompatibility : NSObject
{
    BOOL _usingFourPointTwoPlus;
    BOOL _usingFourPointThreePlus;
    BOOL _usingFourPointFourPlus;
}
+(SMFCompatibility *)compat;
-(BOOL)usingFourPointTwoPlus;
-(BOOL)usingFourPointThreePlus;
-(BOOL)usingFourPointFourPlus;
@end

#define SMF_COMPAT [SMFCompatibility compat]
