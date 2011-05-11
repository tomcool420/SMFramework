//
//  SMFInvocationCenteredMenuController.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/27/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//
#import <BackRow/BackRow.h>
#import "SMFCenteredMenuController.h"

@class SMFCenteredMenuController;
@interface SMFInvocationCenteredMenuController : SMFCenteredMenuController {

}
+(id)invocationsForObject:(id)target withSelectorVal:(NSString *)selectorString withArguments:(NSArray *)arguments;
-(id)initWithTitles:(NSArray *)titles withInvocations:(NSArray *)invocations withTitle:(NSString *)title withDescription:(NSString *)description;

@end
