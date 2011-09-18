//
//  SMFDropShadowControl.h
//  SMFramework
//
//  Created by Kevin Bradley on 9/13/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import "Backrow/AppleTV.h"


@interface SMFDropShadowControl : BRDropShadowControl {
		
	BOOL isAnimated;
	id sender;
	
}

@property (readwrite, assign) BOOL isAnimated;
@property (nonatomic, retain) id sender;

- (void)setZoomInPosition;
- (void)setZoomOutPosition;

- (void)updateSender;
- (id)getListFromMenuItem:(id)menuItem;
- (id)synthesizeMockItemFrom:(id)theSender withX:(float)xValue;
- (id)synthesizeMockItem;

@end
