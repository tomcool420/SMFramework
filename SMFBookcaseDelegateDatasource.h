//
//  SMFBookcaseDelegateDatasource.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>

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
#ifndef NOSHELF
-(BOOL)bookcaseController:(SMFBookcaseController *)bookcaseController allowSelectionForShelf:(id)shelfControl atIndex:(NSInteger)index;
@optional
-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionWillOccurInShelf:(id)shelfControl atIndex:(NSInteger)index;
-(void)bookcaseController:(SMFBookcaseController *)bookcaseController selectionDidOccurInShelf:(id)shelfControl atIndex:(NSInteger)index;
#endif
@end