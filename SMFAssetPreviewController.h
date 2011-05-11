//
//  SMFAssetPreviewController.h
//  SMFramework
//
//  Created by Thomas Cool on 2/8/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFMoviePreviewController.h"
#import <BackRow/BackRow.h>

@interface SMFAssetPreviewController : SMFMoviePreviewController {
    BRBaseMediaAsset * asset;
}
@property (retain) BRBaseMediaAsset *asset;
@end
