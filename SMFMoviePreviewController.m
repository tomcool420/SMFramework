//
//  SMFMoviePreviewController.m
//  SMFramework
//
//  Created by Thomas Cool on 2/6/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//
#import "SMFControlFactory.h"
#import "SMFMoviePreviewController.h"
#import "SMFDefines.h"
static NSString * const kSMFMovieTitle = @"title";
static NSString * const kSMFMovieSubtitle = @"substitle";
static NSString * const kSMFMovieSummary = @"summary";
static NSString * const kSMFMoviePoster = @"poster";
static NSString * const kSMFMovieHeaders = @"headers";
static NSString * const kSMFMovieColumns = @"columns";
static NSString * const kSMFMovieRating = @"rating";


@implementation SMFMoviePreviewController
@synthesize delegate;
@synthesize datasource;
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
                              [[NSBundle bundleForClass:[self class]] pathForResource:@"colorAppleTVNameImage" ofType:@"png"],kSMFMoviePoster,
                              @"pg",kSMFMovieRating,
                              nil];
    if (self.datasource!=nil && [self.datasource conformsToProtocol:@protocol(SMFMoviePreviewControllerDatasource)]) {
        NSLog(@"conforms to protocol");
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
        t = [self.datasource posterPath];
        if (t!=nil)  {[d setObject:t forKey:kSMFMoviePoster];}
        t = [self.datasource rating];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieRating];}
    }
    return [d autorelease];
    
}
-(void)drawSelf
{
    CGRect masterFrame=[BRWindow interfaceFrame];
    [_info release];
    _info=nil;
    _info = [[self getInformation] retain];
    
    
    /*
     *  The Poster
     */
    CGRect imageFrame = CGRectMake(masterFrame.origin.x+masterFrame.size.width*0.00f,
                                   masterFrame.origin.y+masterFrame.size.height*0.20f,
                                   masterFrame.size.width*0.32f,
                                   masterFrame.size.height*0.83f);
    _previewControl =[[BRCoverArtPreviewControl alloc]init];
    BRPhotoMediaAsset *asset = [[BRPhotoMediaAsset alloc]init];
    NSString *p = [_info objectForKey:kSMFMoviePoster];
    [asset setCoverArtURL:p];
    [asset setThumbURL:p];
    [asset setFullURL:p];
    BRPhotoImageProxy *proxy = [[BRPhotoImageProxy alloc] initWithAsset:asset];
    [_previewControl setImageProxy:proxy];
    [proxy release];
    [asset release];
    [_previewControl setFrame:imageFrame];
    [self addControl:_previewControl];
    
    /*
     *  The Title
     */
    _titleControl = [[BRTextControl alloc]init];
    [_titleControl setText:[_info objectForKey:kSMFMovieTitle] withAttributes:[[BRThemeInfo sharedTheme]menuTitleTextAttributes]];
    CGRect titleFrame;
    titleFrame.size = [_titleControl renderedSize];
    titleFrame.origin.x=imageFrame.origin.x+imageFrame.size.width-masterFrame.size.width*0.02f;
    titleFrame.origin.y=imageFrame.origin.y+imageFrame.size.height-titleFrame.size.height-masterFrame.size.height*0.05;
    [_titleControl setFrame:titleFrame];
    [self addControl:_titleControl];
    
    
    /*
     *  The Subtitle
     */
    _subtitleControl = [[BRTextControl alloc] init];
    NSMutableDictionary *attributes = [[[[BRThemeInfo sharedTheme] metadataSummaryFieldAttributes] mutableCopy]autorelease];
    //[attributes setObject:(id)[[SMFThemeInfo sharedTheme]lightGrayColor] forKey:@"CTForegroundColor"];
    [_subtitleControl setText:[_info objectForKey:kSMFMovieSubtitle] withAttributes:attributes];
    CGRect subtitleFrame;
    subtitleFrame.size= [ _subtitleControl renderedSize];
    subtitleFrame.origin.x=titleFrame.origin.x;
    subtitleFrame.origin.y=titleFrame.origin.y-subtitleFrame.size.height;//-masterFrame.size.height*0.005;
    [_subtitleControl setFrame:subtitleFrame];
    [self addControl:_subtitleControl];
    
    /*
     *  First Divider
     */
    BRDividerControl *div1 = [[BRDividerControl alloc]init];
    CGRect div1Frame = CGRectMake(subtitleFrame.origin.x , 
                                 subtitleFrame.origin.y-masterFrame.size.height*0.01f, 
                                 masterFrame.size.width*0.64f, 
                                 masterFrame.size.height*0.02f);
    [div1 setFrame:div1Frame];
    [self addControl:div1];
    [div1 release];
    
    /*
     *  Summary
     */
    _summaryControl = [[BRTextControl alloc]init];
    CGRect summaryFrame = CGRectMake(subtitleFrame.origin.x, 
                                     div1Frame.origin.y-masterFrame.size.height*0.118f,
                                     masterFrame.size.width*0.64f, 
                                     masterFrame.size.height*0.113f);
    [_summaryControl setFrame:summaryFrame];
    [_summaryControl setText:[_info  objectForKey:kSMFMovieSummary]
         withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
    [self addControl:_summaryControl];
    
    
    /*
     *  Second Divider
     */
    BRDividerControl *div2 = [[BRDividerControl alloc]init];
    CGRect div2Frame =CGRectMake(subtitleFrame.origin.x , 
                                 summaryFrame.origin.y-masterFrame.size.height*0.01f,
                                 masterFrame.size.width*0.64f, 
                                 masterFrame.size.height*0.02f);
    [div2 setFrame:div2Frame];
    [self addControl:div2];
    [div2 release];
    
    /*
     *  Rating
     */
    _rating = [[BRImageControl alloc] init];
    [_rating setImage:[[BRThemeInfo sharedTheme]ratingImageForString:[_info objectForKey:kSMFMovieRating]]];
    CGRect ratingFrame;
    ratingFrame.size=[_rating pixelBounds];
    ratingFrame.origin.x=div1Frame.origin.x+div1Frame.size.width-ratingFrame.size.width;
    ratingFrame.origin.y=titleFrame.origin.y;
    [_rating setFrame:ratingFrame];
    [self addControl:_rating];

    /*
     *  Headers for information
     */
    NSArray *headers = [_info objectForKey:kSMFMovieHeaders];
    float increment = 0.64f/(float)[headers count];
    //int counter=0;
    float lastOriginY=0.0f;
    for(int counter=0;counter<4;counter++)
    {
        BRTextControl *head = [[BRTextControl alloc]init];
        [head setText:[headers objectAtIndex:counter] withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
        CGRect headFrame;
        headFrame.size=[head renderedSize];
        if (headFrame.size.width>(masterFrame.size.width*increment*0.95f))
            headFrame.size.width=(masterFrame.size.width*increment*0.95f);
        headFrame.origin.x=titleFrame.origin.x+masterFrame.size.width*increment*(float)counter;
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
            BRControl *obj=nil;
            CGRect objFrame=CGRectMake(0.0, 0.0, 0.0, 0.0);
            if ([[current objectAtIndex:objcount] isKindOfClass:[NSString class]]) {
                obj = [[BRTextControl alloc] init];
                [(BRTextControl *)obj setText:[current objectAtIndex:objcount] withAttributes:[[BRThemeInfo sharedTheme]metadataTitleAttributes]];
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
                if (objFrame.size.width>(masterFrame.size.width*increment*0.95f))
                {
                    float rescaleFactor=objFrame.size.width/(masterFrame.size.width*increment*0.95f);
                    objFrame.size.width=objFrame.size.width*rescaleFactor;
                    objFrame.size.height=objFrame.size.height*rescaleFactor;
                }

            }
            objFrame.origin.x=titleFrame.origin.x+masterFrame.size.width*increment*(float)counter;
            objFrame.origin.y=tempY-objFrame.size.height;
            tempY=objFrame.origin.y;
            [obj setFrame:objFrame];
            [self addControl:obj];
            [obj release];
        }
    }
    
    /*
     *  Buttons not yet customizable
     */
    _previewButton = [[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]previewActionImage] 
                                                    subtitle:@"Preview" 
                                                       badge:nil] retain];
    CGRect previewFrame=CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f, 
                                   masterFrame.origin.y + masterFrame.size.height *0.32f,
                                   masterFrame.size.height*0.15, 
                                   masterFrame.size.height*0.15f);
    [_previewButton setFrame:previewFrame];
    [self addControl:_previewButton];
    
    _playButton = [[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]playActionImage] 
                                                 subtitle:@"Play" 
                                                    badge:nil]retain];
    CGRect playFrame = CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f+ masterFrame.size.height*0.17,
                                  masterFrame.origin.y + masterFrame.size.height *0.32f, 
                                  masterFrame.size.height*0.15, 
                                  masterFrame.size.height*0.15f);
    [_playButton setFrame:playFrame];
    [self addControl:_playButton];
    
    _queueButton = [[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]queueActionImage] 
                                                 subtitle:@"Queue" 
                                                    badge:nil]retain];
    CGRect queueFrame = CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f+ masterFrame.size.height*0.17*2.f,
                                  masterFrame.origin.y + masterFrame.size.height *0.32f, 
                                  masterFrame.size.height*0.15, 
                                  masterFrame.size.height*0.15f);
    [_queueButton setFrame:queueFrame];
    [self addControl:_queueButton];
    
    _moreButton = [[BRButtonControl actionButtonWithImage:[[BRThemeInfo sharedTheme]rateActionImage] 
                                                  subtitle:@"More" 
                                                     badge:nil]retain];
    CGRect moreFrame = CGRectMake(masterFrame.origin.x + masterFrame.size.width*0.42f+ masterFrame.size.height*0.17*3.f,
                                  masterFrame.origin.y + masterFrame.size.height *0.32f, 
                                  masterFrame.size.height*0.15, 
                                  masterFrame.size.height*0.15f);
    [_moreButton setFrame:moreFrame];
    [self addControl:_moreButton];
    
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
    
    BRTextControl *moviesControl =[[BRTextControl alloc] init];
    [moviesControl setText:@"Movies" withAttributes:[[BRThemeInfo sharedTheme]metadataSummaryFieldAttributes]];
    CGRect mf;
    mf.size = [moviesControl renderedSize];
    mf.origin.x=gframe.origin.x+masterFrame.size.width*0.05;
    mf.origin.y=gframe.origin.y+gframe.size.height+masterFrame.size.height*0.005f,
    [moviesControl setFrame:mf];
    [self addControl:moviesControl];
    [moviesControl release];
    
    BRDividerControl *div3 = [[BRDividerControl alloc]init];
    CGRect div3Frame =CGRectMake(gframe.origin.x + mf.size.width+masterFrame.size.width*0.02, 
                                 gframe.origin.y+gframe.size.height+masterFrame.size.height*0.005f,
                                 div1Frame.size.width+div1Frame.origin.x-(mf.size.width+masterFrame.size.width*0.02), 
                                 masterFrame.size.height*0.02f);
    [div3 setFrame:div3Frame];
    [self addControl:div3];
    [div3 release];

    BRCursorControl * hey = [[BRCursorControl alloc] init];
    [self addControl:hey];
    [hey release];
    
}
-(void)controlWasActivated
{
    [self drawSelf];
    [super controlWasActivated];
}
-(BOOL)brEventAction:(BREvent *)action
{
    if ([[self stack] peekController]!=self)
        return [super brEventAction:action];
    int remoteAction = [action remoteAction];
    if (self.delegate && [self.delegate conformsToProtocol:@protocol(SMFMoviePreviewControllerDelegate)]) {
    }
    if (remoteAction==kBREventRemoteActionPlay && 
        self.delegate!=nil && 
        action.value==1 && 
        [self.delegate conformsToProtocol:@protocol(SMFMoviePreviewControllerDelegate)])
    {
        [self.delegate controller:self selectedControl:[self focusedControl]];
        return YES;
    }
    return [super brEventAction:action];
        
}
-(void)dealloc
{
    [_titleControl release];
    [_subtitleControl release];
    [_summaryControl release];
    [_rating release];
    [_previewButton release];
    [_moreButton release];
    [_previewControl release];
    self.datasource=nil;
    [_playButton release];
    [_shelfControl release];
    [_queueButton release];
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
    NSArray *details = [NSArray arrayWithObjects:@"Action & Comedy",@"Released: 2010",@"Run Time: Years",[[SMFThemeInfo sharedTheme]fourPointFiveStars], nil];
    NSArray *objects = [NSArray arrayWithObjects:details,actors,directors,producers,nil];
    return objects;
}
-(NSString *)rating
{
    return @"R";
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
@end
