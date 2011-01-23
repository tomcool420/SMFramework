//
//  SMFListDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 1/21/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Backrow/Backrow.h>
@protocol SMFListDropShadowDatasource
- (long)popupItemCount;
- (id)popupItemForRow:(long)row;

@optional
- (float)popupHeightForRow:(long)row;	
- (BOOL)popupRowSelectable:(long)row;	
- (id)popupTitleForRow:(long)row;	
- (long)popupDefaultIndex;
@end
@protocol SMFListDropShadowDelegate
@optional
- (void)popupItemSelected:(long)row;
- (void)popup:(id)p itemSelected:(long)row;
@end



@interface SMFListDropShadowControl : BRDropShadowControl {
    NSObject<SMFListDropShadowDelegate>  * cDelegate;
    NSObject<SMFListDropShadowDatasource>* cDatasource;
    BRListControl *list;
}
/*
 *  Simply calls [list reload]
 */
-(void)reloadList;

/*
 *  Should return a CGRect that can be use for the frame. max 6 list rows 
 *  along with appropriate padding
 */
-(CGRect)rectForSize:(CGSize)s;
/*
 *  If the controller is not an SMFMediaMenuController (or subclass)
 *  and thus does not possess the showPopup method, the following method
 *  can be used to add it to a controller
 *
 *  To remove it: you can call: -(void)removeFromParent
 */
-(void)addToController:(BRController *)ctrl;
@property (retain) NSObject<SMFListDropShadowDelegate>* cDelegate;
@property (retain) NSObject<SMFListDropShadowDatasource>* cDatasource;
@property (retain) BRListControl *list;
@end
