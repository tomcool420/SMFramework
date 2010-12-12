//
//  SMFDebAsset.m
//  SMFramework
//
//  Created by Thomas Cool on 12/12/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//

#import "SMFDebAsset.h"
#import "SMFMediaPreview.h"
#import "SMFThemeInfo.h"


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
                NSString *s = [NSString stringWithCString:line encoding:NSUTF8StringEncoding];
                [lines addObject:s];
            }
        }
        pclose(fp);
        [self parseDebResult:lines];
        [lines release];
        [_image release];
        _image = [[[SMFThemeInfo sharedTheme] packageImage] retain];
    }
    return self;
}
-(void)parseDebResult:(NSArray *)info
{
    for(NSString *s in info)
    {
        NSArray *c = [s componentsSeparatedByString:@":"];
        if ([c count]>1) {
            NSString *key = [[c objectAtIndex:0] substringFromIndex:1];
            NSString *object = [[c objectAtIndex:1] substringFromIndex:1];
            if ([key caseInsensitiveCompare:@"Name"]==NSOrderedSame)
                [self setTitle:object];
            else if([key caseInsensitiveCompare:@"Description"]==NSOrderedSame)
                [self setSummary:object];
            else
                [_meta setObject:object forKey:key];
        }
    }
}
-(NSDictionary *)orderedDictionary
{
    NSMutableArray *orderedKeys = [[NSMutableArray alloc] init];
    NSMutableArray *objects = [[NSMutableArray alloc] init];
    NSArray *keys = [NSArray arrayWithObjects:@"Version",@"Author",@"Maintainer",@"Section",nil];
    for (NSString *key in keys) {
        if ([[_meta allKeys] containsObject:key]) {
            [orderedKeys addObject:key];
            [objects addObject:[_meta objectForKey:key]];
        }
    }
    NSMutableDictionary *a=[[NSMutableDictionary alloc] init];
    if([_meta objectForKey:METADATA_TITLE]!=nil)
        [a setObject:[_meta objectForKey:METADATA_TITLE] forKey:METADATA_TITLE];
    if([_meta objectForKey:METADATA_SUMMARY]!=nil)
        [a setObject:[_meta objectForKey:METADATA_SUMMARY] forKey:METADATA_SUMMARY];
    [a setObject:orderedKeys forKey:METADATA_CUSTOM_KEYS];
    [a setObject:objects forKey:METADATA_CUSTOM_OBJECTS];
    [orderedKeys release];
    [objects release];
    return [a autorelease];

}
@end
