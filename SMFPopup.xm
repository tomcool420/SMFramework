//
//  SMFPopup.xm
//  SMFramework
//
//  Created by Thomas Cool on 11/20/10.
//  Copyright 2010 tomcool.org. All rights reserved.
//
//%hook BRTrackInfoControl
//-(void)_updateCoverArt:(id)art
//{
//    NSLog(@"art: %@",art);
//    return %orig;
//
//}
//%end

#import "SMFPopup.h"
%subclass SMFPopupInfo : BRTrackInfoControl
- (id)_fetchCoverArt
{
    return [[BRThemeInfo sharedTheme] appleTVIcon];
}
- (void)_updateTrackInfo
{
    id l = MSHookIvar<BRTrackInfoLayer *>(self, "_layer");
    //BRImageControl *_layerArt = MSHookIvar<BRImageControl *>(l,"_art");
    id obj=[self object];
    if(obj!=nil && [obj isKindOfClass:[NSDictionary class]])
    {
        //NSLog(@"obj: %@",obj);
        if([obj objectForKey:@"Image"])
        {
            //[self _updateCoverArt:[obj objectForKey:@"Image"]];
            if([obj objectForKey:@"Lines"])
                [l setLines:[obj objectForKey:@"Lines"] withImage:[obj objectForKey:@"Image"]];
            else
                [l setImage:[obj objectForKey:@"Image"]];
            //[_layerArt setImage:[obj objectForKey:@"Image"]];
        }
        else
        {
            //[self _updateCoverArt:[self _fetchCoverArt]];
            [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];
        }
            
        
    }
    else
        [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];
//    [l _updateSublayers];
//    [l layoutSubcontrols];
    //%orig;
}
%end