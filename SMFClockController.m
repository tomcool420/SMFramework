//
//  SMFClockController.m
//  SMFramework
//
//  Created by Thomas Cool on 10/31/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFClockController.h"


@implementation SMFClockController
@synthesize textAttributes;
-(id)init
{
    self=[super init];
    _timer = [[NSTimer scheduledTimerWithTimeInterval:5 
                                     target:self 
                                   selector:@selector(timerRun) 
                                   userInfo:nil 
                                    repeats:YES] retain];
    
    _formatter = [[NSDateFormatter alloc]init];
    
    [_formatter setTimeStyle:NSDateFormatterShortStyle];
    [_formatter setDateStyle:NSDateFormatterShortStyle];
    [self setTextAttributes:[[BRThemeInfo sharedTheme] menuItemTextAttributes]];
    [self setText:[_formatter stringFromDate:[NSDate date]]
   withAttributes:[[BRThemeInfo sharedTheme]menuTitleTextAttributes]];

    [self setTimeZone:[NSTimeZone timeZoneWithName:@"America/Chicago"]];
    [self setCurrentlocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US"]];
    return self;
}
-(void)setColor:(UIColor *)c
{
    [color release];
    color=c;
    [color retain];
}
-(void)setCurrentlocale:(NSLocale *)l
{
    [_currentlocale release];
    _currentlocale=nil;
    _currentlocale = [l retain];
    [_formatter setLocale:l];
}
-(NSLocale *)currentlocale
{
    return _currentlocale;
}
-(void)setTimeZone:(NSTimeZone *)tz
{
    [timeZone release];
    timeZone=nil;
    timeZone=[tz retain];
    [_formatter setTimeZone:timeZone];
}
-(NSTimeZone *)timeZone
{
    return timeZone;
}
-(void)timerRun
{
    BRController *tc= [[[BRApplicationStackManager singleton] stack] peekController];
    BOOL done=FALSE;
    
    BRControl *c=self;
    while (done == FALSE) {
        c=[c parent];
        if ([c isKindOfClass:[BRController class]]) {
            done = TRUE;
        }
        if (c==nil) {
            done = TRUE;
        }
        
    }
    if (c!=nil) 
    {
        
        if (tc==c) {
            [self setText:[_formatter stringFromDate:[NSDate date]] 
           withAttributes:[[BRThemeInfo sharedTheme]menuTitleTextAttributes]];
        }
        
        //        NSLog(@"timer run: %@ %@,parent: %@ %@ %@",self,[NSDate date],c,[self parent],tc);
    }
        
    
}
-(CGSize)renderedSize
{
    CGSize s = [super renderedSize];
    s.width=s.width*1.2;
    return s;
    
}
-(void)dealloc
{
    [_timer invalidate];
    [_timer release];
    _timer = nil;
    [_formatter release];
    [super dealloc];
}
@end
