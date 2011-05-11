//
//  SMFDictionaryObjectEditor.h
//  SMFramework
//
//  Created by Thomas Cool on 5/1/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Backrow/BackRow.h>
#import "SMFMediaMenuController.h"


@interface SMFDictionaryObjectEditor : SMFMediaMenuController {
    NSObject *delegate;
    NSString *key;
    NSObject *obj;
    int lastItemSelected;
        NSString *initialKey;
}
@property (retain)NSObject *obj;
@property (retain)NSString *key;
@property (assign)NSObject *delegate;
-(id)initWithKey:(NSString *)k withObject:(NSObject *)obj withDelegate:(NSObject *)del;
@end
