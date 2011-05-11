//
//  SMFMediaMenuController.h
//  SMFramework
//
//  Created by Thomas Cool on 10/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <BackRow/BackRow.h>
#import <Foundation/Foundation.h>
#import "SMFDefines.h"
/**
 *Default Menu Controller. what should be subclassed to create simple menu. Examples are provided in the .m file
 *
 *
 */
@interface SMFMediaMenuController : BRMediaMenuController <BRMenuListItemProvider> {
    NSMutableArray *_items;
    NSMutableArray *_options;
    BRDropShadowControl * popupControl;
}
/**
 * a instance of BRDropShadowControl
 */
@property (retain) BRDropShadowControl * popupControl;

/**
 *Method used to show the popupControl
 */
-(void)showPopup;
/**
 *Method used to hide the popupControl
 */
-(void)hidePopup;


/*
 *  Datasource Methods
 */
//-(float)heightForRow:(long)row;
//-(BOOL)rowSelectable:(long)row;
//-(long)itemCount;
//-(id)itemForRow:(long)row;
//-(id)titleForRow:(long)row;

/*
 *  Deprecated method that should not be used
 */
-(long)rowForTitle:(id)title;

/**
 *  Something that is called everytime wasExhumed, reload or controlWasActivated is.
 */
-(void)everyLoad;

/**
 *A method used to check which row the list is on
 *@return index of item selected
 */
-(int)getSelection;

/**
 *  A method used to change the list selection
 *@param sel index of item to select
 */

- (void)setSelection:(int)sel;
/**
 *  Action Called Every Time someone Presses on Left Arrow
 *@param row index of the row selected when the left arrow was pressed
 *@note this method should never be called manually. instead it should be overwritten in 
 *  subclasses
 */
-(void)leftActionForRow:(long)row;

/**
 *  Action Called Every Time someone Presses on Right Arrow
 *@param row index of the row selected when the right arrow was pressed
 *@note this method should never be called manually. instead it should be overwritten in 
 *  subclasses
 */
-(void)rightActionForRow:(long)row;

/**
 *  Action Called Every Time someone Presses on Play Pause (silver remote)
 *@param row index of the row selected when the play-pause buttom was pressed
 *@note this method should never be called manually. instead it should be overwritten in 
 *  subclasses
 */
-(void)playPauseActionForRow:(long)row;

@end
