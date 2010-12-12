//
//  SMFDebAsset.m
//  SMFramework
//
//  Created by Thomas Cool on 12/12/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFDebAsset.h"


@implementation SMFDebAsset
-(id)initWithPath:(NSString *)path
{
    if ([[path pathExtension] localizedCaseInsensitiveCompare:@"deb" ]!=NSOrderedSame)
        return nil;
    self=[super init];
    if (self!=nil) {
        char line[200];
        
        NSString *commandString = [NSString stringWithFormat:@"dpkg-deb -I %@",path,nil];
        FILE* fp = popen([commandString UTF8String], "r");
        NSMutableArray *lines = [[NSMutableArray alloc]init];
        if (fp)
        {
            while (fgets(line, sizeof line, fp))
            {
                NSString *s = [NSString stringWithCString:line];
                [lines addObject:s];
                NSLog(@"%@",s);
            }
        }
        pclose(fp);
    }
    return self;
}
@end
