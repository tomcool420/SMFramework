//
//  SMFQueryMenu.m
//  SMFramework
//
//  Created by Thomas Cool on 11/5/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFCustomQueryMenu.h"
#import "SMFMenuItem.h"
#import "SMFMediaPreview.h"

@implementation SMFCustomQueryMenu
@synthesize lastSearchedQuery=_lastSearchedQuery;
@synthesize delegate=_delegate;
@synthesize spinner =_spi;
-(id)previewControlForItem:(long)item
{
    if ([_entryControl isHidden]) {
        return [SMFMediaPreview simplePreviewWithTitle:[self titleForRow:item] withSummary:nil withImage:[[BRThemeInfo sharedTheme]appleTVIcon]];
    }
    return nil;
    
}
-(id)init;
{
    self=[super init];
    _entryControl=[[BRTextEntryControl alloc] initWithTextEntryStyle:2];
    [_entryControl setTextFieldDelegate:self];
    CGRect f = [BRWindow interfaceFrame];
    f.size.width=f.size.width/3.f;
    double extra = [BRWindow interfaceFrame].size.width*(1/2.0f-1/3.0f)/2.0f;
    f.origin=CGPointMake(extra, 100.0f);
    [_entryControl setFrame:f];
    [[self list] setDatasource:self];
    [_entryControl setHidden:YES];
    
    _spi=[[BRWaitSpinnerControl alloc] init];
    CGRect sf=[BRWindow interfaceFrame];
    sf.size.width=sf.size.height*0.1;
    sf.origin.x=sf.size.width*1.0;
    sf.origin.y=sf.size.height-sf.size.width*1.5;
    sf.size.height=sf.size.width;
    [_spi setFrame:sf];
//    BRCursorControl *cc=[[BRCursorControl alloc]init];
//    [self addControl:[cc autorelease]];
    return self;
}
-(void)layoutSubcontrols
{
    [super layoutSubcontrols];
    [self addControl:_entryControl];
    [self addControl:_spi];
}
-(void)reloadItems
{
    [[self list] reload];
}
- (void) textDidChange: (id) sender
{
    self.lastSearchedQuery=[[_entryControl textField] stringValue];
    [self search:self.lastSearchedQuery];
}

- (void) textDidEndEditing: (id) sender
{
    
}

-(void)wasPushed
{
    [super wasPushed];
    
    
}
-(BOOL)brEventAction:(id)action
{
    switch ([action remoteAction]) {
        case kBREventRemoteActionRight:
        {
            BRControl *old = [self focusedControl];
            BOOL r = [super brEventAction:action];
            BRControl *new = [self focusedControl];
            if (old==_entryControl && new!=_entryControl) {
                
                [_entryControl setHidden:YES];
                [self resetPreviewController];
            }
            return r;
        }
        case kBREventRemoteActionLeft:
        {
            BRControl *old = [self focusedControl];
            BOOL r = [super brEventAction:action];
            BRControl *new = [self focusedControl];
            if (new==_entryControl && old!=_entryControl) {
                
                [_entryControl setHidden:NO];
                [self resetPreviewController];
                
            }
            return r;
        }

            break;
        default:
            break;
    }
    return [super brEventAction:action];
}

- (long)defaultIndex						{ return 0;}
-(void)dealloc
{
    [_entryControl removeFromParent];
    [_entryControl release];
    _entryControl=nil;
    [super dealloc];
}

#pragma mark methods to overwrite
-(long)itemCount
{
    return (long)2;
}
-(id)itemForRow:(long)row
{
    SMFMenuItem *menuItem= [SMFMenuItem menuItem];
     [menuItem setTitle:@"Hello"];
    return menuItem;
}
-(id)titleForRow:(long)row
{
    return @"Hello";
}
-(void)itemSelected:(long)selected
{
    return;
}
- (float)heightForRow:(long)row				{ return 0.0f;}
- (BOOL)rowSelectable:(long)row				{ return YES;}

-(void)search:(NSString *)searchString
{
    //Do Something
}
@end
