//
//  SMFDropShadowControl.m
//  SMFramework
//
//  Created by Kevin Bradley on 9/13/11.
//  Copyright 2011 nito, LLC. All rights reserved.
//

#import "SMFDropShadowControl.h"
#import "SMFDefines.h"
#import "SMFMockMenuItem.h"

#define ZOOM_TO_BOUNDS CGRectMake(0, 0, 108, 108)
#define ZOOM_TO_POINT CGPointMake(591.5999755859375, 284.39999389648438)

/*
 
 if you are sending from a BRMenuItem there is a proper way to get the current menu item selection
 
 id selectedObject = [[self list] selectedObject];
 
 (keeping in mind this is from your controller you are adding a pop over to)
 
 you also need to set isAnimation to TRUE before adding the controller.
 
 i.e.
 
 SMFListDropShadowControl *c = [[SMFListDropShadowControl alloc]init];
 
 [c setCDelegate:me]; (me being the controller attached to)
 [c setSender:sender];
 [c setCDatasource:me];
 [c setIsAnimated:TRUE];
 [c addToController:me];
 
 
 note: there are a lot of repeat functions between here and SMFListDropShadowControl, hopefully at some point that can become a subclass of this as well
 and that code can be pruned out.
 
 
 this class should NEVER be called directly, its sole purpose is for all other SMFDropShadow subclasses to easily subclass and retain the animation goodness.
 
 */

@implementation SMFDropShadowControl

@synthesize isAnimated, sender;

-(id)init
{
    self =[super init];
    if (self!=nil) {

        self.isAnimated = FALSE; //up to you, can be false by default if you dont like it
    }
    return self;
}


- (void)setZoomInPosition
{
	CABasicAnimation *pos = [CABasicAnimation animationWithKeyPath:@"position"];
	if (sender != nil)
	{
		pos.fromValue = [NSValue valueWithCGPoint:[sender position]];
	} else {
		pos.fromValue = [NSValue valueWithCGPoint:ZOOM_TO_POINT]; //
	}
	
	pos.beginTime = 0;
	pos.duration = .25;
	pos.toValue = [NSValue valueWithCGPoint:CGPointMake(640.0, 360.0)];
	pos.fillMode = kCAFillModeForwards;
	[[self layer] addAnimation:pos forKey:@"position"];
}

- (void)setZoomOutPosition
{
	CABasicAnimation *pos = [CABasicAnimation animationWithKeyPath:@"position"];
	pos.fromValue = [NSValue valueWithCGPoint:CGPointMake(640.0, 360.0)]; //
	pos.beginTime = 0;
	pos.duration = .25;
	if (sender != nil)
	{
		pos.toValue = [NSValue valueWithCGPoint:[sender position]];
	} else {
		pos.toValue = [NSValue valueWithCGPoint:ZOOM_TO_POINT];
	}

	pos.fillMode = kCAFillModeForwards;
	[[self layer] addAnimation:pos forKey:@"position"];
}


- (CAAnimationGroup *)zoomOutFadedAnimation
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[self zoomOutAnimation], [self fadeOutAnimation], nil]];
	outAnimation.duration = .25;
	outAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

- (CAAnimationGroup *)zoomInFadedAnimation
{
	CAAnimationGroup *outAnimation = [CAAnimationGroup animation];
	[outAnimation setAnimations:[NSArray arrayWithObjects:[self zoomInAnimation], [self fadeInAnimation], nil]];
	outAnimation.duration = .25;
	outAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
	outAnimation.fillMode = kCAFillModeForwards; //if you dont set this it reverts to its old mode before removing and looks really stupid.
	outAnimation.removedOnCompletion = NO;
	return outAnimation;
	
}

- (CABasicAnimation *)fadeInAnimation
{
	CABasicAnimation *theAnimation =[CABasicAnimation animationWithKeyPath:@"opacity"];
		//theAnimation.duration=.25;
	theAnimation.fromValue=[NSNumber numberWithFloat:0.0];
	theAnimation.toValue=[NSNumber numberWithFloat:1.0];
	return theAnimation;
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
	if (sender != nil)
	{
		zoomOutAnimation.toValue = [NSValue valueWithCGRect:[sender bounds]];
		
	} else {
		
		zoomOutAnimation.toValue = [NSValue valueWithCGRect:ZOOM_TO_BOUNDS];
		
	}
	
		//zoomOutAnimation.duration = 0.25f;
	return zoomOutAnimation;
}

- (CABasicAnimation *)zoomInAnimation
{
	CABasicAnimation *zoomInAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	zoomInAnimation.beginTime = 0;
	if (sender != nil)
	{
		zoomInAnimation.fromValue = [NSValue valueWithCGRect:[sender bounds]];
		
	} else {
		
		zoomInAnimation.fromValue = [NSValue valueWithCGRect:ZOOM_TO_BOUNDS];
	}
	
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
			//CATransform3D zoomTransform = CATransform3DMakeScale(0.1, 0.1, 1.0);
		CAAnimationGroup *zoomOutAnimation = [self zoomOutFadedAnimation];
		[zoomOutAnimation setDelegate:self];
		[self setZoomOutPosition];
		[zoomOutAnimation setValue:@"removeFromParent" forKey:@"Name"];
		[[self layer] addAnimation:zoomOutAnimation forKey:@"removeFromParent"];
		
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
		if (sender != nil)
		{
			[self updateSender];
		}
		
		[self setZoomInPosition];
			//CATransform3D zoomTransform = CATransform3DMakeScale(0.1, 0.1, 1.0);
			//CABasicAnimation *zoomInAnimation = [self zoomInAnimation];
		CAAnimationGroup *zoomInAnimation = [self zoomInFadedAnimation];
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


/*
 
 if we are a BRMenuItem there are very minimal chances that you will get a usable position and bounds from it for zooming purposes
 here are all the functions where i handle what is mentioned at the top (the comments about sender)
 
 */

- (void)updateSender
{
	if ([sender isKindOfClass:[BRMenuItem class]]) //is or descends from BRMenuItem
	{
		id newSender = [self synthesizeMockItem]; //create our stub menu item that has 2 variables total.
		if (newSender != nil)
		{
				//	NSLog(@"setting new sender to: %@", newSender);
			
			sender = newSender;
				//NSLog(@"sender check: %@", sender);
		}
		
	}
	
}

	// find the list given the BRMenuItem (or said subclass of BRMenuItem)

- (id)getListFromMenuItem:(id)menuItem
{
	id listControl = [[[menuItem parent] parent] parent]; //parent = BRGridControl, grand parent = BRScrollControl, great grand parent = BRListControl
	NSString *class = NSStringFromClass([listControl class]);
	if (![class isEqualToString:@"BRListControl"])
	{
		NSLog(@"cant find list control!!!, found %@ instead!", class); //bail!!!
		return nil;
	}
	return listControl;
}

	//given the BRBlueGlowSelectionLozengeLayer control, spit out our stub class with the proper positioning.

- (id)synthesizeMockItemFrom:(id)theSender
{
	
	SMFMockMenuItem *menuItem = [[SMFMockMenuItem alloc] init];
	CGPoint newPosition = [theSender position];
	newPosition.x = 948.0f; //said attitude adjustment, without setting this x variable properly, all hell breaks loose.
	
	[menuItem setBounds:[theSender bounds]];
	[menuItem setPosition:newPosition];
	
	return menuItem;
	
}

- (id)synthesizeMockItem
{
	id theList = [self getListFromMenuItem:sender];
	if (theList == nil)
		return nil;
	NSEnumerator *controlEnum = [[theList controls] objectEnumerator];
	id current = nil;
	while ((current = [controlEnum nextObject]))
	{
		NSString *currentClass = NSStringFromClass([current class]);
		if ([currentClass isEqualToString:@"BRBlueGlowSelectionLozengeLayer"])
		{
			
			return [self synthesizeMockItemFrom:current];
			
		}
	}
	return nil;
}


-(void)dealloc
{
	[sender release];
	self.sender = nil;
    [super dealloc];
}


@end
