//
//  SMFListDropShadowControl.m
//  SMFramework
//
//  Created by Thomas Cool on 1/21/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#define ZOOM_TRANSFORM CATransform3DMakeScale(0.1, 0.1, 1.0);

#import "SMFListDropShadowControl.h"
#import "SMFThemeInfo.h"
#import "SMFMenuItem.h"
#import "SMFDefines.h"
@implementation SMFListDropShadowControl
@synthesize cDelegate, cDatasource, list, isAnimated;
-(id)init
{
    self =[super init];
    if (self!=nil) {
        self.list = [[[BRListControl alloc]init]autorelease];
        [self.list setDatasource:self];
        self.isAnimated = FALSE; //up to you, can be false by default if you dont like it
		self.backgroundColor=[[SMFThemeInfo sharedTheme]blackColor];
        self.borderColor=[[SMFThemeInfo sharedTheme] whiteColor];
        self.borderWidth=3.0;
		self.inhibitsFocusForChildren = TRUE;
		self.avoidsCursor = TRUE;
        [self setContent:self.list];
    }
    return self;
}
-(void)reloadList
{
    [list reload];
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

-(void)addToController:(BRController *)ctrl
{
    CGRect f = [self rectForSize:CGSizeMake(528., 154.)];
	
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
    [ctrl _setFocus:self];
}
-(void)controlWasActivated
{    
//    [list setSelection:0];
	[self setFocusedControl:list];
    [self _setFocus:list];
    [super controlWasActivated];
}
- (float)heightForRow:(long)row				
{ 
    if (cDatasource && [cDatasource respondsToSelector:@selector(popupHeightForRow:)]) {
        return [cDatasource popupHeightForRow:row];
    }
    return 0.0f;
}
- (BOOL)rowSelectable:(long)row				
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupRowSelectable:)])
        return [cDatasource popupRowSelectable:row];
    return YES;
}

- (long)itemCount							
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupItemCount)])
        return [cDatasource popupItemCount];
    return (long)3;
}
- (id)itemForRow:(long)row					
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupItemForRow:)])
        return [cDatasource popupItemForRow:row];
    SMFMenuItem *it = [SMFMenuItem menuItem];
    [it setTitle:@"Default Item"];
    return it;
}
- (id)titleForRow:(long)row					
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupTitleForRow:)])
        return [cDatasource popupTitleForRow:row];
    if (row>=[self itemCount])
        return nil;
    return [[self itemForRow:row] text];
}
- (long)defaultIndex						
{ 
    if(cDatasource && [cDatasource respondsToSelector:@selector(popupDefaultIndex)])
        return [cDatasource popupDefaultIndex];
    return 0;
}
-(void)itemSelected:(long)selected
{

    if (cDelegate && [cDelegate respondsToSelector:@selector(popup:itemSelected:)])
        [cDelegate popup:self itemSelected:selected];
    else if (cDelegate && [cDelegate respondsToSelector:@selector(popupItemSelected:)]) {
        [cDelegate popupItemSelected:selected];
    }
    else {
        [self removeFromParent];
    }
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
	 
- (void)actuallyRemove //deprecated
	 
{ [super removeFromParent]; }

-(BOOL)brEventAction:(BREvent*)event
{

    int remoteAction = [event remoteAction];
    switch (remoteAction)
    {
        case kBREventRemoteActionMenu:
            [self removeFromParent];
            return YES;
            break;
        case kBREventRemoteActionPlay:
            [self itemSelected:[list selection]];
            return YES;
            break;
    }
    return [super brEventAction:event];
}


-(CGRect)rectForSize:(CGSize)s
{
    CGRect r;
    r.size.width=s.width;
    SMFMenuItem *a = [SMFMenuItem menuItem];
    CGSize ss = [a sizeThatFits:s];
    int it = [self itemCount];
    if (it>6)
        it=6;
    r.size.height=52.+ss.height*it;
    CGSize windowSize = [BRWindow maxBounds];
    r.origin.y=(windowSize.height-r.size.height)/2.0f;
    r.origin.x=(windowSize.width-r.size.width)/2.0f;
    return r;
}
-(void)dealloc
{
    self.cDelegate=nil;
    self.cDatasource=nil;
    self.list=nil;
    [super dealloc];
}
@end
