//
//  SMFBookcaseDelegateAndDatasourceExample.m
//  SMFramework
//
//  Created by Chris Jensen on 2/26/11.
//

#import "SMFBookcaseDelegateAndDatasourceExample.h"
#import "../SMFramework.h"
#import "../BRMediaShelfView_SMF.h"
#define DEFAULT_IMAGES_PATH		@"/System/Library/PrivateFrameworks/AppleTV.framework/DefaultFlowerPhotos/"

//storeRentalPlaceholderImage is part of the AppleTV headers, so it will be available at runtime
@interface BRThemeInfo (PlexExtentions)
- (id)storeRentalPlaceholderImage;
@end

@implementation SMFBookcaseDelegateAndDatasourceExample

#pragma mark -
#pragma mark SMFBookcaseControllerDatasource Methods
- (NSString *)headerTitleForBookcaseController:(SMFBookcaseController *)bookcaseController {
	return @"Controller Title";
}

- (NSInteger)numberOfShelfsInBookcaseController:(SMFBookcaseController *)bookcaseController {
	return 4;
}

- (BRPhotoDataStoreProvider *)bookcaseController:(SMFBookcaseController *)bookcaseController datastoreProviderForShelfAtIndex:(NSInteger)index {
	NSSet *_set = [NSSet setWithObject:[BRMediaType photo]];
    NSPredicate *_pred = [NSPredicate predicateWithFormat:@"mediaType == %@",[BRMediaType photo]];
    BRDataStore *store = [[BRDataStore alloc] initWithEntityName:@"Hello" predicate:_pred mediaTypes:_set];
	
    NSArray *assets = [SMFPhotoMethods mediaAssetsForPath:DEFAULT_IMAGES_PATH];
    for (id a in assets) {
        [store addObject:a];
    }
    
    id tcControlFactory = [BRPosterControlFactory factory];
	[tcControlFactory setDefaultImage:[[BRThemeInfo sharedTheme] storeRentalPlaceholderImage]];
    id provider = [BRPhotoDataStoreProvider providerWithDataStore:store controlFactory:tcControlFactory];
    [store release];
    return provider; 
}

//optional
- (BRImage *)headerIconForBookcaseController:(SMFBookcaseController *)bookcaseController {
	return nil; //should be an image roughly 120 wide x 60 high

}

- (NSString *)bookcaseController:(SMFBookcaseController *)bookcaseController titleForShelfAtIndex:(NSInteger)index {
	NSString *title=@"";
	switch (index) {
		case 0:
			title = @"selection not allowed";
			break;
		case 1:
			title = @"refresh top shelf";
			break;
		case 2:
			title = @"refresh all shelves";
			break;
		case 3:
			title = @"rebuild entire bookcase";
			break;
		default:
			break;
	}
	return title;
}


#pragma mark -
#pragma mark SMFBookcaseControllerDelegate Methods

-(BOOL)bookcaseController:(SMFBookcaseController *)bookcaseController allowSelectionForShelf:(BRMediaShelfView *)shelfControl atIndex:(NSInteger)index {
	BOOL allow = YES;
	if (index == 0) {
		allow = NO; //no selections in the topmost shelf
	}
	return allow;
}
//optional
-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionWillOccurInShelf:(BRMediaShelfView *)shelfControl atIndex:(NSInteger)index {
	//will only get executed if the selection was allowed
	NSInteger indexOfItemSelected = [shelfControl focusedIndex];
	
	NSLog(@"selection for bookcase: [%@] in shelf [%@] at index [%d] at item [%d] is about to occur", bookcaseController, shelfControl, index, indexOfItemSelected);
}

-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionDidOccurInShelf:(BRMediaShelfView *)shelfControl atIndex:(NSInteger)index {
	//will only get executed if the selection was allowed
	
	NSInteger indexOfItemSelected = [shelfControl focusedIndex];
	
	NSLog(@"selection for bookcase: [%@] in shelf [%@] at index [%d] at item [%d] did occur", bookcaseController, shelfControl, index, indexOfItemSelected);
	
	switch (index) {
		case 1:
			[bookcaseController refreshShelfAtIndex:0];
			break;
		case 2:
			[bookcaseController refreshShelves];
			break;
		case 3:
			[bookcaseController rebuildBookcase];
			break;
		default:
			//do nothing
			break;
	}
}

@end
