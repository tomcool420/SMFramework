//
//  SMFMoviePreviewController.m
//  SMFramework
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//
#import <Backrow/BRThemeInfo.h>
#import <Backrow/BRController.h>
#import <Backrow/BRControl.h>
#import "SMFControlFactory.h"
#import "SMFMoviePreviewController.h"
#import "SMFDefines.h"
#import "SMFBaseAsset.h"
#import "SMFListDropShadowControl.h"
static NSString * const kSMFMovieTitle = @"title";
static NSString * const kSMFMovieSubtitle = @"substitle";
static NSString * const kSMFMovieSummary = @"summary";
static NSString * const kSMFMoviePosterPath = @"posterPath";
static NSString * const kSMFMoviePoster = @"poster";
static NSString * const kSMFMovieHeaders = @"headers";
static NSString * const kSMFMovieColumns = @"columns";
static NSString * const kSMFMovieRating = @"rating";
NSString * const kMoviePreviewControllerSelectionChanged = @"kMoviePreviewControllerSelectionChanged";
NSString * const kMoviePreviewControllerNewSelectedControl = @"kMoviePreviewControllerNewSelectedControl";


@implementation SMFMoviePreviewController
@synthesize delegate;
@synthesize datasource;
@synthesize _shelfControl;
@synthesize _buttons;
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
                              @"",kSMFMovieTitle,
                              @"",kSMFMovieSubtitle,
                              @"(no summary)",kSMFMovieSummary,
                              [NSArray array],kSMFMovieHeaders,
                              [NSArray array],kSMFMovieColumns,
                              [BRImage imageWithPath:[[NSBundle bundleForClass:[self class]] pathForResource:@"colorAppleTVNameImage" ofType:@"png"]],kSMFMoviePoster,
                              @"",kSMFMoviePosterPath,
                              @"pg",kSMFMovieRating,
                              nil];
    if (self.datasource!=nil && [self.datasource conformsToProtocol:@protocol(SMFMoviePreviewControllerDatasource)]) {
        NSString *t = [self.datasource title];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieTitle];}
        t = [self.datasource subtitle];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieSubtitle];}         
        t = [self.datasource summary];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieSummary];}         
        NSArray *a = [self.datasource headers];
        if (a!=nil)  {[d setObject:a forKey:kSMFMovieHeaders];}         
        a = [self.datasource columns];
        if (a!=nil)  {[d setObject:a forKey:kSMFMovieColumns];} 
        if ([self.datasource respondsToSelector:@selector(coverArt)]) {
            BRImage *i = [self.datasource coverArt];
            if (i!=nil)  {[d setObject:i forKey:kSMFMoviePoster];}
        }
        else if([self.datasource respondsToSelector:@selector(posterPath)])
        {
            t = [self.datasource posterPath];
            if (t!=nil)  {[d setObject:t forKey:kSMFMoviePosterPath];}
        }
        
       
        t = [self.datasource rating];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieRating];}
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

    //[self _removeAllControls];
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
    [a setCoverArt:[_info objectForKey:kSMFMoviePoster]];
    BRPhotoImageProxy *proxy = [[BRPhotoImageProxy alloc] initWithAsset:a];
    [_previewControl setImageProxy:proxy];
    [proxy release];

    [_previewControl setFrame:imageFrame];
    [self addControl:_previewControl];
    
    /*
     *  The Title
     */
    checkNil(_metadataTitleControl);
    _metadataTitleControl=[[BRMetadataTitleControl alloc]init];
    [_metadataTitleControl setTitle:[_info objectForKey:kSMFMovieTitle]];
    [_metadataTitleControl setTitleSubtext:[_info objectForKey:kSMFMovieSubtitle]];
    [_metadataTitleControl setRating:[_info objectForKey:kSMFMovieRating]];
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
    [_summaryControl setText:[_info  objectForKey:kSMFMovieSummary]
         withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
    [_summaryControl setBackgroundColor:[[SMFThemeInfo sharedTheme]blackColor]];
    
    
    
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
    [div2 release];
    


    /*
     *  Headers for information
     */
    NSArray *headers = [_info objectForKey:kSMFMovieHeaders];
    float increment = (mtcf.size.width/masterFrame.size.width)/(float)[headers count];
    //int counter=0;
    float lastOriginY=0.0f;
    for(int counter=0;counter<4;counter++)
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
        [head release];
    }
    /*
     *  Main Information
     */
    NSArray *objects = [_info objectForKey:kSMFMovieColumns];
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
                [obj release];
                
            }
            
        }
    }
    

    checkNil(_buttons);

    _buttons=[[NSMutableArray alloc]init];
    NSArray *buttons=nil;//[NSArray array];
    if ([self.datasource respondsToSelector:@selector(buttons)]) {
        buttons = [self.datasource buttons];
    }
    else {
        buttons=[[NSMutableArray alloc]init];
        [(NSMutableArray *)buttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]previewActionImage] 
                                                                           subtitle:@"Preview" 
                                                                              badge:nil]];
        [(NSMutableArray *)buttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]playActionImage] 
                                                                           subtitle:@"Play" 
                                                                              badge:nil]];
        [(NSMutableArray *)buttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]queueActionImage] 
                                                                           subtitle:@"Queue" 
                                                                              badge:nil]];
        [(NSMutableArray *)buttons addObject:[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]rateActionImage] 
                                                                           subtitle:@"More" 
                                                                              badge:nil]];
        [buttons autorelease];
        
    }

    CGRect previewFrame=CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f, 
                                   masterFrame.origin.y + masterFrame.size.height *0.32f,
                                   masterFrame.size.height*0.15, 
                                   masterFrame.size.height*0.15f);
    int button=0;
    for(int i=0;i<[buttons count];i++)
    {
        id b = [buttons objectAtIndex:i];
        if([b isKindOfClass:[BRButtonControl class]])
        {
            CGRect f = previewFrame;
            f.origin.x=f.origin.x+ masterFrame.size.height*0.17*(float)button;
            [b setFrame:f];
            [self addControl:b];
            button++;
            [_buttons addObject:b];
        }
    }
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
    
    
    
    BRCursorControl * hey = [[BRCursorControl alloc] init];
    [self addControl:hey];
    [self addControl:_summaryControl];
    [hey release];
    
}
-(void)reloadShelf
{
    if (_shelfControl!=nil) {
        [_shelfControl release];
        _shelfControl=nil;
    }
    CGRect masterFrame=[BRWindow interfaceFrame];
    _shelfControl = [[BRMediaShelfControl alloc] init];
    [_shelfControl setProvider:[self getProviderForShelf]];
    [_shelfControl setColumnCount:8];
    [_shelfControl setCentered:NO];
    [_shelfControl setHorizontalGap:23];
    //    [_shelfControl setCoverflowMargin:.021746988594532013];
    CGRect gframe=CGRectMake(masterFrame.size.width*0.00, 
                             masterFrame.origin.y+masterFrame.size.height*0.04f, 
                             masterFrame.size.width*1.f,
                             masterFrame.size.height*0.24f);
    [_shelfControl setFrame:gframe];
    [self addControl:_shelfControl];
    

    
    
}
-(void)controlWasActivated
{
    [self reload];
    [self reloadShelf];
    [super controlWasActivated];
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
    }
    else {
        f.origin.y=f.origin.y-(lh-sh);
        f.size.height=lh;
        _summaryToggled=YES;
    }
    [_summaryControl setFrame:f];
    
    
    [_summaryControl layoutSubcontrols];
}
-(BOOL)brEventAction:(BREvent *)action
{
    BRControl *c = [self focusedControl];
    long shelfIndex = [_shelfControl focusedIndex];
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
            [self.delegate respondsToSelector:@selector(controllerSwitchToNext:)] &&
            [self focusedControl]==[_buttons lastObject]) {
            [self.delegate controllerSwitchToNext:self];
            return YES;
        }
        else if((remoteAction==kBREventRemoteActionLeft || 
                 remoteAction==kBREventRemoteActionSwipeLeft) &&
                [self.delegate respondsToSelector:@selector(controllerSwitchToPrevious:)] &&
                [self focusedControl]==[_buttons objectAtIndex:0]){
            [self.delegate controllerSwitchToPrevious:self];
            return YES;
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
    self.datasource=nil;
    [_shelfControl release];
    [_buttons release];
    checkNil(_info);
    checkNil(_summaryControl);
    [super dealloc];
}
#pragma mark datasource methods
-(NSString *)title
{
    return @"Awesomeness";
}
-(NSString *)subtitle
{
    return @"An AwkwardTV Production";
}
-(NSString *)summary
{
    return @"Awesomeness, a history of development on the AppleTV. from tragedy to comedy, from whining to bitching, from compliments to insults: the History of the AppleTV in 5 acts. Complete with exta bashing, QQ and whining";
}
-(NSArray *)headers
{
    return [NSArray arrayWithObjects:@"Details",@"Actors",@"Director",@"Producers",nil];
}
-(NSArray *)columns
{
    NSArray *actors = [NSArray arrayWithObjects:@"|bile|",@"davilla",@"erica",@"mringwal",@"tomcool",nil];
    NSArray *directors = [NSArray arrayWithObjects:@"macTijn",@" ",
                          [[[NSAttributedString alloc]initWithString:@"Art Director" 
                                                          attributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]]autorelease],
                          @"Leddy",nil];
    NSArray *producers = [NSArray arrayWithObjects:@"Alan Quatermain",@"gbooker",@"DHowett",nil];
    BRImage *i = [[BRThemeInfo sharedTheme] hdBadge];
    NSArray *details = [NSArray arrayWithObjects:
                        @"Action & Comedy",
                        @"Released: 2010",
                        [NSArray arrayWithObjects:
                         i,
                         [[[NSAttributedString alloc] initWithString:@" 2" attributes:[[BRThemeInfo sharedTheme]metadataTitleAttributes]]autorelease],
                         i,nil],
                        @"Run Time: Years",
                        [[SMFThemeInfo sharedTheme]fourPointFiveStars],
                        nil];
    NSArray *objects = [NSArray arrayWithObjects:details,actors,directors,producers,nil];
    return objects;
}
-(NSString *)rating
{
    return @"R";
}
-(BRImage *)coverArt
{
    return [BRImage imageWithPath:[self posterPath]];
}
-(NSString *)posterPath
{
    return [[NSBundle bundleForClass:[self class]]pathForResource:@"poster" ofType:@"jpg"];
}
-(BRPhotoDataStoreProvider *)providerForShelf
{
    NSSet *_set = [NSSet setWithObject:[BRMediaType photo]];
    NSPredicate *_pred = [NSPredicate predicateWithFormat:@"mediaType == %@",[BRMediaType photo]];
    BRDataStore *store = [[BRDataStore alloc] initWithEntityName:@"Hello" predicate:_pred mediaTypes:_set];
    NSArray *assets = [SMFPhotoMethods mediaAssetsForPath:[[NSBundle bundleForClass:[self class]]pathForResource:@"Posters" ofType:@""]];
    for (id a in assets) {
        [store addObject:a];
    }
    
    //id dSPfCClass = NSClassFromString(@"BRPhotoDataStoreProvider");
    
    id tcControlFactory = [BRPosterControlFactory factory];
    id provider    = [BRPhotoDataStoreProvider providerWithDataStore:store controlFactory:tcControlFactory];
    [store release];
    return provider; 
}
-(NSArray *)buttons
{
    NSMutableArray *buttons = [[NSMutableArray alloc]init];
    BRButtonControl* b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]previewActionImage] 
                                                        subtitle:@"Preview" 
                                                           badge:nil];
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]playActionImage] 
                                       subtitle:@"Play"
                                          badge:nil];
    
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]queueActionImage] 
                                       subtitle:@"Queue" 
                                          badge:nil];
    
    [buttons addObject:b];
    
    b = [BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]rateActionImage] 
                                       subtitle:@"More" 
                                          badge:nil];
    [buttons addObject:b];
    return [buttons autorelease];
    
}
@end
