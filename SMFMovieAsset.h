//
//  SMMovieAsset.h
//  SoftwareMenu
//
//  Created by Thomas Cool on 4/16/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//


#import <Backrow/Backrow.h>

@interface SMFMovieAsset : BRXMLMediaAsset {
    BRImage *_image;
    unsigned int		resumeTime;
}
- (id)initWithMediaURL:(NSURL *)url;
-(void)setCoverArtPath:(NSString *)path;
-(void)setMediaSummary:(NSString *)summary;
-(void)setTitle:(NSString *)title;
-(void)setResumeTime:(unsigned int)time;
-(unsigned int)resumeTime;
@end
