//
//  SMFPopup.xm
//  SMFramework
//
//  Created by Thomas Cool on 11/20/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//



%subclass SMFPopupInfo : BRTrackInfoControl
- (id)_fetchCoverArt
{

    return [[BRThemeInfo sharedTheme] appleTVIcon];
}
- (void)_updateTrackInfo
{
    id l = MSHookIvar<BRTrackInfoLayer *>(self, "_layer");
        NSLog(@"object: %@",[self object]);
    id obj=[self object];
    if(obj!=nil && [obj isKindOfClass:[NSDictionary class]] && [obj objectForKey:@"Image"] && [obj objectForKey:@"Lines"])
    {
        NSLog(@"all good");
        [l setLines:[obj objectForKey:@"Lines"] withImage:[obj objectForKey:@"Image"]];
    }
    else
        [l setLines:[NSArray arrayWithObjects:@"one",@"two",nil] withImage:[self _fetchCoverArt]];
    NSLog(@"layer: %@",l);

    //%orig;
}
%end