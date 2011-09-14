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
	
}

@property (readwrite, assign) BOOL isAnimated;
@end
