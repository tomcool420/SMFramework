//
//  SMFMoviePreviewDelegateAndDatasourceExample.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../SMFMoviePreviewDelegateDatasource.h"
#import "../BackRow/AppleTV.h"
@interface SMFMoviePreviewDelegateAndDatasourceExample  : NSObject<SMFMoviePreviewControllerDelegate,SMFMoviePreviewControllerDatasource>
-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)summary;
-(NSString *)posterPath;
-(NSArray  *)headers;
-(NSArray  *)columns;
-(NSString *)rating;
-(BRPhotoDataStoreProvider *)providerForShelf;
@end
