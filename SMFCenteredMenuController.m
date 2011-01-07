//
//  SMFCenteredMediaMenuController.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/25/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import "SMFCenteredMenuController.h"

@implementation SMFCenteredMenuController
- (id)init
{
    self=[super init];
    [self setUseCenteredLayout:YES];
    [self setMenuWidthFactor:2.0];
    return self;
}



@end
