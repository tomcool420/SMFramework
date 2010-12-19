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
@protocol SMFFolderBrowserDelegate
-(BOOL)hasActionForFile:(NSString *)path;
-(void)executeActionForFile:(NSString *)path;
@optional
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
