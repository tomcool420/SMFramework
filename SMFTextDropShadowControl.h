//
//  SMFTextDropShadowControl.h
//  SMFramework
//
//  Created by Thomas Cool on 2/27/11.
//  Copyright 2011 Thomas Cool. All rights reserved.
//

#import <Backrow/Backrow.h>


@interface SMFTextDropShadowControl : BRDropShadowControl {
    NSMutableString *_text;
    BRScrollingTextBoxControl *_scrolling;
}
@property (readwrite,retain)NSMutableString *text;
-(void)appendToText:(NSString *)t;
@end
