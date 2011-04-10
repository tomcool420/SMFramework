//
//  SMFBookcaseController.h
//  SMFramework
//
//  Created by Chris Jensen on 2/26/11.
//

#import <Backrow/Backrow.h>
@class SMFBookcaseController;
/**
 *Datasource protocol for the SMFBookcaseController
 */
@protocol SMFBookcaseControllerDatasource
/**
 *@param bookcaseController the bookcase asking for the header
 *@return a string containing the title for the controller
 */
- (NSString *)headerTitleForBookcaseController:(SMFBookcaseController *)bookcaseController;
/**
 *@param bookcaseController the bookcase
 *@return the number of shelves on your bookcase
 */
- (NSInteger)numberOfShelfsInBookcaseController:(SMFBookcaseController *)bookcaseController;
/**
 *@param bookcaseController the bookcase
 *@param index the index of the shelf for which to return a datastore provider
 *@return the datastoreprovider with the posters
 *
 */
- (BRPhotoDataStoreProvider *)bookcaseController:(SMFBookcaseController *)bookcaseController datastoreProviderForShelfAtIndex:(NSInteger)index;
@optional
/**
 *@param bookcaseController the bookcase
 *@return an image to be displayed in the top right corner
 */
- (BRImage *)headerIconForBookcaseController:(SMFBookcaseController *)bookcaseController;
/**
 *@param bookcaseController the bookcase
 *@param index the index of the shelf for which to return a title
 *@return the title for the shelf at index: index
 */
- (NSString *)bookcaseController:(SMFBookcaseController *)bookcaseController titleForShelfAtIndex:(NSInteger)index;
@end

@protocol SMFBookcaseControllerDelegate
-(BOOL)bookcaseController:(SMFBookcaseController *)bookcaseController allowSelectionForShelf:(BRMediaShelfControl *)shelfControl atIndex:(NSInteger)index;
@optional
-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionWillOccurInShelf:(BRMediaShelfControl *)shelfControl atIndex:(NSInteger)index;
-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionDidOccurInShelf:(BRMediaShelfControl *)shelfControl atIndex:(NSInteger)index;
@end

@interface SMFBookcaseController : BRController {
	NSObject<SMFBookcaseControllerDatasource> *datasource;
    NSObject<SMFBookcaseControllerDelegate> *delegate;
	
@private
	//datasource variables
	NSInteger numberOfShelfControls;
	NSMutableArray *_shelfTitles;
	
	//ui controls
	NSMutableArray *_shelfControls;
	BRPanelControl *_panelControl;
}
@property (retain) NSObject <SMFBookcaseControllerDatasource> *datasource;
@property (retain) NSObject <SMFBookcaseControllerDelegate> *delegate;
- (void)rebuildBookcase;
- (void)refreshShelves;
- (void)refreshShelfAtIndex:(NSInteger)index;

@end

