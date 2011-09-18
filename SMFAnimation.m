//
//  SMFAnimation.m
//  SMFramework
//
//  Created by Kevin Bradley on 9/18/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import "SMFAnimation.h"

#define ZOOM_TO_BOUNDS CGRectMake(0, 0, 108, 108)
#define ZOOM_TO_POINT CGPointMake(591.5999755859375, 284.39999389648438)

/*
 
 This class kind of a lazy convience "work in progress", the animations are geared solely to the SMFDropShadowControl classes/subclasses
 
 you also need to account for - (void)setZoomInPosition when zooming in and out manually, to see an implementation of these animations take a look at SMFDropShadowControl in
 
 -(void)addToController:(BRController *)ctrl and - (void)removeFromParent
 
 this is far from elegant right now, but works quite nicely.
 
 */


@implementation SMFAnimation


+ (CAAnimationGroup *)zoomOutFadedToRect:(CGRect)outRect
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[SMFAnimation zoomOutToRect:outRect], [SMFAnimation fadeOutAnimation], nil]];
	outAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

+ (CAAnimationGroup *)zoomInFadedToRect:(CGRect)inRect
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[SMFAnimation zoomInToRect:inRect], [SMFAnimation fadeInAnimation], nil]];
	outAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

+ (CABasicAnimation *)fadeInAnimation
{
	CABasicAnimation *theAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
	theAnimation.toValue=[NSNumber numberWithFloat:1.0];
	return theAnimation;
}

+ (CABasicAnimation *)fadeOutAnimation
{
	CABasicAnimation *theAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
	theAnimation.toValue=[NSNumber numberWithFloat:0.0];
	return theAnimation;
}


+ (CABasicAnimation *)zoomOutToRect:(CGRect)outRect
{
	CABasicAnimation *zoomOutAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomOutAnimation.fromValue = [NSNumber numberWithInt:1.0];
	if (CGRectEqualToRect(outRect, CGRectZero))
	{
		zoomOutAnimation.toValue = [NSValue valueWithCGRect:ZOOM_TO_BOUNDS];
		
	} else {
		
		zoomOutAnimation.toValue = [NSValue valueWithCGRect:outRect];
		
	}
	
		//zoomOutAnimation.duration = 0.25f;
	return zoomOutAnimation;
}

+ (CABasicAnimation *)zoomInToRect:(CGRect)inRect
{
	CABasicAnimation *zoomInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	if (CGRectEqualToRect(inRect, CGRectZero))
	{
		zoomInAnimation.fromValue = [NSValue valueWithCGRect:ZOOM_TO_BOUNDS];
		
	} else {
		
		zoomInAnimation.fromValue = [NSValue valueWithCGRect:inRect];
	}
	
	zoomInAnimation.toValue = [NSNumber numberWithInt:1.0];
	return zoomInAnimation;
}


/*
 
 deprecated code left in for posterity / laziness (in case we ever decide to grapple with transforms, a refresher/reminder
 
 */

+ (CABasicAnimation *)zoomOutAnimation:(CATransform3D)zoomTransform //edits the transform directly, so this cant be properly paired with other animations - deprecated
{		
	
	CABasicAnimation *zoomOutAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
		//[zoomOutAnimation setDelegate:SMFAnimation];
	zoomOutAnimation.repeatCount = 0;
	zoomOutAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	zoomOutAnimation.toValue = [NSValue valueWithCATransform3D:zoomTransform];
	zoomOutAnimation.fillMode = kCAFillModeForwards;
	zoomOutAnimation.removedOnCompletion = NO;
	return zoomOutAnimation;
	
}


+ (CABasicAnimation *)zoomInAnimation:(CATransform3D)zoomTransform
{
	
	CABasicAnimation *zoomInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomInAnimation.fromValue = [NSValue valueWithCATransform3D:zoomTransform];
	zoomInAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	return zoomInAnimation;
	
}



@end
