//
//  SMFBookcaseController.h
//  SMFramework
//
//  Created by Chris Jensen on 2/26/11.
//
//#define NOSHELF
#import "Backrow/AppleTV.h"
#import "SMFBookcaseDelegateDatasource.h"

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
    NSMutableArray *_shelfAdapters;
}
@property (retain) NSObject <SMFBookcaseControllerDatasource> *datasource;
@property (retain) NSObject <SMFBookcaseControllerDelegate> *delegate;
- (void)rebuildBookcase;
- (void)refreshShelves;
- (void)refreshShelfAtIndex:(NSInteger)index;

@end

