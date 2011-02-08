//
//  SMFAssetPreviewController.m
//  SMFramework
//
//  Created by Thomas Cool on 2/8/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFAssetPreviewController.h"
static NSString * const kSMFMovieTitle = @"title";
static NSString * const kSMFMovieSubtitle = @"substitle";
static NSString * const kSMFMovieSummary = @"summary";
static NSString * const kSMFMoviePoster = @"poster";
static NSString * const kSMFMovieHeaders = @"headers";
static NSString * const kSMFMovieColumns = @"columns";
static NSString * const kSMFMovieRating = @"rating";

@implementation SMFAssetPreviewController
@synthesize asset;
-(NSMutableDictionary *)getInformation
{
    
    NSMutableDictionary *d = [[NSMutableDictionary alloc]initWithObjectsAndKeys:
                              @"",kSMFMovieTitle,
                              @"",kSMFMovieSubtitle,
                              @"(no summary)",kSMFMovieSummary,
                              [NSArray array],kSMFMovieHeaders,
                              [NSArray array],kSMFMovieColumns,
                              [[BRThemeInfo sharedTheme]missingImage],kSMFMoviePoster,
                              @"pg",kSMFMovieRating,
                              nil];
    if ([asset isKindOfClass:[BRBaseMediaAsset class]]) {
        
        NSString *t = [self.asset title];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieTitle];}
        
        t = [self.asset publisher];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieSubtitle];} 
        
        t = [self.asset mediaSummary];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieSummary];}
        
        NSArray *a = [NSArray arrayWithObjects:@"Details",@"Actors",@"Director",@"Producers",nil];
        [d setObject:a forKey:kSMFMovieHeaders];
        
        NSArray *cast = [self.asset cast];
        if (cast==nil) cast=[NSArray array];
        
        NSArray *directors = [self.asset directors];
        if (directors==nil) directors=[NSArray array];
        
        NSArray *producers = [self.asset producers];
        if (producers==nil) producers=[NSArray array];
        
        a=[NSArray arrayWithObjects:[NSArray array],cast,directors,producers,nil];
        [d setObject:a forKey:kSMFMovieColumns];
        
        t = [self.asset rating];
        if (t!=nil)  {[d setObject:t forKey:kSMFMovieRating];}
        
        
    }

    return [d autorelease];
    
}
@end
