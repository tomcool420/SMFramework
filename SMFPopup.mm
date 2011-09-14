#line 1 "/Users/kevinbradley/DVLP/SMFramework/SMFPopup.xm"
















#import "SMFPopup.h"
#include <substrate.h>
@class SMFPopupInfo; @class BRTrackInfoControl; 
static Class $SMFPopupInfo; 
#line 18 "/Users/kevinbradley/DVLP/SMFramework/SMFPopup.xm"


static id (*__ungrouped$SMFPopupInfo$_fetchCoverArt)(SMFPopupInfo*, SEL);static id $_ungrouped$SMFPopupInfo$_fetchCoverArt(SMFPopupInfo* self, SEL _cmd) {
    return [[BRThemeInfo sharedTheme] appleTVIcon];
}

static void (*__ungrouped$SMFPopupInfo$_updateTrackInfo)(SMFPopupInfo*, SEL);static void $_ungrouped$SMFPopupInfo$_updateTrackInfo(SMFPopupInfo* self, SEL _cmd) {
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
        {
            
            [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];
        }
            
        
    }
    else
        [l setLines:[NSArray arrayWithObjects:@"error",nil] withImage:[self _fetchCoverArt]];


    
}

static __attribute__((constructor)) void _logosLocalInit() { NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init]; {{ $SMFPopupInfo = objc_allocateClassPair(objc_getClass("BRTrackInfoControl"), "SMFPopupInfo", 0); objc_registerClassPair($SMFPopupInfo); Class $$SMFPopupInfo = objc_getClass("SMFPopupInfo"); MSHookMessageEx($$SMFPopupInfo, @selector(_fetchCoverArt), (IMP)&$_ungrouped$SMFPopupInfo$_fetchCoverArt, (IMP*)&__ungrouped$SMFPopupInfo$_fetchCoverArt);MSHookMessageEx($$SMFPopupInfo, @selector(_updateTrackInfo), (IMP)&$_ungrouped$SMFPopupInfo$_updateTrackInfo, (IMP*)&__ungrouped$SMFPopupInfo$_updateTrackInfo);}}  [pool drain]; }
