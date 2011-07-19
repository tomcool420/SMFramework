//
//  SMFDictionaryEditor.h
//  SMFramework
//
//  Created by Thomas Cool on 5/1/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMFMediaMenuController.h"
@protocol SMFDictionaryEditorDelegate

-(void)setObject:(NSObject *)obj forKey:(NSString *)key;
-(BOOL)deleteObjectForKey:(NSString *)key;

@end

@interface SMFDictionaryEditor : SMFMediaMenuController {
    NSMutableDictionary *_d;
    NSArray *_keys;
    NSObject<SMFDictionaryEditorDelegate> *delegate;
    NSObject *_k;

}
@property (assign)NSObject<SMFDictionaryEditorDelegate> *delegate;
@property (retain)NSObject *key;
-(id)initWithDictionary:(NSDictionary *)d;
-(id)initWithMutableDictionary:(NSMutableDictionary *)d inplace:(BOOL)inpl;
-(void)setObject:(NSObject *)obj forKey:(NSString *)k;
-(void)deleteObjectForKey:(NSString *)k;
@end
