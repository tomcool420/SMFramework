//
//  SMFPasscodeController.m
//  SMFramework
//
//  Created by Thomas on 4/19/09.
//  Copyright 2010 Thomas Cool. All rights reserved.
//
//  Entry Control frame position by nito

#import "SMFPasscodeController.h"
#import "SMFPreferences.h"
@interface SMFPasscodeController (Private)
-(void)_drawSelf;
-(void) textDidEndEditing: (id) sender;
-(void) textDidChange: (id) sender;
@end


@implementation SMFPasscodeController
@synthesize boxes;
@synthesize initialValue;
@synthesize delegate;
@synthesize key;
@synthesize domain;
@synthesize description;
@synthesize icon;
@synthesize title;
+(SMFPasscodeController *)passcodeWithTitle:(NSString *)t 
                            withDescription:(NSString *)desc 
                                  withBoxes:(int)b
                                    withKey:(NSString *)k
                                 withDomain:(NSString *)dom
{
    SMFPasscodeController *obj=[[SMFPasscodeController alloc] initWithTitle:t withDescription:desc withBoxes:b withKey:k withDomain:dom];
    return [obj autorelease];
}
+(SMFPasscodeController *)passcodeWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withDelegate:(id)del
{
    SMFPasscodeController *obj=[[SMFPasscodeController alloc] initWithTitle:t withDescription:desc withBoxes:b withKey:nil withDomain:nil];
    obj.delegate=del;
    return [obj autorelease];
}
- (id)initWithTitle:(NSString *)t withDescription:(NSString *)desc withBoxes:(int)b withKey:(NSString *)k withDomain:(NSString *)d
{
	self = [super init];    
    self.delegate = nil;
    self.icon=nil;
    self.title=t;
    self.description=desc;
    self.boxes=b;
    self.key=k;
    self.domain=d;
    self.initialValue=0;
	return self;
    
}
- (void) dealloc
{
    self.title=nil;
    self.delegate=nil;
    self.description=nil;
    self.key=nil;
    self.domain=nil;
    self.icon=nil;
    [super dealloc];
}
-(void)controlWasActivated
{
	[self _drawSelf];
    [super controlWasActivated];
}
@end
@implementation SMFPasscodeController (Private)

-(void)_drawSelf
{
    /*
     *  Getting the Master Frame
     */
    CGRect master ;
//	if ([SMFCompatibilityMethods usingTakeTwoDotThree])
//		master  = [(BRControl *)[self parent] frame];
//    else
		master = [self frame];
    
    /*
     *  Drawing the Header
     */
	BRHeaderControl *header = [[BRHeaderControl alloc] init];
    [header setTitle:self.title withAttributes:[[BRThemeInfo sharedTheme]menuTitleTextAttributes]];
    if(self.icon)
		[header setIcon:self.icon horizontalOffset:0.5f kerningFactor:0.2f];
    CGRect frame = CGRectMake(master.origin.x, 
                              master.size.height * 0.82f, 
                              master.size.width, 
                              [[BRThemeInfo sharedTheme] listIconHeight]);
    [header setFrame:frame];
	[self addControl:header];
	
	
	
	
    
    
	BRTextControl *descriptionText = [[BRTextControl alloc] init];
	[descriptionText setText:self.description 
              withAttributes:[[BRThemeInfo sharedTheme] promptTextAttributes]];
	
	frame.size = [descriptionText renderedSize];
    frame.origin.y = master.origin.y + (master.size.height * 0.72f);
	frame.origin.x = (master.origin.x+master.size.width)*0.5f-frame.size.width*0.5f+master.origin.x;
	[descriptionText setFrame: frame];
    [self addControl:descriptionText];
    
	
	
    
    /*
     *  Passcode Control
     */
	BRPasscodeEntryControl *entryControl = [[BRPasscodeEntryControl alloc] initWithNumDigits:self.boxes
                                                                                userEditable:YES 
                                                                                  hideDigits:NO];
    /*
     *  Initial Value
     */
    if (self.initialValue!=0) {
        
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setFormatterBehavior: NSNumberFormatterBehavior10_4];
        [numberFormatter setFormatWidth: self.boxes];
        [numberFormatter setPaddingCharacter: @"0"]; 
        NSNumber *four = [NSNumber numberWithInt:self.initialValue];
        NSString * str =[numberFormatter stringFromNumber:four];
        [numberFormatter release];
        [entryControl setInitialPasscode:str];
    }
    
    /*
     *  Delegate
     */
//    if(self.delegate==nil)
//        [entryControl setDelegate:self];
//    else 
        [entryControl setDelegate:self];
    
	/*
     *  Special Size for 1080i
     */
    
    frame.size = [entryControl preferredSizeFromScreenSize:master.size];

//	if (![SMFCompatibilityMethods using1080i])
//	{
//		frame.size = [entryControl preferredSizeFromScreenSize:master.size];
//	} else {
//		frame.size = [entryControl preferredSizeFromScreenSize:[SMFCompatibilityMethods sizeFor1080i]];
//	}
    frame.origin.y = master.origin.y + (master.size.height * 0.40f);
	frame.origin.x = (master.size.width)*0.5f-frame.size.width*((float)self.boxes*0.5f)/((float)self.boxes+0.6f);
    [entryControl setFrame:frame];
    
    
    [self addControl:entryControl];
}
#pragma mark entryControl Delegate Methods
- (void) textDidChange: (id) sender
{
    if (delegate && [delegate respondsToSelector:@selector(textDidChange:)]) {
        [delegate textDidChange:sender];
    }
}

- (void) textDidEndEditing: (id) sender
{
    if (delegate && [delegate respondsToSelector:@selector(textDidEndEditing:)]) {
        [delegate textDidEndEditing:sender];
    }
    else 
    {
        if (key && domain) {
            SMFPreferences *p = [[SMFPreferences alloc] initWithPersistentDomainName:domain];
            [p setObject:[NSNumber numberWithInt:[[sender stringValue] intValue]] forKey:key];
        }
        [[self stack] popController];
    }
    
}
@end













