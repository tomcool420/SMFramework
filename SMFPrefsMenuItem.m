//
//  SMFPrefsMenuItem.m
//  SMFramework
//
//  Created by Thomas Cool on 4/29/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import "SMFPrefsMenuItem.h"
#import <Backrow/BackRow.h>


@implementation SMFPrefsMenuItem
@synthesize type=_type;
@synthesize key=_key;
@synthesize preferences=_prefs;
@synthesize title=_title;
@synthesize longDescription=_description;
@synthesize delegate=_delegate;
@synthesize ctrl=_ctrl;
@synthesize notificationName=_notificationName;
+(SMFPrefsMenuItem *)itemWithType:(SMFPrefType)t forKey:(NSString *)k inPrefs:(NSUserDefaults *)p
{
    return [SMFPrefsMenuItem itemWithType:t forKey:k inPrefs:p withTitle:nil withDescription:nil];
}
+(SMFPrefsMenuItem *)itemWithType:(SMFPrefType)t forKey:(NSString *)k inPrefs:(NSUserDefaults *)p withTitle:(NSString *)s withDescription:(NSString *)d
{
    if (p==nil || k==nil)
    {
        return nil;
    }
        
    SMFPrefsMenuItem *mi = [[SMFPrefsMenuItem new] autorelease];
    mi.type=t;
    mi.key=k;
    mi.preferences=p;
    mi.title=s;
    mi.longDescription=d;
    return mi;
}
//-(NSString *)description
//{
//    return [NSString stringWithFormat:<#(NSString *)format#>
//}
-(NSString *)titleText
{
   if (self.title!=nil)
       return self.title;
    return self.key;
}
-(NSString *)itemText
{
    switch (self.type) {
        case kSMFPrefTypeString:
        case kSMFPrefTypePath:
            return [self.preferences objectForKey:self.key];
            break;
        case kSMFPrefTypeInteger:
        case kSMFPrefTypeDouble:
        case kSMFPrefTypeNumber:
        case kSMFPrefTypeLong:
            return [NSString  stringWithFormat:@"%@",[self.preferences objectForKey:self.key],nil];
            break;
        case kSMFPrefTypeColor:
            return [NSString  stringWithFormat:@"%@",[self.preferences objectForKey:self.key],nil];
            break;
        case kSMFPrefTypeBool:
            return ([[self.preferences objectForKey:self.key] boolValue]?@"YES":@"NO");;
            break;
        default:
            break;
    }
    return @"";
}
-(BRMenuItem *)menuItem
{
    SMFMenuItem *mi = [SMFMenuItem menuItem];
    [mi setTitle:[self titleText]];
    if (self.type==kSMFPrefTypeColor) {
        NSMutableDictionary *d = [[[[BRThemeInfo sharedTheme] menuItemSmallTextAttributes] mutableCopy]autorelease];
        [d setObject:(id)[[SMFThemeInfo sharedTheme]colorFromHTMLColor:[self.preferences integerForKey:self.key]] forKey:@"CTForegroundColor"];
        [mi setRightJustifiedText:[self itemText] withAttributes:d];
    }
    else {
        [mi setRightText:[self itemText]];
    }

//    
    return mi;
}
-(void)selected
{
    switch (self.type) {
        case kSMFPrefTypeBool:
            [self.preferences setBool:![self.preferences boolForKey:self.key] forKey:self.key];
            break;
        case kSMFPrefTypeString:
        {
            BRTextEntryController *c = [[[BRTextEntryController alloc] init] autorelease];
            [c setTitle:[self titleText]];
            [c setTextFieldDelegate:self];
            [c setInitialTextEntryText:[self.preferences objectForKey:self.key]];
            [[[BRApplicationStackManager singleton]stack] pushController:c];
        }
            break;
        case kSMFPrefTypeColor:
        {
            SMFColorSelectionMenu *c = [SMFColorSelectionMenu colorMenuForKey:@"nacih" andDelegate:self];
            [[[BRApplicationStackManager singleton]stack] pushController:c];
        }
            break;
        case kSMFPrefTypeController:
        {
            if (self.ctrl!=nil) {
                [[[BRApplicationStackManager singleton]stack]pushController:self.ctrl];
            }
        }
            break;
        case kSMFPrefTypeNumber:
        case kSMFPrefTypeDouble:
        {
            BRTextEntryController *c = [[[BRTextEntryController alloc]init]autorelease];
            [c setTitle:[self titleText]];
            [c setPrimaryInfoText:@"Please enter a number, decimal sign is a \".\"" withAttributes:[[BRThemeInfo sharedTheme]promptCenteredTextAttributes]];
            [c setTextFieldDelegate:self];
            [c setInitialTextEntryText:[NSString stringWithFormat:@"%@",[self.preferences objectForKey:self.key],nil]];
            [c setTextEntryStyle:1];
            [[[BRApplicationStackManager singleton]stack]pushController:c];
            
        }
            break;
        default:
            break;
    }
}

#pragma mark text entry delegate
-(void)textDidChange:(id)text
{
    
}
-(void)textDidEndEditing:(id)text
{
    NSString *t = [text stringValue];
    
    switch (self.type) {
        case kSMFPrefTypeString:
            [self.preferences setObject:t forKey:self.key];
            break;
        case kSMFPrefTypeNumber:
        case kSMFPrefTypeDouble:
        {
            double a=0.0;
            NSScanner *s = [NSScanner scannerWithString:t];
            [s scanDouble:&a];
            [self.preferences setObject:[NSNumber numberWithDouble:a] forKey:self.key];
        }
            break;
        default:
            break;
    }
    if (self.type==kSMFPrefTypeString) {
        
    }
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(list)]) {
        [[self.delegate list]reload];
    }
    [[[BRApplicationStackManager singleton]stack]popController];
}
-(void)dealloc
{
    self.type=0;
    self.key=nil;
    self.preferences=nil;
    self.title=nil;
    self.longDescription=nil;
    self.delegate=nil;
    self.ctrl=nil;
    [super dealloc];
}

#pragma mark Color Selection
-(void)colorSelected:(NSArray *)rgba forKey:(NSString *)k
{
    int r = (int)([[rgba objectAtIndex:0] floatValue]*255);
    int g = (int)([[rgba objectAtIndex:1] floatValue]*255);
    int b = (int)([[rgba objectAtIndex:2] floatValue]*255);
    int c = ((r&0xFF)<<16)+((g&0xFF)<<8)+(b&0xFF);
    NSString *color = [NSString stringWithFormat:@"%i",c,nil];
    [self.preferences setObject:color forKey:self.key];
    if (self.delegate && [self.delegate respondsToSelector:@selector(list)]) {
        [[self.delegate list]reload];
    }
    [[[BRApplicationStackManager singleton]stack]popController];
}
@end
