//
//  SMFImageAsset.h
//  SMFramework
//
//  Created by Thomas Cool on 12/11/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFBaseAsset.h"

@interface SMFImageAsset : SMFBaseAsset {
    NSString *_path;
}
-(id)initWithPath:(NSString *)path;
-(NSString *)fileSize;
@end
