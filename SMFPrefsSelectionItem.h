//
//  SMFPrefsSelectionItem.h
//  SMFramework
//
//  Created by Thomas Cool on 5/9/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SMFPrefsSelectionItem : NSObject {
    NSObject *object;
    NSString *title;
    
}
@property (readwrite, retain) NSObject *object;
@property (readwrite, retain) NSString *title;
-(NSString *)rightText;
-(NSString *)titleText;
@end
