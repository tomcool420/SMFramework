//
//  OFMediaMenuController.m
//  Untitled
//
//  Created by Thomas Cool on 10/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFMenuController.h"

@implementation SMFMenuController
- (float)heightForRow:(long)row				{ return 0.0f;}
- (BOOL)rowSelectable:(long)row				{ return YES;}
- (long)itemCount							{ return (long)[_items count];}
- (id)itemForRow:(long)row					{ return [_items objectAtIndex:row];}
- (long)rowForTitle:(id)title				{ return (long)[_items indexOfObject:title];}
- (id)titleForRow:(long)row					
{ 
    return [[self itemForRow:row] text];
}
- (long)defaultIndex						{ return 0;}
- (id)init
{
    self=[super init];
    _items = [[NSMutableArray alloc]init];
    _options = [[NSMutableArray alloc] init];
    [[self list] setDatasource:self];
    return self;
}

- (void)dealloc
{
	[_items release];
	[_options release];
	[super dealloc];
}
-(id)everyLoad
{
    return self;
}
-(int)getSelection
{
	BRListControl *list = [self list];
	int row;
	NSMethodSignature *signature = [list methodSignatureForSelector:@selector(selection)];
	NSInvocation *selInv = [NSInvocation invocationWithMethodSignature:signature];
	[selInv setSelector:@selector(selection)];
	[selInv invokeWithTarget:list];
	if([signature methodReturnLength] == 8)
	{
		double retDoub = 0;
		[selInv getReturnValue:&retDoub];
		row = retDoub;
	}
	else
		[selInv getReturnValue:&row];
	return row;
}
-(void)leftActionForRow:(long)row
{
    
}
-(void)rightActionForRow:(long)row
{
    
}
-(BOOL)brEventAction:(BREvent *)event
{
	int remoteAction = [event remoteAction];
    if ([(BRControllerStack *)[self stack] peekController] != self)
		remoteAction = 0;
    
    int itemCount = [[(BRListControl *)[self list] datasource] itemCount];
    switch (remoteAction)
    {	
        case kBREventRemoteActionSwipeLeft:
        case kBREventRemoteActionLeft:
            if([event value] == 1)
                [self leftActionForRow:[self getSelection]];
            return YES;
            break;
        case kBREventRemoteActionSwipeRight:
        case kBREventRemoteActionRight:
            if([event value] == 1)
                [self rightActionForRow:[self getSelection]];
            return YES;
            break;
		case kBREventRemoteActionUp:
		case kBREventRemoteActionHoldUp:
			if([self getSelection] == 0 && [event value] == 1)
			{
				[self setSelection:itemCount-1];
				return YES;
			}
			break;
		case kBREventRemoteActionDown:
		case kBREventRemoteActionHoldDown:
			if([self getSelection] == itemCount-1 && [event value] == 1)
			{
				[self setSelection:0];
				return YES;
			}
			break;
    }
	return [super brEventAction:event];
}
- (void)setSelection:(int)sel
{
	BRListControl *list = [self list];
	NSMethodSignature *signature = [list methodSignatureForSelector:@selector(setSelection:)];
	NSInvocation *selInv = [NSInvocation invocationWithMethodSignature:signature];
	[selInv setSelector:@selector(setSelection:)];
	if(strcmp([signature getArgumentTypeAtIndex:2], "l"))
	{
		double dvalue = sel;
		[selInv setArgument:&dvalue atIndex:2];
	}
	else
	{
		long lvalue = sel;
		[selInv setArgument:&lvalue atIndex:2];
	}
	[selInv invokeWithTarget:list];
}

-(void)controlWasActivated
{

    if([self respondsToSelector:@selector(everyLoad)])
        [self everyLoad];
    [super controlWasActivated];
}
- (void)wasExhumedByPoppingController:(id)fp8	{[self wasExhumed];}
-(void)wasExhumed								{[[self list] reload];}
@end
