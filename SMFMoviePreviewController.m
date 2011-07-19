//
//  SMFMoviePreviewController.m
//  SMFramework
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//
#import "Backrow/BRThemeInfo.h"
#import "Backrow/BRController.h"
#import "Backrow/BRControl.h"
#import "SMFControlFactory.h"
#import "SMFMoviePreviewController.h"
#import "SMFDefines.h"
#import "SMFBaseAsset.h"
#import "SMFListDropShadowControl.h"
#import "SMFCompatibility.h"
#import "SMFMoviePreviewDelegateDatasource.h"
#define NOSHELF
 NSString * const kSMFMoviePreviewTitle = @"title";
 NSString * const kSMFMoviePreviewSubtitle = @"substitle";
 NSString * const kSMFMoviePreviewSummary = @"summary";
 NSString * const kSMFMoviePreviewPosterPath = @"posterPath";
 NSString * const kSMFMoviePreviewPoster = @"poster";
 NSString * const kSMFMoviePreviewHeaders = @"headers";
 NSString * const kSMFMoviePreviewColumns = @"columns";
 NSString * const kSMFMoviePreviewRating = @"rating";
 NSString * const kMoviePreviewControllerSelectionChanged = @"kMoviePreviewControllerSelectionChanged";
 NSString * const kMoviePreviewControllerNewSelectedControl = @"kMoviePreviewControllerNewSelectedControl";


@implementation SMFMoviePreviewController
@synthesize delegate;
@synthesize datasource;

@synthesize shelfControl=_shelfControl;


@synthesize _buttons;
-(id)_shelfControl
{
    return _shelfControl;
}
+(NSDictionary *)columnHeaderAttributes
{
    return [[BRThemeInfo sharedTheme]movieMetadataLabelAttributes];
}
+(NSDictionary *)columnLabelAttributes
{
    return [[BRThemeInfo sharedTheme]metadataLineAttributes];
}
void logFrame(CGRect frame)
{
    NSLog(@"{{%f, %f},{%f,%f}}",frame.origin.x,frame.origin.y,frame.size.width,frame.size.height);
}
-(id)getProviderForShelf
{
    return [self.datasource providerForShelf];
}

-(NSMutableDictionary *)getInformation
{
    NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                              @"",kSMFMoviePreviewTitle,
                              @"",kSMFMoviePreviewSubtitle,
                              @"(no summary)",kSMFMoviePreviewSummary,
                              [NSArray array],kSMFMoviePreviewHeaders,
                              [NSArray array],kSMFMoviePreviewColumns,
                              [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"colorAppleTVNameImage" ofType:@"png"]],kSMFMoviePreviewPoster,
                              @"",kSMFMoviePreviewPosterPath,
                              @"pg",kSMFMoviePreviewRating,
                              nil];
    NSLog(@"get information %@",self.datasource);
    if (self.datasource!=nil /*&& [self.datasource conformsToProtocol:@protocol(SMFMoviePreviewControllerDatasource)]*/) {
        NSLog(@"conforms to protocol");
        NSString *t = [self.datasource title];
        if (t!=nil)  {[d setObject:t forKey:kSMFMoviePreviewTitle];}
        t = [self.datasource subtitle];
        if (t!=nil)  {[d setObject:t forKey:kSMFMoviePreviewSubtitle];}         
        t = [self.datasource summary];
        if (t!=nil)  {[d setObject:t forKey:kSMFMoviePreviewSummary];}         
        NSArray *a = [self.datasource headers];
        if (a!=nil)  {[d setObject:a forKey:kSMFMoviePreviewHeaders];}         
        a = [self.datasource columns];
        if (a!=nil)  {[d setObject:a forKey:kSMFMoviePreviewColumns];} 
        if ([self.datasource respondsToSelector:@selector(coverArt)]) {
            BRImage *i = [self.datasource coverArt];
            if (i!=nil)  {[d setObject:i forKey:kSMFMoviePreviewPoster];}
        }
        else if([self.datasource respondsToSelector:@selector(posterPath)])
        {
            t = [self.datasource posterPath];
            if (t!=nil)  {[d setObject:t forKey:kSMFMoviePreviewPosterPath];}
        }
        
		
        t = [self.datasource rating];
        if (t!=nil)  {[d setObject:t forKey:kSMFMoviePreviewRating];}
    }
    return [d autorelease];
    
}
void checkNil(NSObject *ctrl)
{
    if (ctrl!=nil) {
        [ctrl release];
        ctrl=nil;
    }
}
-(void)reload
{
//    Class $BRMediaShelfView = NSClassFromString(@"BRMediaShelfView");
//    Class __BRMediaShelfControl = NSClassFromString(@"BRMediaShelfControl");
    Class __BRProxyManager=NSClassFromString(@"BRProxyManager");
    
    if (__BRProxyManager !=nil)
        _usingShelfView=YES;
    
	
    //[self _removeAllControls];
    if (_hideList!=nil) {
        [_hideList release];
        _hideList=nil;
    }
    _hideList=[[NSMutableArray alloc] init];
    for (BRControl *c in [self controls]) {
        if (c!=_shelfControl) {
            [c removeFromParent];
        }
    }
    
    CGRect masterFrame=[BRWindow interfaceFrame];
    [_info release];
    _info=nil;
    _info = [[self getInformation] retain];
    _summaryToggled=NO;
    
    
    /*
     *  The Poster
     */
    checkNil(_previewControl);
    CGRect imageFrame = CGRectMake(-100.f,//masterFrame.origin.x+masterFrame.size.width*0.00f,
                                   164.f,//masterFrame.origin.y+masterFrame.size.height*0.20f,
                                   masterFrame.size.width*0.48f,
                                   masterFrame.size.height*0.843f);
    _previewControl =[[BRCoverArtPreviewControl alloc]init];
	
    SMFBaseAsset *a  = [SMFBaseAsset asset];
    [a setCoverArt:[_info objectForKey:kSMFMoviePreviewPoster]];
    BRPhotoImageProxy *proxy = [[BRPhotoImageProxy alloc] initWithAsset:a];
    [_previewControl setImageProxy:proxy];
    [proxy release];
	
    [_previewControl setFrame:imageFrame];
    [self addControl:_previewControl];
    
    /*
     *  The Title
     */
    NSLog(@"1");
    checkNil(_metadataTitleControl);
    _metadataTitleControl=[[BRMetadataTitleControl alloc]init];
    [_metadataTitleControl setTitle:[_info objectForKey:kSMFMoviePreviewTitle]];
    [_metadataTitleControl setTitleSubtext:[_info objectForKey:kSMFMoviePreviewSubtitle]];
    [_metadataTitleControl setRating:[_info objectForKey:kSMFMoviePreviewRating]];
    CGRect mtcf=CGRectMake(masterFrame.size.width*0.29766f, 
                           masterFrame.size.height*0.875f, 
                           masterFrame.size.width*0.648f,
                           masterFrame.size.height*0.0695);
	//    mtcf.size=CGSizeMake(830., 50);
	//    mtcf.origin.x=masterFrame.size.width*0.29766f; //381 on a 1280p wide
	//    mtcf.origin.y=masterFrame.size.width*0.875f;
    [_metadataTitleControl setFrame:mtcf];
    [self addControl:_metadataTitleControl];
    
	
    //[self addControl:_titleControl];
    
    
    /*
     *  The Subtitle
     */
	
    //[self addControl:_subtitleControl];
    
    /*
     *  First Divider
     */
    BRDividerControl *div1 = [[BRDividerControl alloc]init];
    CGRect div1Frame = CGRectMake(mtcf.origin.x , 
								  mtcf.origin.y-masterFrame.size.height*(10.f/720.f), 
								  mtcf.size.width,//masterFrame.size.width*0.64f, 
								  masterFrame.size.height*(10.f/720.f));
    [div1 setFrame:div1Frame];
    [self addControl:div1];
    [div1 release];
    
    /*
     *  Summary
     */
    checkNil(_summaryControl);
    _summaryControl = [[BRTextControl alloc]init];
    CGRect summaryFrame = CGRectMake(mtcf.origin.x, 
                                     div1Frame.origin.y-masterFrame.size.height*(94.f/720.f),//masterFrame.size.height*0.118f,
                                     mtcf.size.width,//masterFrame.size.width*0.64f, 
                                     masterFrame.size.height*(94.f/720.f));//masterFrame.size.height*0.113f);
    [_summaryControl setFrame:summaryFrame];
    [_summaryControl setText:[_info  objectForKey:kSMFMoviePreviewSummary]
			  withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
    //[_summaryControl setBackgroundColor:[[SMFThemeInfo sharedTheme]blackColor]];
    
    
    
    /*
     *  Second Divider
     */
    BRDividerControl *div2 = [[BRDividerControl alloc]init];
    CGRect div2Frame =CGRectMake(mtcf.origin.x , 
                                 summaryFrame.origin.y-10.f/720.f*masterFrame.size.height,//masterFrame.size.height*0.01f,
                                 mtcf.size.width,//masterFrame.size.width*0.64f, 
                                 masterFrame.size.height*(10.f/720.f));
    [div2 setFrame:div2Frame];
    [self addControl:div2];
    [_hideList addObject:div2];
    [div2 release];
    
	NSLog(@"2");
	
    /*
     *  Headers for information
     */
    NSArray *headers = [_info objectForKey:kSMFMoviePreviewHeaders];
    float increment = (mtcf.size.width/masterFrame.size.width)/(float)[headers count];
    //int counter=0;
    float lastOriginY=0.0f;
    NSLog(@"obj: %@",headers);
    for(int counter=0;counter<[headers count];counter++)
    {
        BRTextControl *head = [[BRTextControl alloc]init];
        [head setText:[headers objectAtIndex:counter] withAttributes:[SMFMoviePreviewController columnHeaderAttributes] ];
        CGRect headFrame;
        headFrame.size=[head renderedSize];
        if (headFrame.size.width>(masterFrame.size.width*increment*0.95f))
            headFrame.size.width=(masterFrame.size.width*increment*0.95f);
        headFrame.origin.x=mtcf.origin.x+masterFrame.size.width*increment*(float)counter;
        headFrame.origin.y=div2Frame.origin.y-masterFrame.size.height*0.001-headFrame.size.height;
        lastOriginY=headFrame.origin.y;
        [head setFrame:headFrame];
        [self addControl:head];
        [_hideList addObject:head];
        [head release];
    }
    /*
     *  Main Information
     */
    NSLog(@"3");
    NSArray *objects = [_info objectForKey:kSMFMoviePreviewColumns];
    for (int counter=0; counter<[objects count]; counter++) {
        NSArray *current = [objects objectAtIndex:counter];
        int maxObj = [current count]>5?5:[current count];
        float tempY = lastOriginY;
        for (int objcount=0; objcount<maxObj; objcount++) {
            if ([[current objectAtIndex:objcount] isKindOfClass:[NSArray class]]) {
                NSArray *objects = [current objectAtIndex:objcount];
                float x = mtcf.origin.x+masterFrame.size.width*increment*(float)counter;
                float maxX=mtcf.origin.x+masterFrame.size.width*increment*(float)counter+masterFrame.size.width*increment*0.95;
                float maxY=0.0;
                for (int i=0;i<[objects count];i++)
                {
                    id ctrl = nil;
                    CGRect r= CGRectMake(x, 0.0, 0.0, 0.0 );
                    if ([[objects objectAtIndex:i] isKindOfClass:[NSAttributedString class]])
                    {
                        ctrl = [[BRTextControl alloc]init];
                        [ctrl setAttributedString:[objects objectAtIndex:i]];
                        r.size=[ctrl renderedSize];
                        r.origin.y=tempY-r.size.height;
                        if (r.size.width+r.origin.x>maxX) {
                            r.size.width=maxX-r.origin.x;
                        }
                        logFrame(r);
                    }
                    else if([[objects objectAtIndex:i] isKindOfClass:[NSString class]])
                    {
                        ctrl = [[BRTextControl alloc]init];
                        [ctrl setText:[objects objectAtIndex:i] withAttributes:[SMFMoviePreviewController columnLabelAttributes]];
                        r.size=[ctrl renderedSize];
                        r.origin.y=tempY-r.size.height;
                        if (r.size.width+r.origin.x>maxX) {
                            r.size.width=maxX-r.origin.x;
                        }
                        logFrame(r);
                    }
                    else if([[objects objectAtIndex:i] isKindOfClass:[BRImage class]])
                    {
                        ctrl = [[BRImageControl alloc]init];
                        [(BRImageControl *)ctrl setImage:[objects objectAtIndex:i]];
                        float aspectRatio = [(BRImageControl *)ctrl aspectRatio];
                        r.size=[(BRImageControl *)ctrl pixelBounds];
                        r.size.height=22.f;
                        r.size.width=r.size.height*aspectRatio;
                        if (r.size.width+r.origin.x>maxX)
                        {
                            float rescaleFactor=r.size.width/(maxX-r.origin.x);
                            r.size.width=r.size.width*rescaleFactor;
                            r.size.height=r.size.height*rescaleFactor;
                            ctrl=nil;
                        }
                        r.origin.y=tempY-r.size.height;
                        logFrame(r);
                        
                    }
                    if (maxY<r.size.height)
                        maxY=r.size.height;
                    
                    if(i==([objects count]-1))
                        tempY=tempY-maxY;
                    
                    
                    if (ctrl!=nil) {
                        [ctrl setFrame:r];
                        [self addControl:ctrl];
                        [ctrl release];
                        [_hideList addObject:ctrl];
                        x=r.origin.x+r.size.width;
                    }
					
                }
            }
            else {
                BRControl *obj=nil;
                CGRect objFrame=CGRectMake(0.0, 0.0, 0.0, 0.0);
                if ([[current objectAtIndex:objcount] isKindOfClass:[NSString class]]) {
                    obj = [[BRTextControl alloc] init];
                    [(BRTextControl *)obj setText:[current objectAtIndex:objcount] withAttributes:[SMFMoviePreviewController columnLabelAttributes]];
                    objFrame.size=[(BRTextControl *)obj renderedSize];
                    if (objFrame.size.width>(masterFrame.size.width*increment*0.95f))
                        objFrame.size.width=(masterFrame.size.width*increment*0.95f);
                }
                else if ([[current objectAtIndex:objcount] isKindOfClass:[NSAttributedString class]]) {
                    obj = [[BRTextControl alloc] init];
                    [(BRTextControl *)obj setAttributedString:[current objectAtIndex:objcount]];
                    objFrame.size=[(BRTextControl *)obj renderedSize];
                    if (objFrame.size.width>(masterFrame.size.width*increment*0.95f))
                        objFrame.size.width=(masterFrame.size.width*increment*0.95f);
                }
                else if([[current objectAtIndex:objcount] isKindOfClass:[BRImage class]])
                {
                    obj = [[BRImageControl alloc]init];
                    [(BRImageControl *)obj setImage:[current objectAtIndex:objcount]];
                    objFrame.size=[(BRImageControl *)obj pixelBounds];
                    float aspectRatio = [(BRImageControl *)obj aspectRatio];
                    objFrame.size.height=24.f;
                    objFrame.size.width=objFrame.size.height*aspectRatio;
                    if (objFrame.size.width>(masterFrame.size.width*increment*0.95f))
                    {
                        float rescaleFactor=objFrame.size.width/(masterFrame.size.width*increment*0.95f);
                        objFrame.size.width=objFrame.size.width*rescaleFactor;
                        objFrame.size.height=objFrame.size.height*rescaleFactor;
                    }
                    
                }
                
                objFrame.origin.x=mtcf.origin.x+masterFrame.size.width*increment*(float)counter;
                objFrame.origin.y=tempY-objFrame.size.height;
                tempY=objFrame.origin.y;
                [obj setFrame:objFrame];
                [self addControl:obj];
                [_hideList addObject:obj];
                [obj release];
                
            }
            
        }
    }
    NSLog(@"buttons");
    checkNil(_buttons);
	
    _buttons=[[NSMutableArray alloc]init];
    NSArray *tbuttons=nil;//[NSArray array];
    if ([self.datasource respondsToSelector:@selector(buttons)]) {
        tbuttons = [self.datasource buttons];
    }
    else {
        tbuttons=[[NSMutableArray alloc]init];
        [(NSMutableArray *)tbuttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]previewActionImage] 
                                                                           subtitle:@"Preview" 
                                                                              badge:nil]];
        [(NSMutableArray *)tbuttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]playActionImage] 
                                                                           subtitle:@"Play" 
                                                                              badge:nil]];
        [(NSMutableArray *)tbuttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]queueActionImage] 
                                                                           subtitle:@"Queue" 
                                                                              badge:nil]];
        [(NSMutableArray *)tbuttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]rateActionImage] 
                                                                           subtitle:@"More" 
                                                                              badge:nil]];
        [tbuttons autorelease];
        
    }
	
    CGRect previewFrame=CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f, 
                                   masterFrame.origin.y + masterFrame.size.height *0.32f,
                                   masterFrame.size.height*0.15, 
                                   masterFrame.size.height*0.15f);
	
    CGRect firstButtonFrame = CGRectZero;
	CGRect lastButtonFrame = CGRectZero;
    int button=0;
    for(int i=0;i<[tbuttons count];i++)
    {
        id b = [tbuttons objectAtIndex:i];
        if([b isKindOfClass:[BRButtonControl class]])
        {
            CGRect f = previewFrame;
            f.origin.x=f.origin.x+ masterFrame.size.height*0.17*(float)button;
            [b setFrame:f];
            [self addControl:b];
            button++;
            [_buttons addObject:b];
			
			if (i == 0) {
				firstButtonFrame = f;
			} else if (i == [tbuttons count]-1) {
				lastButtonFrame = f;
			}
			
        }
    }
	
	/*
     *  Next/Previous arrows
     */
	checkNil(_previousArrowImageControl);
	checkNil(_nextArrowImageControl);
	
	float arrowImageControlMargin = 20.0f;
	if ([tbuttons count] > 0) { //if there are no buttons, we cannot go next/previous
		//next/previous arrows	
		if ([self.delegate respondsToSelector:@selector(controllerCanSwitchToPrevious:)]) {
			//does respond
			if ([self.delegate controllerCanSwitchToPrevious:self]) {
				//draw previous arrow
				_previousArrowImageControl = [[BRImageControl alloc] init];
				if (_previousArrowTurnedOn) {
					[self switchPreviousArrowOn];
				} else {
					[self switchPreviousArrowOff];
				}
				
				CGRect objFrame = firstButtonFrame;
				objFrame.origin.x -= [_previousArrowImageControl.image pixelBounds].width + arrowImageControlMargin;
				objFrame.origin.y += (objFrame.size.height/2) - ([_previousArrowImageControl.image pixelBounds].height / 2);
				objFrame.size.height = [_previousArrowImageControl.image pixelBounds].height;
				objFrame.size.width = [_previousArrowImageControl.image pixelBounds].width;
				[_previousArrowImageControl setFrame:objFrame];
				
				//rotate imageview so arrow points in the right direction
				CGAffineTransform cgCTM = CGAffineTransformMakeRotation(M_PI);
				_previousArrowImageControl.affineTransform = cgCTM;
				
				[self addControl:_previousArrowImageControl];
			}
		}
		if ([self.delegate respondsToSelector:@selector(controllerCanSwitchToNext:)]) {
			//does respond
			if ([self.delegate controllerCanSwitchToNext:self]) {
				//draw next arrow
				_nextArrowImageControl = [[BRImageControl alloc] init];
				if (_nextArrowTurnedOn) {
					[self switchNextArrowOn];
				} else {
					[self switchNextArrowOff];
				}
				
				CGRect objFrame = lastButtonFrame;
				objFrame.origin.x += lastButtonFrame.size.width + arrowImageControlMargin;
				objFrame.origin.y += (objFrame.size.height/2) - ([_nextArrowImageControl.image pixelBounds].height / 2);
				objFrame.size.height = [_nextArrowImageControl.image pixelBounds].height;
				objFrame.size.width = [_nextArrowImageControl.image pixelBounds].width;
				[_nextArrowImageControl setFrame:objFrame];
				
				[self addControl:_nextArrowImageControl];
			}
		}
	}
	NSLog(@"end buttons");
	
    BRTextControl *moviesControl =[[BRTextControl alloc] init];
    NSString *title=@"";
    if([self.datasource respondsToSelector:@selector(shelfTitle)])
        title=[self.datasource shelfTitle];
    else
        title=@"Movies";
    [moviesControl setText:title withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
    CGRect mf;
    mf.size = [moviesControl renderedSize];
    mf.origin.x=masterFrame.size.width*0.1;
    mf.origin.y=masterFrame.size.height*0.29f,
    [moviesControl setFrame:mf];
    [self addControl:moviesControl];
    [moviesControl release];
    
    BRDividerControl *div3 = [[BRDividerControl alloc]init];
    
    CGRect div3Frame =CGRectMake(mf.origin.x + mf.size.width+masterFrame.size.width*0.02f, 
                                 mf.origin.y+(mf.size.height-[div3 recommendedHeight])/2.0f,
                                 mtcf.origin.x+mtcf.size.width-(mf.origin.x + mf.size.width+masterFrame.size.width*0.02), 
                                 [div3 recommendedHeight]);
    [div3 setFrame:div3Frame];
    [self addControl:div3];
    [div3 release];
    
    
    
    BRCursorControl * cursor = [[[BRCursorControl alloc] init] autorelease];
    [self addControl:cursor];
    [self addControl:_summaryControl];
    
}


-(void)reloadShelf
{

    if (_shelfControl!=nil) {
        [_shelfControl release];
        _shelfControl=nil;
    }

    CGRect masterFrame=[BRWindow interfaceFrame];
    
    if(![SMF_COMPAT usingFourPointFourPlus])
    {
        _shelfControl = [[NSClassFromString(@"BRMediaShelfControl") alloc] init];
        [_shelfControl setProvider:[self getProviderForShelf]];
        [_shelfControl setColumnCount:8];
        [_shelfControl setCentered:NO];
        [_shelfControl setHorizontalGap:23];
    }
    else
    {
        _shelfControl=[[BRMediaShelfView alloc]init];
        [_shelfControl setCentered:YES];
        if (_provider!=nil) {
            [_provider release];
            _provider=nil;
        }
        _provider=[[self getProviderForShelf] retain];
        _adap = [[NSClassFromString(@"BRProviderDataSourceAdapter") alloc] init];
        [_adap setProviders:[NSArray arrayWithObject:_provider]];
        NSLog(@"Provider: %@ %@",_provider,_provider.controlFactory);
        [_provider.controlFactory setDefaultImage:[[BRThemeInfo sharedTheme]appleTVIcon]];
        [_adap setGridColumnCount:8];
        if ([_shelfControl respondsToSelector:@selector(setColumnCount:)]) {
            [_shelfControl setColumnCount:8];
        }
        
        [_shelfControl setCentered:NO];
        [_shelfControl setDataSource:_adap];
        [_shelfControl setDelegate:_adap];
        //[adap autorelease];
        [_shelfControl reloadData];
        
        [_shelfControl setColumnCount:8];
        [_shelfControl setHorizontalGap:33];
        [_shelfControl setReadyToDisplay];
        [_shelfControl layoutSubcontrols];
        [_shelfControl loadWithCompletionBlock:nil];
        //[_shelfControl scrollingCompleted];
        
        
        
        
        
        
    }
    //    [_shelfControl setCoverflowMargin:.021746988594532013];
    CGRect gframe=CGRectMake(masterFrame.size.width*0.00, 
                             masterFrame.origin.y+masterFrame.size.height*0.04f, 
                             masterFrame.size.width*1.f,
                             masterFrame.size.height*0.24f);
    [_shelfControl setFrame:gframe];
    [self addControl:_shelfControl];

    
	
    
    
}
-(void)wasPushed
{
    [self reload];
    [self reloadShelf];
}
-(void)controlWasActivated
{

    //[_shelfControl _loadControlWithStartIndex:0 start:YES];
    [super controlWasActivated];
//    if([_shelfControl respondsToSelector:@selector(_loadControlWithStartIndex:start:)])
//        [_shelfControl _loadControlWithStartIndex:0 start:YES];
}
-(void)toggleLongSummary
{
    CGRect f = [_summaryControl frame];
    CGSize masterSize = [BRWindow maxBounds];
    float sh=94.f/720.f*masterSize.height;
    float lh=275.f/720.f*masterSize.height;
    if (_summaryToggled==YES) {
        f.origin.y=f.origin.y+(lh-sh);
        f.size.height=sh;
        _summaryToggled=NO;
        for (BRControl *c in _hideList)
            [c setHidden:NO];

    }
    else {
        f.origin.y=f.origin.y-(lh-sh);
        f.size.height=lh;
        _summaryToggled=YES;
        for (BRControl *c in _hideList)
            [c setHidden:YES];
    }
    [_summaryControl setFrame:f];
    
    
    [_summaryControl layoutSubcontrols];
}
-(void)switchPreviousArrowOn 
{
	_previousArrowTurnedOn = YES; //used to retain arrow state if view is reloaded
	if (_previousArrowImageControl) {
		BRImage *arrowImageON = [BRImage imageWithPath:[[NSBundle bundleForClass:[BRThemeInfo class]]pathForResource:@"Arrow_ON" ofType:@"png"]];
		_previousArrowImageControl.image = arrowImageON;
		[_previousArrowImageControl setNeedsLayout];
	}
}
-(void)switchPreviousArrowOff 
{
	_previousArrowTurnedOn = NO; //used to retain arrow state if view is reloaded
	if (_previousArrowImageControl) {
		BRImage *arrowImageOFF = [BRImage imageWithPath:[[NSBundle bundleForClass:[BRThemeInfo class]]pathForResource:@"Arrow_OFF" ofType:@"png"]];
		_previousArrowImageControl.image = arrowImageOFF;
		[_previousArrowImageControl setNeedsLayout];
	}
}
-(void)switchNextArrowOn 
{
	_nextArrowTurnedOn = YES; //used to retain arrow state if view is reloaded
	if (_nextArrowImageControl) {
		BRImage *arrowImageON = [BRImage imageWithPath:[[NSBundle bundleForClass:[BRThemeInfo class]]pathForResource:@"Arrow_ON" ofType:@"png"]];
		_nextArrowImageControl.image = arrowImageON;
		[_nextArrowImageControl setNeedsLayout];
	}
}
-(void)switchNextArrowOff 
{
	_nextArrowTurnedOn = NO; //used to retain arrow state if view is reloaded
	if (_nextArrowImageControl) {
		BRImage *arrowImageOFF = [BRImage imageWithPath:[[NSBundle bundleForClass:[BRThemeInfo class]]pathForResource:@"Arrow_OFF" ofType:@"png"]];
		_nextArrowImageControl.image = arrowImageOFF;
		[_nextArrowImageControl setNeedsLayout];
	}
}
-(BOOL)brEventAction:(BREvent *)action
{
//    NSLog(@"shelf D D: %@ %@",_shelfControl.delegate,_shelfControl.dataSource);
//    _shelfControl.dataSource=self;
    BRControl *c = [self focusedControl];
    long shelfIndex=1;
    if ([[self stack] peekController]!=self)
        return [super brEventAction:action];
    int remoteAction = [action remoteAction];
    if (remoteAction==kBREventRemoteActionUp&&action.value==1) {
        if ([[self focusedControl] isKindOfClass:[BRButtonControl class]]) {
            [self toggleLongSummary];
            return YES;
        }
    }
	if([[self focusedControl] isKindOfClass:[SMFListDropShadowControl class]])
	{
		return [super brEventAction:action];
	}
	
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(SMFMoviePreviewControllerDelegate)]) {
    }
    if (remoteAction==kBREventRemoteActionPlay && 
        self.delegate!=nil && 
        action.value==1 && 
        [self.delegate conformsToProtocol:@protocol(SMFMoviePreviewControllerDelegate)]&&
        [self.delegate respondsToSelector:@selector(controller:buttonSelectedAtIndex:)]) {
        id selectedC = [self focusedControl];
        for (int j=0;j<[_buttons count];j++) {
            if([_buttons objectAtIndex:j]==selectedC)
                [self.delegate controller:self buttonSelectedAtIndex:j];
        }
    }
    if (remoteAction==kBREventRemoteActionPlay && 
        self.delegate!=nil && 
        action.value==1 && 
        [self.delegate conformsToProtocol:@protocol(SMFMoviePreviewControllerDelegate)])
    {
        [self.delegate controller:self selectedControl:[self focusedControl]];
        return YES;
    }
    else if(action.value==1 && self.delegate!=nil)
    {
        if ((remoteAction==kBREventRemoteActionRight || 
			 remoteAction==kBREventRemoteActionSwipeRight) &&
            [self.delegate respondsToSelector:@selector(controllerCanSwitchToNext:)] &&
            [self focusedControl]==[_buttons lastObject]) {
			if ([self.delegate controllerCanSwitchToNext:self]) {
				if ([self.delegate respondsToSelector:@selector(controllerSwitchToNext:)]) {
					[self.delegate controllerSwitchToNext:self];
					return YES;
				}
			}
        }
        else if((remoteAction==kBREventRemoteActionLeft || 
                 remoteAction==kBREventRemoteActionSwipeLeft) &&
                [self.delegate respondsToSelector:@selector(controllerCanSwitchToPrevious:)] &&
                [self focusedControl]==[_buttons objectAtIndex:0]) {
			if ([self.delegate controllerCanSwitchToPrevious:self]) {
				if ([self.delegate respondsToSelector:@selector(controllerSwitchToPrevious:)]) {
					[self.delegate controllerSwitchToPrevious:self];
					return YES;
				}
			}
        }
    }
    BOOL b=[super brEventAction:action];
    BRControl *d = [self focusedControl];
    if (action.value==1 && c!=d) {
        if (delegate!=nil && [delegate respondsToSelector:@selector(controller:shelfLastIndex:)]) {
            [delegate controller:self shelfLastIndex:shelfIndex];
        }
        if (delegate!=nil && [delegate respondsToSelector:@selector(controller:switchedFocusTo:)]) {
            [delegate controller:self switchedFocusTo:d];
        }
		
    }
    return b;
	
}
-(void)dealloc
{
	
    [_previewControl release];
    [_metadataTitleControl release];
    self.datasource=nil;
    self.delegate=nil;

    [_shelfControl release];

    [_buttons release];
    checkNil(_adap);
    checkNil(_previousArrowImageControl);
	checkNil(_nextArrowImageControl);
    checkNil(_info);
    checkNil(_summaryControl);
    checkNil(_hideList);
    checkNil(_provider);
    [super dealloc];
}

@end