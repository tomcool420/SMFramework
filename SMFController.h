//
//  SMController.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 11/30/09.
//  Copyright 2009 Thomas Cool. All rights reserved.
//
#import <BackRow/BackRow.h>
@interface BRController (Compat)

-(CGRect)frame;

@end



@interface SMFController : BRController {
    int padding[128];
    int m_screen_saver_timeout;
    NSString *                  _title;
    BRHeaderControl *           _headerControl;
    BRWaitSpinnerControl *      _spinner;
    BRImage *                   _image;
    BRImageControl *            _imageControl;
}
/*
 *  Used to disable the screen 
 */
- (void) disableScreenSaver;
- (void) enableScreenSaver;
/*
 *  getMasterFrame returns the Controller frame actually used to add the controls to.
 */
- (CGRect)getMasterFrame;
/*
 *  The following two are simply to adjust the screen size for 1080i as TV
 *  seems to return strange values for that size. They should be used at same time
 *  as getMasterFrame
 */
- (BOOL)is1080i;
- (CGSize)sizeFor1080i;
/*
 *Method to overwrite when subclassing. THis is where all the drawing calls are made
 */
- (void)drawSelf;
@end
@interface SMFController (layout)
/*
 *  The Following three methods provide examples of layouts and how to set them up
 *  You would simply call them from the draw self in the following way:
 *  [self layoutSpinner]
 */
-(void)layoutSpinner;
-(void)layoutHeader;
-(void)layoutImage;
@end

