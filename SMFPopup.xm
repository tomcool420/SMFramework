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
    id obj=[self object];
    if(obj!=nil && [obj isKindOfClass:[NSDictionary class]])
    {
        if([obj objectForKey:@"Image"])
        {
            if([obj objectForKey:@"Lines"])
                [l setLines:[obj objectForKey:@"Lines"] withImage:[obj objectForKey:@"Image"]];
            else
                [l setImage:[obj objectForKey:@"Image"]];
        }
        else
            [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];
        
    }
    else
        [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];

    //%orig;
}
%end