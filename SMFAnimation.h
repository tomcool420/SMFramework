//
//  SMFAnimation.h
//  SMFramework
//
//  Created by Kevin Bradley on 9/18/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
@interface SMFAnimation : NSObject {

}


+ (CAAnimationGroup *)zoomOutFadedToRect:(CGRect)outRect;
+ (CAAnimationGroup *)zoomInFadedToRect:(CGRect)inRect;
+ (CABasicAnimation *)fadeInAnimation;
+ (CABasicAnimation *)fadeOutAnimation;
+ (CABasicAnimation *)zoomOutToRect:(CGRect)outRect;
+ (CABasicAnimation *)zoomInToRect:(CGRect)inRect;

	//deprecated
+ (CABasicAnimation *)zoomOutAnimation:(CATransform3D)zoomTransform;
+ (CABasicAnimation *)zoomInAnimation:(CATransform3D)zoomTransform;

@end
