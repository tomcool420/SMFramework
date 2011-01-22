//
//  SMFListDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 1/21/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Backrow/Backrow.h>
@protocol SMFListDropShadowDatasource
- (float)popupHeightForRow:(long)row;	
- (BOOL)popupRowSelectable:(long)row;	
- (long)popupItemCount;
- (id)popupItemForRow:(long)row;
- (id)popupTitleForRow:(long)row;	
- (long)popupDefaultIndex;
@end
@protocol SMFListDropShadowDelegate
- (void)popupItemSelected:(long)row;
@end



@interface SMFListDropShadowControl : BRDropShadowControl {
    NSObject<SMFListDropShadowDelegate>  * cDelegate;
    NSObject<SMFListDropShadowDatasource>* cDatasource;
    BRListControl *list;
}
-(void)reloadList;
-(CGRect)rectForSize:(CGSize)s;
@property (retain) NSObject<SMFListDropShadowDelegate>* cDelegate;
@property (retain) NSObject<SMFListDropShadowDatasource>* cDatasource;
@end
