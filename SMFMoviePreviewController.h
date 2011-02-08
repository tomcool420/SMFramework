//
//  SMFMoviePreviewController.h
//  SMFramework
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFPhotoMethods.h"
#import "SMFThemeInfo.h"
#import <Backrow/Backrow.h>
@class BRControl;
@protocol SMFMoviePreviewControllerDatasource
-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)summary;
-(NSString *)posterPath;
-(NSArray  *)headers;
-(NSArray  *)columns;
-(NSString *)rating;
-(BRPhotoDataStoreProvider *)providerForShelf;
@end
@class SMFMoviePreviewController;
@protocol SMFMoviePreviewControllerDelegate
-(void)controller:(SMFMoviePreviewController *)c selectedControl:(BRControl *)ctrl;
@end

    

@interface SMFMoviePreviewController : BRController<SMFMoviePreviewControllerDatasource> {
    BRTextControl       * _titleControl;
    BRTextControl       * _subtitleControl;
    BRTextControl       * _summaryControl;
    BRImageControl      * _rating;
    BRButtonControl     * _previewButton;
    BRButtonControl     * _playButton;
    BRButtonControl     * _queueButton;
    BRButtonControl     * _moreButton;
    BRMediaShelfControl *_shelfControl;
    BRCoverArtPreviewControl *_previewControl;
    NSMutableDictionary        *_info;
    NSObject<SMFMoviePreviewControllerDatasource> *datasource;
    NSObject<SMFMoviePreviewControllerDelegate> *delegate;
}
@property (retain)NSObject<SMFMoviePreviewControllerDatasource>*datasource;
@property (retain)NSObject<SMFMoviePreviewControllerDelegate>*delegate;
-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)summary;
-(NSString *)posterPath;
-(NSArray  *)headers;
-(NSArray  *)columns;
-(NSString *)rating;
-(BRPhotoDataStoreProvider *)providerForShelf;
@end
