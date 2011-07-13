//
//  SMFMoviePreviewController.h
//  SMFramework
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//
#import <Foundation/Foundation.h>
#define NOSHELF
#import "SMFPhotoMethods.h"
#import "SMFThemeInfo.h"
#import "Backrow/AppleTV.h"
#import "SMFMoviePreviewDelegateDatasource.h"
@class BRControl,BRMediaShelfView;


/**
 *An intensely intricate but extremely flexible way of displaying data on screen.
 *Based from Apple's way of displaying previews for movies.
 *Used in both Plex (displaying Movies) and nitoTV displaying packages.
 *Requires the use of a datasource to layout the data and a delegate to receive the messages
 */

@interface SMFMoviePreviewController : BRController {
    BRMetadataTitleControl *_metadataTitleControl;
    BRTextControl       * _summaryControl;
    NSMutableArray             * _buttons;
    BRImageControl		*_previousArrowImageControl;
	BRImageControl		*_nextArrowImageControl;

    id _shelfControl;

    BRCoverArtPreviewControl *_previewControl;
    NSMutableDictionary        *_info;
    NSObject<SMFMoviePreviewControllerDatasource> *datasource;
    NSObject<SMFMoviePreviewControllerDelegate> *delegate;
    BOOL                _summaryToggled;
    BRDividerControl    *_div3;
    BRTextControl       *_alsoWatched;
    BOOL				_previousArrowTurnedOn;
	BOOL				_nextArrowTurnedOn;
    NSMutableArray      *_hideList;
    BRDataStoreProvider *_provider;
    BOOL                _usingShelfView;
}
///---
///@name properties
///---
/**
 *the datasource object
 *@note needs to conform to SMFMoviePreviewControllerDatasource
 */
@property (retain)NSObject<SMFMoviePreviewControllerDatasource>*datasource;
/**
 *the delegate object
 *@note needs to conform to SMFMoviePreviewControllerDelegate
 */
@property (retain)NSObject<SMFMoviePreviewControllerDelegate>*delegate;

///---
///@name deprecated properties
///---
/**
 *The shelf object. it is readonly but can be used to get the position 
 *of the item selected
 *@bug this property is deprecated, use shelfControl instead
 */

@property (readonly)id shelfControl;


/**
 *The buttons displayed on screen
 *@note same as buttons
 *@bug deprecated use buttons instead
 */
@property (readonly)NSMutableArray *_buttons;

+(NSDictionary *)columnHeaderAttributes;
+(NSDictionary *)columnLabelAttributes;
///---
///@name Example Delegate Methods
///---

-(void)reload;
-(void)reloadShelf;
-(void)toggleLongSummary;
-(void)switchPreviousArrowOn;
-(void)switchPreviousArrowOff;
-(void)switchNextArrowOn;
-(void)switchNextArrowOff;
-(id)_shelfControl;
@end
