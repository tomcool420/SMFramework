//
//  SMFListDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 1/21/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFListDropShadowControl.h"
#import "SMFThemeInfo.h"
#import "SMFMenuItem.h"
#import "SMFDefines.h"
@implementation SMFListDropShadowControl
@synthesize cDelegate, cDatasource;
-(id)init
{
    self =[super init];
    if (self!=nil) {
        list = [[BRListControl alloc]init];
        [list setDatasource:self];
        self.backgroundColor=[[SMFThemeInfo sharedTheme]blackColor];
        self.borderColor=[[SMFThemeInfo sharedTheme] whiteColor];
        self.borderWidth=3.0;
        [self setContent:list];
    }
    return self;
}
-(void)reloadList
{
    [list reload];
}
-(void)controlWasActivated
{
    NSLog(@"controlWasActivated");
    
    [list setSelection:0];
    [self setFocusedControl:list];
    [self _setFocus:list];
    [super controlWasActivated];
}
- (float)heightForRow:(long)row				
{ 
    if (cDatasource && [cDatasource respondsToSelector:@selector(popupHeightForRow:)]) {
        return [cDatasource popupHeightForRow:row];
    }
    return 0.0f;
}
- (BOOL)rowSelectable:(long)row				
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupRowSelectable:)])
        return [cDatasource popupRowSelectable:row];
    return YES;
}

- (long)itemCount							
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupItemCount)])
        return [cDatasource popupItemCount];
    return (long)3;
}
- (id)itemForRow:(long)row					
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupItemForRow:)])
        return [cDatasource popupItemForRow:row];
    SMFMenuItem *it = [SMFMenuItem menuItem];
    [it setTitle:@"Default Item"];
    return it;
}
- (id)titleForRow:(long)row					
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupTitleForRow:)])
        return [cDatasource popupTitleForRow:row];
    if (row>=[self itemCount])
        return nil;
    return [[self itemForRow:row] text];
}
- (long)defaultIndex						
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupDefaultIndex)])
        return [cDatasource popupDefaultIndex];
    return 0;
}
-(void)itemSelected:(long)selected
{
    if (cDelegate && [cDelegate respondsToSelector:@selector(popupItemSelected:)]) {
        [cDelegate popupItemSelected:selected];
    }
    else {
        [self removeFromParent];
    }
}
-(BOOL)brEventAction:(BREvent*)event
{
    int remoteAction = [event remoteAction];
    switch (remoteAction)
    {
        case kBREventRemoteActionPlay:
            [self itemSelected:[list selection]];
            return YES;
            break;
    }
    return [super brEventAction:event];
}


-(CGRect)rectForSize:(CGSize)s
{
    CGRect r;
    r.size.width=s.width;
    SMFMenuItem *a = [SMFMenuItem menuItem];
    CGSize ss = [a sizeThatFits:s];
    int it = [self itemCount];
    if (it>6)
        it=6;
    r.size.height=50.+ss.height*it;
    CGSize windowSize = [BRWindow maxBounds];
    r.origin.y=(windowSize.height-r.size.height)/2.0f;
    r.origin.x=(windowSize.width-r.size.width)/2.0f;
    return r;
}
@end
