//
//  SMFDictionaryObjectEditor.m
//  SMFramework
//
//  Created by Thomas Cool on 5/1/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFDictionaryObjectEditor.h"
#import "Backrow/AppleTV.h"
#import "SMFramework.h"
typedef enum _kSMFKe{
    kSMFEditorKey,
    kSMFEditorValue,
    kSMFEditorType,
    kSMFEditorSave,
    kSMFEditorDelete,
    
    kSMFEditorCount,
}kSMFKe;
@implementation SMFDictionaryObjectEditor
@synthesize delegate,obj,key;
-(id)initWithKey:(NSString *)k withObject:(NSObject *)o withDelegate:(NSObject *)del
{
    self=[super init];
    if (self) {
        initialKey=[k copy];
        if(k!=nil)
            self.key=k;
        if(o!=nil)
            self.obj=o;
        self.delegate=del;
        [self setListTitle:@"Object Editor"];
    }
    return self;
}
-(long)itemCount
{
    return kSMFEditorCount;
}
-(id)titleForRow:(long)row
{
    if(row==kSMFEditorKey)
        return @"Key";
    else if(row==kSMFEditorValue)
        return @"Object";
    else if(row==kSMFEditorType)
        return @"Type";
    else if(row==kSMFEditorSave)
        return @"Save";
    else if(row==kSMFEditorDelete)
        return @"Delete";
    return @"___";
}
-(id)itemTextForRow:(long)row
{
    if (row==kSMFEditorKey)
        return [NSString stringWithFormat:@"%@",self.key,nil];
    else if(row==kSMFEditorValue)
        return [NSString stringWithFormat:@"%@",self.obj,nil];
    else if(row==kSMFEditorType)
    {
        if (self.obj!=nil)
            return NSStringFromClass([self.obj class]);
        else 
            return @"";
    }

    
    
    return @"";
}
-(id)itemForRow:(long)row
{
    SMFMenuItem *it = [SMFMenuItem menuItem];
    [it setTitle:[self titleForRow:row]];
    [it setRightText:[self itemTextForRow:row]];
    return it;
}
-(void)itemSelected:(long)selected
{
    lastItemSelected=selected;
    switch (selected) {
        case kSMFEditorKey:
        {
            BRTextEntryController *c = [[BRTextEntryController alloc] initWithTextEntryStyle:1];
            [c setTitle:@"Set Key"];
            [c setInitialTextEntryText:[NSString stringWithFormat:@"%@",self.key,nil]];
            [c setTextFieldDelegate:self];
            [[self stack]pushController:[c autorelease]];
        }
            break;
        case kSMFEditorValue:
        {
            BRTextEntryController *c = [[BRTextEntryController alloc] initWithTextEntryStyle:1];
            [c setTitle:@"Set Value"];
            [c setInitialTextEntryText:[NSString stringWithFormat:@"%@",self.obj,nil]];
            [c setTextFieldDelegate:self];
            [[self stack]pushController:[c autorelease]];
        }
            break;
        case kSMFEditorSave:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(setObject:forKey:)]) {
                [self.delegate setObject:self.obj forKey:self.key];
                [[self stack]popController];
            }
            break;
        }
        case kSMFEditorDelete:
        {
            if (self.delegate && [self.delegate respondsToSelector:@selector(deleteObjectForKey:)]) {
                [self.delegate deleteObjectForKey:(initialKey!=nil?initialKey:self.key)];
                [[self stack]popController];
            }
            break;
        }
        default:
            break;
    }
}
-(void)textDidChange:(id)text
{
    
}
-(void)textDidEndEditing:(id)text
{
    switch (lastItemSelected) {
        case kSMFEditorKey:
            self.key=[text stringValue];
            break;
        case kSMFEditorValue:
            self.obj=[text stringValue];
            break;
        default:
            break;
    }
    [[self stack] popToController:self];
    [[self list]reload];
}
@end
