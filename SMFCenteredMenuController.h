//
//  SMFCenteredMediaMenuController.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/25/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "SMFMediaMenuController.h"
#import "SMFDefines.h"
@class SMFMediaMenuController;
@interface SMFCenteredMenuController : BRMenuController {
	int padding[128];
	NSMutableArray *	_items;
	NSMutableArray *	_options;
}
-(float)heightForRow:(long)row;
-(BOOL)rowSelectable:(long)row;
-(long)itemCount;
-(id)itemForRow:(long)row;
-(long)rowForTitle:(id)title;
-(id)titleForRow:(long)row;
-(int)getSelection;
- (void)setSelection:(int)sel;
-(id)everyLoad;
/*
 *  Action Called Every Time someone Presses on Left Arrow
 */
-(void)leftActionForRow:(long)row;

/*
 *  Action Called Every Time someone Presses on Right Arrow
 */
-(void)rightActionForRow:(long)row;
    

@end
