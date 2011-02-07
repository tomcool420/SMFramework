//
//  SMFMoviePreviewController.h
//  Slideshow
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <SMFramework/SMFramework.h>
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
}
@property (retain)NSObject<SMFMoviePreviewControllerDatasource>*datasource;
-(NSString *)title;
-(NSString *)subtitle;
-(NSString *)summary;
-(NSString *)posterPath;
-(NSArray  *)headers;
-(NSArray  *)columns;
-(NSString *)rating;
-(BRPhotoDataStoreProvider *)providerForShelf;
@end
