//
//  SMFDebAsset.h
//  SMFramework
//
//  Created by Thomas Cool on 12/12/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFBaseAsset.h"


@interface SMFDebAsset : SMFBaseAsset {
    NSString *_path;
}
-(id)initWithPath:(NSString *)path;
-(void)parseDebResult:(NSArray *)info;
@end
