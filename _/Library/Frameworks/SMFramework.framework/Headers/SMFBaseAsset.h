//
//  SMFBaseAsset.h
//  SoftwareMenuFramework
//
//  Created by Thomas Cool on 2/4/10.
//  Copyright 2010 Thomas Cool. All rights reserved.
//

#import <Backrow/Backrow.h>


@interface SMFBaseAsset : BRXMLMediaAsset {
    int padding[64];
    NSMutableDictionary *_meta;
    BRImage *_image;
}
+(SMFBaseAsset *)asset;
-(void)setObject:(id)arg1 forKey:(id)arg2;
-(void)setTitle:(NSString *)title;
-(void)setSummary:(NSString *)summary;
-(void)setCustomKeys:(NSArray *)keys forObjects:(NSArray *)objects;
-(void)setCoverArt:(BRImage *)coverArt;
-(void)setCoverArtPath:(NSString *)path;
-(NSDictionary *)orderedDictionary;
@end
