//
//  SMFCompatibility.m
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFCompatibility.h"
#import "SMFramework.h"
@implementation SMFCompatibility


SYNTHESIZE_SINGLETON_FOR_CLASS(SMFCompatibility, compat)
-(id)init
{
    self=[super init];
    if (self!=nil) {
        _usingFourPointFourPlus=NO;
        _usingFourPointThreePlus=NO;
        _usingFourPointTwoPlus=NO;
        if (NSClassFromString(@"BRVoiceOver")!=nil) {
            _usingFourPointTwoPlus=YES;
        }
        if (_usingFourPointTwoPlus && NSClassFromString(@"BRTableView")) {
            _usingFourPointThreePlus=YES;
        }
        if (_usingFourPointThreePlus && NSClassFromString(@"BRProxyManager")) {
            _usingFourPointFourPlus=YES;
        }
    }
    return self;
}
-(BOOL)usingFourPointTwoPlus
{  
    return _usingFourPointTwoPlus;
}
-(BOOL)usingFourPointThreePlus
{
    return _usingFourPointThreePlus;
}
-(BOOL)usingFourPointFourPlus
{
    return _usingFourPointFourPlus;
}
@end
