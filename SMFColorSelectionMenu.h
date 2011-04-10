//
//  SMFColorSelectionMenu.h
//  SMFramework
//
//  Created by Thomas Cool on 11/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SMFMediaMenuController.h"
#import <UIKit/UIColor.h>
/**
 *  Delegate for the SMFColorSelectionMenu
 */
@protocol SMFColorSelectionDelegate
/**
 *  Only method in the delegate
 *@param rgba NSArray with 4 NSNumbers between 0 and 1 correspoding to red,green,blue,alpha
 *@param key the key passed in the initialization method
 */
@required
-(void)colorSelected:(NSArray *)rgba forKey:(NSString *)key;
@end
/**
 *A subclass of SMFMediaMenuController used to easily select Colors
 *only requires a delegate :D
 */
@interface SMFColorSelectionMenu : SMFMediaMenuController {
    NSObject<SMFColorSelectionDelegate> *delegate;
    NSString *key;
    NSArray *colors;
}
/**
 *The delegate to which the selection is passed
 *has to conform to the SMFColorSelectionDelegate Protocol
 */
@property (assign) NSObject<SMFColorSelectionDelegate> *delegate;
/**
 *The key that will be passed to the delegate (can be used for book keeping) 
 */
@property (retain) NSString * key;
///---
///@name Instanciating an object
///---
/**
 * Create a SMFColorSelectionMenu with a key and a delegate
 *@param k the key that will be passed to the delegate
 *@param del the instance of SMFColorSelectionDelegate to which the color will be passed 
 *  (see delegate)
 *@return autorelease instance of SMFColorSelectionMenu
 *@important: this is the recommended way to create a instance of this class
 */
+(SMFColorSelectionMenu *)colorMenuForKey:(NSString *)k andDelegate:(NSObject<SMFColorSelectionDelegate>*)del;
@end
