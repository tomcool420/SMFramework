//
//  SMFDictionaryEditor.m
//  SMFramework
//
//  Created by Thomas Cool on 5/1/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFDictionaryEditor.h"
#import "SMFramework.h"
#import "SMFDictionaryObjectEditor.h"


@implementation SMFDictionaryEditor
@synthesize delegate;
@synthesize key=_k;
-(id)previewControlForItem:(long)row
{
    if (row<[_keys count]) 
    {
        SMFMediaPreview *p = [SMFMediaPreview mediaPreview];
        SMFBaseAsset *a = [SMFBaseAsset asset];
        [a setCustomKeys:[NSArray arrayWithObjects:@"Key",@"Value",@"Class",nil]
              forObjects:[NSArray arrayWithObjects:
                          [_keys objectAtIndex:row],
                          [_d objectForKey:[_keys objectAtIndex:row]],
                          NSStringFromClass([[_d objectForKey:[_keys objectAtIndex:row]] class]),
                          nil]];
        [a setCoverArt:[[BRThemeInfo sharedTheme]appleTVIcon]];
        [a setTitle:[self titleForRow:row]];
        [p setAsset:a];

        return p;
                          
    }
    return [super previewControlForItem:row];
}
-(id)initWithDictionary:(NSDictionary *)d
{
    self=[super init];
    if (self) {
        if (d==nil) {
            _d=[[NSMutableDictionary dictionary] retain];
        }
        else {
            _d=[d mutableCopy];
        }
        NSLog(@"d: %@",d);
        
    }
    [self refresh];
    return self;
}
-(id)initWithMutableDictionary:(NSMutableDictionary *)d inplace:(BOOL)inpl
{
    self=[super init];
    if (self) {
        if (inpl)
            _d=[d retain];
        else
            _d=[d mutableCopy];
    }
    [self refresh];
    return self; 
}
-(long)itemCount
{
    return [[_d allKeys] count]+2;
}
-(void)refresh
{
    [_keys release];
    _keys =[[[_d allKeys] sortedArrayUsingSelector:@selector(compare:)] retain];
    NSLog(@"keys: %@",_keys);
    [[self list]removeDividers];
    [[self list] addDividerAtIndex:0 withLabel:@"Keys"];
    [[self list] addDividerAtIndex:[_keys count] withLabel:@"Options"];
    [[self list]reload];
    
}
-(id)titleForRow:(long)row
{
    if (row<[_keys count]) {
        return [_keys objectAtIndex:row];
    }
    else {
        row-=[_keys count];
        if (row==0) {
            return @"New Object";
        }
        else if(row==1)
        {
            return @"Save";
        }
    }
    return @"";

}
-(id)itemForRow:(long)row
{
    SMFMenuItem *it=[SMFMenuItem menuItem];
    [it setTitle:[self titleForRow:row]];
    return it;
}
-(void)itemSelected:(long)row
{
    if (row<[_keys count]) {
        SMFDictionaryObjectEditor *e = [[[SMFDictionaryObjectEditor alloc] initWithKey:[_keys objectAtIndex:row]
                                                                            withObject:[_d objectForKey:[_keys objectAtIndex:row]]
                                                                          withDelegate:self] autorelease];
        [[self stack]pushController:e];
        
    }
    else {
        row-=[_keys count];
        if (row==0) {
            SMFDictionaryObjectEditor *ee = [[[SMFDictionaryObjectEditor alloc] initWithKey:nil
                                                                                withObject:nil
                                                                              withDelegate:self] autorelease];

            [[self stack]pushController:ee];
        }
        else if(row==1)
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(setObject:forKey:)]) {
                [self.delegate setObject:_d forKey:self.key];
            }
            [[self stack]popController];
        }
    }

}
-(void)deleteObjectForKey:(NSString *)k
{
    if (k!=nil && [[_d allKeys] containsObject:k]) {
        [_d removeObjectForKey:k];
    }
    [self refresh];
}
-(void)setObject:(NSObject *)obj forKey:(NSString *)k
{
    if (obj!=nil && k!=nil) {
        [_d setObject:obj forKey:k];
    }
    [self refresh];
}
@end
