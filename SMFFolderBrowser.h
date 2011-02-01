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
@protocol SMFFolderBrowserDelegate
/*
 *  Checks to see if the delegate can handle this file
 */
-(BOOL)hasActionForFile:(NSString *)path;

@optional
/*
 *  Standard default action execution
 */
-(void)browser:(SMFFolderBrowser *)b executeActionForFile:(NSString *)path;
/*
 *  Pressing the right arrow
 */
-(void)browser:(SMFFolderBrowser *)b executeRightActionForFile:(NSString *)path;
/*
 *  Pressing the left arrow
 */
-(void)browser:(SMFFolderBrowser *)b executeLeftActionForFile:(NSString *)path;
/*
 *  Pressing the select button ... disabled for now
 */
-(void)browser:(SMFFolderBrowser *)b executeSelectActionForFile:(NSString *)path;
/*
 *  Pressing the play pause button on the new remote
 */
-(void)browser:(SMFFolderBrowser *)b executePlayPauseActionForFile:(NSString *)path;

/*
 *  Deprecated Methods
 */
-(void)executeActionForFile:(NSString *)path;
-(void)executeRightActionForFile:(NSString *)path;
-(void)executeLeftActionForFile:(NSString *)path;
-(void)executeSelectActionForFile:(NSString *)path;
-(void)executePlayPauseActionForFile:(NSString *)path;


@end

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
-(void)setPath:(NSString *)thePath;
-(void)reloadFiles;
-(id)initWithPath:(NSString *)thePath;
@property (assign) BOOL separate;
@property (assign) BOOL showHidden;
@property (assign) BOOL showOnlyFolders;


@property (retain) NSObject<SMFFolderBrowserDelegate>* delegate;
@property (retain) NSString *fpath;

@end
