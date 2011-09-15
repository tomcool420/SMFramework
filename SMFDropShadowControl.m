//
//  SMFDropShadowControl.m
//  SMFramework
//
//  Created by Kevin Bradley on 9/13/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import "SMFDropShadowControl.h"
#import "SMFDefines.h"


@implementation SMFDropShadowControl

@synthesize isAnimated;

-(id)init
{
    self =[super init];
    if (self!=nil) {

        self.isAnimated = FALSE; //up to you, can be false by default if you dont like it

    }
    return self;
}

- (CABasicAnimation *)zoomToBounds:(CGRect)theBounds //still cant get this to work properly :(
{
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"bounds"];
		//anim.delegate = self; //to get the animationDidStop:finished: message
		//anim.duration = .25;
	anim.fromValue = [NSValue valueWithCGRect:CGRectMake(256.0,72.0,768.0,576.0)]; //
	anim.toValue = [NSValue valueWithCGRect:theBounds];
	return anim;
}


- (CAAnimationGroup *)zoomOutFadedAnimation:(CATransform3D)zoomTransform
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[self zoomOutAnimation], [self fadeOutAnimation], nil]];
	outAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

- (CABasicAnimation *)fadeOutAnimation
{
	CABasicAnimation *theAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
		//theAnimation.duration=.25;
	theAnimation.fromValue=[NSNumber numberWithFloat:1.0];
	theAnimation.toValue=[NSNumber numberWithFloat:0.0];
	return theAnimation;
}

- (CABasicAnimation *)zoomOutAnimation:(CATransform3D)zoomTransform //edits the transform directly, so this cant be properly paired with other animations
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

- (CABasicAnimation *)zoomOutAnimation
{
	CABasicAnimation *zoomOutAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomOutAnimation.beginTime = 0;
	zoomOutAnimation.fromValue = [NSNumber numberWithInt:1.0];
	zoomOutAnimation.toValue = [NSNumber numberWithInt:0.1];
		//zoomOutAnimation.duration = 0.25f;
	return zoomOutAnimation;
}

- (CABasicAnimation *)zoomInAnimation
{
	CABasicAnimation *zoomInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomInAnimation.beginTime = 0;
	zoomInAnimation.fromValue = [NSNumber numberWithInt:0.1];
	zoomInAnimation.toValue = [NSNumber numberWithInt:1.0];
	zoomInAnimation.duration = 0.25f;
	return zoomInAnimation;
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

-(BOOL)avoidsCursor //of course it was easier than i was making it!!
{
	return TRUE;
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
		CABasicAnimation *zoomInAnimation = [self zoomInAnimation];
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
