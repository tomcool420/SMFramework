//
//  SMFQueryMenu.m
//  SMFramework
//
//  Created by Thomas Cool on 11/5/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFQueryMenu.h"


@implementation SMFQueryMenu

-(id)init;
{
    self=[super init];
    _items = [[NSTimeZone knownTimeZoneNames] retain];
    _filteredArray = [[NSMutableArray alloc] init];
    _entryControl=[[BRTextEntryControl alloc] initWithTextEntryStyle:2];
    [_entryControl setTextFieldDelegate:self];
    CGRect f = [BRWindow interfaceFrame];
    f.size.width=f.size.width/3.f;
    _filteredArray=[_items copy];

    float extra = [BRWindow interfaceFrame].size.width*(1/2.0f-1/3.0f)/2.0f;
    f.origin=CGPointMake(extra, 100.0f);
    [_entryControl setFrame:f];
    [[self list] setDatasource:self];
    [self setListTitle:@"Time Zone"]; 
    return self;
}
-(void)setDelegate:(id<SMFQueryDelegate>)d
{
    _delegate=d;
}
-(id<SMFQueryDelegate>)delegate
{
    return _delegate;
}
-(void)reloadItems
{
    NSString *filter = [[[_entryControl textField]stringValue] stringByReplacingOccurrencesOfString:@" " withString:@"_"];
    if ([filter length]>0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"self CONTAINS[cd] %@",filter,nil];
        [_filteredArray release];
        _filteredArray=[[_items filteredArrayUsingPredicate:predicate] retain];
    }
    else {
        [_filteredArray release];
        _filteredArray=[_items copy];

    }


    [[self list] reload];
}
- (void) textDidChange: (id) sender
{
    // do nothing for now
    [self reloadItems];
}

- (void) textDidEndEditing: (id) sender
{
    
}

-(void)wasPushed
{
    [super wasPushed];
    [self addControl:_entryControl];
    
}

- (float)heightForRow:(long)row				{ return 0.0f;}
- (BOOL)rowSelectable:(long)row				{ return YES;}
- (long)itemCount							{ return (long)[_filteredArray count];}
- (id)itemForRow:(long)row					
{
    SMFMenuItem *m = [SMFMenuItem menuItem];
    NSArray * f =[(NSString *)[_filteredArray objectAtIndex:row] componentsSeparatedByString:@"/"];
    NSString *t = nil;
    if ([f count]==2) {
        t=[f objectAtIndex:1];
        [m setRightText:[f objectAtIndex:0]];
    }
    else if([f count]==3)
    {
        t=[f objectAtIndex:([f count]-1)];
        NSArray *ff = [f subarrayWithRange:NSMakeRange(0, [f count]-1)];
        [m setRightText:[ff componentsJoinedByString:@" / "]];
    }
    else
        t=[_filteredArray objectAtIndex:row];
    [m setTitle:[t stringByReplacingOccurrencesOfString:@"_" withString:@" "]];
    return m;
}
- (id)titleForRow:(long)row					
{ 
    return [_filteredArray objectAtIndex:row];
}
-(void)itemSelected:(long)selected
{
    if (selected<[_filteredArray count] && _delegate!=nil) {
        [_delegate queryMenu:self itemSelected:[_filteredArray objectAtIndex:selected]];
    }
}
- (long)defaultIndex						{ return 0;}
-(void)dealloc
{
    [_entryControl removeFromParent];
    [_entryControl release];
    _entryControl=nil;
    [_items release];
    _items = nil;
    [_filteredArray release];
    _filteredArray=nil;
    _delegate=nil;
    [super dealloc];
}
@end
