//
//  BRGridController.h
//  SoftwareMenu
//
//  Created by Thomas Cool on 11/5/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//

#import <Backrow/Backrow.h>


@interface SMFGridController : BRController {
   // int                     padding[32];
    BRGridControl*          _gridControl;
    BRWaitSpinnerControl *  _spinner;
    BRCursorControl *       _cursorControl;
    BRScrollControl *       _scroller;
}
-(void)drawSelf;
- (void) setGrid;
@end
