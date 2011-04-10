//
//  SMFolderBrowser.h
//  SoftwareMenuFramework
//
//  Created by Thomas on 4/19/09.
//  Copyright 2009 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import "SMFMediaMenuController.h"
#import "SMFPreferences.h"
#import "SMFPhotoMethods.h"
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

/**
 *  SMFFolderBrowser is a subclass of SMFMediaMenuController that enables easily browsing through the file system
 *
 *  It uses a delegate to make it easily extensible. This Delegate needs to conform to SMFFolderBrowserDelegate protocol
 *
 */
@interface SMFFolderBrowser : SMFMediaMenuController 
	{

		NSString *                          path;
		NSMutableArray *                    _paths;
		NSFileManager   *                   _man;
        NSMutableArray *                    _files;
        NSMutableArray *                    _folders;
        BOOL                                separate;
        BOOL                                showHidden;
        BOOL                                showOnlyFolders;

        NSObject<SMFFolderBrowserDelegate>* delegate;
        NSString        *                   fpath;

		
	}

+ (void)setString:(NSString *)inputString forKey:(NSString *)theKey inDomain:(NSString *)theDomain;
+ (NSString *)stringForKey:(NSString *)theKey inDomain:(NSString *)theDomain;

/**
 *set the path of a folder to browse
 *If the path is `nil`, does not exist or is not a folder, the browser wil be empty but it will not crash
 *@param thePath Path to browse. (example: `@"/private/var/mobile"`)
 *
 */
-(void)setPath:(NSString *)thePath;
/**
 *Reloads the folder in case the files have changed
 */

-(void)reloadFiles;

/**
 *Create a new instance with a defined path
 *
 *use this method instead of simply init
 *
 *@param thePath Path to browse. 
 *  @see setPath:
 */

-(id)initWithPath:(NSString *)thePath;
/**
 *Defines if the folders are seperated from the files
 */

@property (assign) BOOL separate;
/**
 *Show hidden files (starting with .)
 */
@property (assign) BOOL showHidden;
/**
 *Ignore files and only show folders
 */
@property (assign) BOOL showOnlyFolders;

/**
 *The delegate handling all the commands
 */
@property (retain) NSObject<SMFFolderBrowserDelegate>* delegate;
/**
 *The path that is currently browsed
 */
@property (retain) NSString *fpath;

@end
