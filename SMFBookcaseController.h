//
//  SMFBookcaseController.h
//  SMFramework
//
//  Created by Chris Jensen on 2/26/11.
//

#import <Backrow/Backrow.h>
@class SMFBookcaseController;

@protocol SMFBookcaseControllerDatasource
- (NSString *)headerTitleForBookcaseController:(SMFBookcaseController *)bookcaseController;
- (NSInteger)numberOfShelfsInBookcaseController:(SMFBookcaseController *)bookcaseController;
- (BRPhotoDataStoreProvider *)bookcaseController:(SMFBookcaseController *)bookcaseController datastoreProviderForShelfAtIndex:(NSInteger)index;
@optional
- (BRImage *)headerIconForBookcaseController:(SMFBookcaseController *)bookcaseController;
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

