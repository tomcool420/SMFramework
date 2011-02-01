//
//  SMFMediaMenuController.h
//  SMFramework
//
//  Created by Thomas Cool on 10/22/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
#import <Backrow/Backrow.h>
#import <Foundation/Foundation.h>
#import "SMFDefines.h"
@interface SMFMediaMenuController : BRMediaMenuController <BRMenuListItemProvider> {
    NSMutableArray *_items;
    NSMutableArray *_options;
    BRDropShadowControl * popupControl;
}
/*
 *  A PopupControl
 */
@property (retain) BRDropShadowControl * popupControl;

/*
 *  If using an SMFMediaMenuController, popups can easily be hidden or shown using 
 *  the following two methods
 */
-(void)showPopup;
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

/*
 *  Something that is called everytime wasExhumed, [list reload], activated is called
 */
-(id)everyLoad;

/*
 *  A method used to check which row the list is on
 */
-(int)getSelection;

/*
 *  A method used to change the list selection
 */

- (void)setSelection:(int)sel;
/*
 *  Action Called Every Time someone Presses on Left Arrow
 */
-(void)leftActionForRow:(long)row;

/*
 *  Action Called Every Time someone Presses on Right Arrow
 */
-(void)rightActionForRow:(long)row;

/*
 *  Action Called Every Time someone Presses on play pause button on new remote
 */
-(void)playPauseActionForRow:(long)row;

@end
