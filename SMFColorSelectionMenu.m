//
//  SMFColorSelectionMenu.m
//  SMFramework
//
//  Created by Thomas Cool on 11/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFColorSelectionMenu.h"
#import "SMFMenuItem.h"
#import "SMFBaseAsset.h"
#import "SMFMediaPreview.h"
#import "SMFThemeInfo.h"
#import <UIKit/UIColor.h>
#define SMFFloat(val) [NSNumber numberWithFloat:(val)]
#define SMFFloatString(val) [NSString stringWithFormat:@"%.1f",(val)]
@implementation SMFColorSelectionMenu
@synthesize delegate;
@synthesize key;
+(SMFColorSelectionMenu *)colorMenuForKey:(NSString *)k andDelegate:(NSObject<SMFColorSelectionDelegate>*)del
{
    SMFColorSelectionMenu *col = [[SMFColorSelectionMenu alloc] init];
    [col setDelegate:del];
    [col setKey:k];
    return [col autorelease];
}
static float red[]=  {0.0,0.0,0.6,0.0,0.33,0.0,0.66,1.0,1.0,0.5,1.0,1.0,1.0};
static float green[]={0.0,0.0,0.4,1.0,0.33,1.0,0.66,0.0,0.5,0.0,0.0,1.0,1.0};
static float blue[] ={0.0,1.0,0.2,1.0,0.33,0.0,0.66,1.0,0.0,0.5,0.0,1.0,0.0};
-(id)previewControlForItem:(long)row
{
    if (row>=[_items count])
        return nil;
    SMFMediaPreview *p = [[SMFMediaPreview alloc] init];
    SMFBaseAsset *a = [[SMFBaseAsset alloc] init];
    [a setCoverArt:[[SMFThemeInfo sharedTheme] colorAppleTVNameImage]];
    [a setTitle:[self titleForRow:row]];
    [a setCustomKeys:[NSArray arrayWithObjects:@"Red",@"Green",@"Blue",@"Alpha",nil]
          forObjects:[NSArray arrayWithObjects:SMFFloatString(red[row]),SMFFloatString(green[row]),
                      SMFFloatString(blue[row]),SMFFloatString(1.0),nil]];
    [p setAsset:a];
    [a release];
    return [p autorelease];
}

-(id)init
{
    self=[super init];
    if (self) {
        [self setListTitle:@"Select A Color"];
        NSArray *strings = [NSArray arrayWithObjects:@"Black",@"Blue",@"Brown",@"Cyan",@"Dark Gray",@"Green",
                            @"Light Gray",@"Magenta",@"Orange",@"Purple",@"Red",@"White",@"Yellow",nil];
        CGColorSpaceRef rgb = CGColorSpaceCreateDeviceRGB();
        for(int i=0;i<[strings count];i++)
        {
            //UIColor*c = [[[UIColor alloc] initWithRed:red[i] green:green[i] blue:blue[i] alpha:1.0] autorelease];
            //NSLog(@"%@:%@",[strings objectAtIndex:i],c);
            SMFMenuItem *it = [[SMFMenuItem alloc] init];
            NSMutableDictionary *d = [[[BRThemeInfo sharedTheme]menuItemTextAttributes] mutableCopy];
            
            const CGFloat myColor[] = {red[i], green[i], blue[i], 1.0};
            CGColorRef color = CGColorCreate(rgb, myColor);
            
            [d setObject:(id)color forKey:@"CTForegroundColor"];
            CGColorRelease(color);
            [it setText:[strings objectAtIndex:i] withAttributes:d];
            [d release];
            [_items addObject:it];
            [it release];
        }
        CGColorSpaceRelease(rgb);

    }
    return self;
}
-(void)itemSelected:(long)selected
{
    if ([self.delegate conformsToProtocol:@protocol(SMFColorSelectionDelegate)]) 
    {
        
        NSArray *colorArray = [NSArray arrayWithObjects:
                               SMFFloat(red[selected]),
                               SMFFloat(green[selected]),
                               SMFFloat(blue[selected]),
                               SMFFloat(1.0),
                               nil];
        [[self delegate] colorSelected:colorArray forKey:[self key]];
    }
}
-(void)dealloc
{
    [colors release];
    colors=nil;
    delegate=nil;
    self.key=nil;
    [super dealloc];
}
@end
