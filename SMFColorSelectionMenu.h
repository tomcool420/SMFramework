//
//  SMFColorSelectionMenu.h
//  SMFramework
//
//  Created by Thomas Cool on 11/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFMediaMenuController.h"
#import <UIKit/UIColor.h>

@protocol SMFColorSelectionDelegate
-(void)colorSelected:(NSArray *)rgba forKey:(NSString *)key;
@end

@interface SMFColorSelectionMenu : SMFMediaMenuController {
    id<SMFColorSelectionDelegate>delegate;
    NSString *key;
    NSArray *colors;
}
+(SMFColorSelectionMenu *)colorMenuForKey:(NSString *)k andDelegate:(id<SMFColorSelectionDelegate>)del;
@property (assign) id<SMFColorSelectionDelegate> delegate;
@property (retain) NSString * key;
@end
