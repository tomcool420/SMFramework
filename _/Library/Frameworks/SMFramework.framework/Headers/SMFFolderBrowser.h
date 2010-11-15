//
//  SMFolderBrowser.h
//  SoftwareMenuFramework
//
//  Created by Thomas on 4/19/09.
//  Copyright 2009 tomcool.org. All rights reserved.
//

#import "SMFMediaMenuController.h"

@interface SMFFolderBrowser : SMFMediaMenuController 
	{

		NSString *	path;
		NSMutableArray *	_paths;
		NSFileManager   *	_man;
        NSMutableArray *    _files;
        NSMutableArray *    _folders;
        BOOL separate;
        BOOL showHidden;
        BOOL showOnlyFolders;
        NSString        *plistPath;
        NSString        *plistKey;
        id              delegate;
        NSString        *fpath;
		
	}

+ (void)setString:(NSString *)inputString forKey:(NSString *)theKey inDomain:(NSString *)theDomain;
+ (NSString *)stringForKey:(NSString *)theKey inDomain:(NSString *)theDomain;
-(void)setPath:(NSString *)thePath;
-(void)reloadFiles;
-(id)initWithPath:(NSString *)thePath;
@property (assign) BOOL separate;
@property (assign) BOOL showHidden;
@property (assign) BOOL showOnlyFolders;
@property (retain) NSString *plistKey;
@property (retain) NSString *plistPath;
@property (retain) id delegate;
@property (retain) NSString *fpath;
@end
