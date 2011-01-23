//
//  SMFViewMenuController.m
//  SMFramework
//
//  Created by Thomas Cool on 1/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFViewMenuController.h"
#import "SMFMenuItem.h"
#import "SMFPhotoMethods.h"

@implementation SMFViewMenuController
+(SMFViewMenuController *)menuViewController
{
    SMFViewMenuController *vc = [[SMFViewMenuController alloc] init];
    SMFPhotoMethods *col = [SMFPhotoMethods photoCollectionForPath:@"/var/root/pieter"];
//    BRMenuView *v = [[NSClassFromString(@"BRMarimbaMenuView") alloc] initWithMediaCollection:col];
    BRMenuView *v = [[BRMenuView alloc]init];
    vc.view = v;
    [v setTitle:@"Menu Controller" withAttributes:[[BRThemeInfo sharedTheme]menuTitleTextAttributes]];
    [v.list setDataSource:vc];
    [v release];
    return [vc autorelease];
}
-(id)init
{
    self=[super init];
    return self;
}
- (void)list:(id)list didFocusItemAtIndexPath:(id)indexPath{
    NSLog(@"didFocus");
}	// 0x3166c4e9
- (void)list:(id)list didPlayItemAtIndexPath:(id)indexPath{
    NSLog(@"didPlay");
}	// 0x3166c4f9
- (void)list:(id)list didSelectItemAtIndexPath:(id)indexPath{
    NSLog(@"didSelect");
}	// 0x3166c4f5
- (void)list:(id)list didUnFocusItemAtIndexPath:(id)indexPath{
    
}	// 0x3166c4f1
- (float)list:(id)list heightForItemAtIndexPath:(id)indexPath{
    return (float)[(BRListView *)[self view] list:list heightForItemAtIndexPath:indexPath];
}	// 0x3166c4dd
- (float)list:(id)list heightForSectionHeader:(long)sectionHeader{
    return (float)[(BRListView *)[self view] list:list heightForSectionHeader:sectionHeader];
}	// 0x3166c4d9
- (id)list:(id)list indexPathForItemID:(id)itemID{
    NSLog(@"indexpath");
    return nil;
}	// 0x3166c4d5
- (id)list:(id)list itemIDForIndexPath:(id)indexPath{
    NSLog(@"itemID");
    return nil;
}	// 0x3166c4d1
- (id)list:(id)list menuItemForRowAtIndexPath:(id)indexPath{
    SMFMenuItem * m = [SMFMenuItem menuItem];
    [m setTitle:@"hello"];
    NSLog(@"menuItemForRowAtIndexPath:indexPath: %@",indexPath);
    return m;
}	// 0x3166c4c1
- (long)list:(id)list numberOfRowsInSection:(long)section{
    return 3;
}	// 0x3166c4c9
- (id)list:(id)list sectionHeaderForSection:(long)section{
    SMFMenuItem * m = [SMFMenuItem menuItem];
    [m setTitle:[NSString stringWithFormat:@"Section %d",section,nil]];
    [m setAcceptsFocus:NO];
    return m;
}	// 0x3166c4cd
- (void)list:(id)list willDisplayItemAtIndexPath:(id)indexPath{
    
}	// 0x3166c4e1
- (id)list:(id)list willFocusItemAtIndexPath:(id)indexPath{
    
}	// 0x3166c4e5
- (void)list:(id)list willUnFocusItemAtIndexPath:(id)indexPath{
    
}	// 0x3166c4ed
- (long)numberOfSectionsInList:(id)list
{
    return 3;
}
@end
