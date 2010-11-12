//
//  SMFInvocationCenteredMenuController.m
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/27/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import "SMFInvocationCenteredMenuController.h"

@implementation SMFInvocationCenteredMenuController
-(id)initWithTitles:(NSArray *)titles withInvocations:(NSArray *)invocations withTitle:(NSString *)title withDescription:(NSString *)description
{
    self=[super init];
    [self setListTitle:title];
    [self setPrimaryInfoText:description];
    int i,count=[titles count];
    BRMenuItem *a;
    for(i=0;i<count;i++)
    {
        a=[[BRMenuItem alloc] init];
        
        [a setText:[titles objectAtIndex:i] withAttributes:[[BRThemeInfo sharedTheme]menuItemTextAttributes]];
        [_items addObject:a];
        [_options addObject:[invocations objectAtIndex:i]];
    }
    return self;
}
-(void)itemSelected:(long)arg1
{
    if([[_options objectAtIndex:arg1] respondsToSelector:@selector(invoke)])
        [(NSInvocation *)[_options objectAtIndex:arg1]invoke];
    [[self stack]popController];
}
+(id)invocationsForObject:(id)target withSelectorVal:(NSString *)selectorString withArguments:(NSArray *)arguments
{
    
    if (selectorString==nil) {
        return @"none";
    }
    SEL theSelector;
    NSMethodSignature *aSignature;
    NSInvocation *anInvocation;
    id b = target;
    theSelector = NSSelectorFromString(selectorString);
    //theSelector= @selector(removeFromQueue:);
    // NSLog(@"selector)
    aSignature = [[target class] instanceMethodSignatureForSelector:theSelector];
    //NSLog(@"signature: %@",aSignature);
    anInvocation = [NSInvocation invocationWithMethodSignature:aSignature];
    [anInvocation setSelector:theSelector];
    [anInvocation setTarget:b];
    if (arguments !=nil)
    {
        int i,count=[arguments count];
        id c;
        for(i=2;i<count+2;i++)
        {
            c=[arguments objectAtIndex:i-2];
            [anInvocation setArgument:&c atIndex:i];
        }
        
    }
    [anInvocation retainArguments];
    return anInvocation;
}
@end
