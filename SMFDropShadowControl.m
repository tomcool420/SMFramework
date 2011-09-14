//
//  SMFDropShadowControl.m
//  SMFramework
//
//  Created by Kevin Bradley on 9/13/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import "SMFDropShadowControl.h"


@implementation SMFDropShadowControl

@synthesize isAnimated;

-(id)init
{
    self =[super init];
    if (self!=nil) {

        self.isAnimated = TRUE; //up to you, can be false by default if you dont like it

    }
    return self;
}


- (CAAnimationGroup *)zoomOutFadedAnimation:(CATransform3D)zoomTransform
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[self zoomOutAnimation:zoomTransform], [self fadeOutAnimation], nil]];
	outAnimation.duration = .25;
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

- (CABasicAnimation *)fadeOutAnimation
{
	CABasicAnimation *theAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
	theAnimation.duration=.25;
	theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
	theAnimation.toValue=[NSNumber numberWithFloat:0.0];
	return theAnimation;
}

- (CABasicAnimation *)zoomOutAnimation:(CATransform3D)zoomTransform
{		
	
	CABasicAnimation *zoomOutAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
		//[zoomOutAnimation setDelegate:self];
	zoomOutAnimation.beginTime = 0;
	zoomOutAnimation.repeatCount = 0;
	zoomOutAnimation.timeOffset = 1;
	zoomOutAnimation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	zoomOutAnimation.toValue = [NSValue valueWithCATransform3D:zoomTransform];
	zoomOutAnimation.duration = 0.25f;
	zoomOutAnimation.fillMode = kCAFillModeForwards;
	zoomOutAnimation.removedOnCompletion = NO;
	return zoomOutAnimation;
	
}

- (CABasicAnimation *)zoomInAnimation:(CATransform3D)zoomTransform
{
	
	CABasicAnimation *zoomInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomInAnimation.beginTime = 0;
	zoomInAnimation.fromValue = [NSValue valueWithCATransform3D:zoomTransform];
	zoomInAnimation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	zoomInAnimation.duration = 0.25f;
	return zoomInAnimation;
	
}


- (void)removeFromParent
{
	if (self.isAnimated == TRUE)
	{
		CATransform3D zoomTransform = CATransform3DMakeScale(0.1, 0.1, 1.0);
		CAAnimationGroup *zoomOutAnimation = [self zoomOutFadedAnimation:zoomTransform];
		[zoomOutAnimation setDelegate:self];
		[zoomOutAnimation setValue:@"removeFromParent" forKey:@"Name"];
		[self addAnimation:zoomOutAnimation forKey:@"removeFromParent"];
		
	} else {
		
		
		[super removeFromParent];
	}
	
}

-(void)addToController:(BRController *)ctrl
{
    CGRect f = CGRectMake(256.0,72.0,768.0,576.0);//(s.width*0.2, s.height*0.1, s.width*0.6, s.height*0.8);
    [self setFrame:f];
	
	if (self.isAnimated == TRUE)
	{
		CATransform3D zoomTransform = CATransform3DMakeScale(0.1, 0.1, 1.0);
		CABasicAnimation *zoomInAnimation = [self zoomInAnimation:zoomTransform];
		[zoomInAnimation setValue:@"zoomInAnimation" forKey:@"Name"];
		[zoomInAnimation setDelegate:self];
		[self addAnimation:zoomInAnimation forKey:@"zoomInAnimation"];
		
	}
	
    [ctrl addControl:self];
    [ctrl setFocusedControl:self];
		//[ctrl _setControlFocused:TRUE];
	[ctrl _setFocus:self];
}


- (void)animationDidStart:(CAAnimation *)anim
{
	
		//NSLog(@"animationDidStart: %@", anim);
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	
	NSString *animationName = [anim valueForKey:@"Name"];
	
	if ([animationName isEqualToString:@"removeFromParent"])
	{
		
		[super removeFromParent];
	}
	[self removeAnimationForKey:animationName];	
	
}



@end
