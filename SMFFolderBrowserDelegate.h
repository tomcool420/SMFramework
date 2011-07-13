//
//  SMFFolderBrowserDelegate.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>
@class SMFFolderBrowser;
/**
 *Delegate for SMFFolderBrowser
 *
 *Only has one required method: hasActionForFile:
 *All other methods are checked before being called as to avoid exceptions
 */
@protocol SMFFolderBrowserDelegate

/**
 *  Checks to see if the delegate can handle this file
 */
-(BOOL)hasActionForFile:(NSString *)path;

@optional
/**
 *Standard default action execution
 *if hasActionForFile: returns `YES`, you should at least implement this method
 *@param browser browser calling the delegate
 *  can be used to push controllers: `[[browser stack]pushController:newController]`
 *@param path path to the file called
 */
-(void)browser:(SMFFolderBrowser *)browser executeActionForFile:(NSString *)path;

/**
 *Action called when pressing the right arrow on the remote
 *@param browser browser calling the delegate
 *  can be used to push controllers: `[[browser stack]pushController:newController]`
 *@param path path to the file called
 *@see browser:executeActionForFile:
 */
-(void)browser:(SMFFolderBrowser *)browser executeRightActionForFile:(NSString *)path;

/**
 *Action called when pressing the left arrow on the remote
 *@param browser browser calling the delegate
 *  can be used to push controllers: `[[browser stack]pushController:newController]`
 *@param path path to the file called
 *@see browser:executeActionForFile:
 */
-(void)browser:(SMFFolderBrowser *)browser executeLeftActionForFile:(NSString *)path;

/**
 *Action called when pressing the select button on the remote (center button)
 *@bug Warning: Not implemented yet, use browser:executeActionForFile: instead
 *@param browser browser calling the delegate
 *  can be used to push controllers: `[[browser stack]pushController:newController]`
 *@param path path to the file called
 *@see browser:executeActionForFile:
 */
-(void)browser:(SMFFolderBrowser *)browser executeSelectActionForFile:(NSString *)path;

/**
 *Action called when pressing playpause on the NEW remotes
 *if hasActionForFile: returns `YES`, you should at least implement this method
 *@param browser browser calling the delegate
 *  can be used to push controllers: `[[browser stack]pushController:newController]`
 *@param path path to the file called
 *@see browser:executeActionForFile:
 */
-(void)browser:(SMFFolderBrowser *)browser executePlayPauseActionForFile:(NSString *)path;

///---
///@name deprecated
///---

-(void)executeActionForFile:(NSString *)path;
-(void)executeRightActionForFile:(NSString *)path;
-(void)executeLeftActionForFile:(NSString *)path;
-(void)executeSelectActionForFile:(NSString *)path;
-(void)executePlayPauseActionForFile:(NSString *)path;


@end