//
//  SMFExamples.m
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFExamples.h"
#import "SMFBookcaseController.h"
#import "SMFBookcaseDelegateAndDatasourceExample.h"
@implementation SMFExamples

SYNTHESIZE_SINGLETON_FOR_CLASS(SMFExamples, examples)
-(SMFBookcaseController *)bookcase
{
    SMFBookcaseController *c = [[SMFBookcaseController alloc]init ];
    SMFBookcaseDelegateAndDatasourceExample *d = [[SMFBookcaseDelegateAndDatasourceExample alloc] init];
    [c setDelegate:d];
    [c setDatasource:d];
    [d autorelease];
    return [c autorelease];
}
@end
