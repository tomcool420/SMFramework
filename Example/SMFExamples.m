//
//  SMFExamples.m
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import "SMFExamples.h"
#import "../SMFBookcaseController.h"
#import "SMFBookcaseDelegateAndDatasourceExample.h"
#import "../SMFMoviePreviewController.h"
#import "SMFMoviePreviewDelegateAndDatasourceExample.h"
#import "../SMFramework.h"
NSString * const kSMFExampleBookcase    =@"SMFExampleBookcase";
NSString * const kSMFExampleMovie       =@"SMFExampleMovie";
NSString * const kSMFExampleGrid        =@"SMFExampleGrid";
NSString * const kSMFExamplePhotoBrowser=@"SMFExamplePhotoBrowser";
NSString * const kSMFExamplePasscode    =@"SMFExamplePasscode";
NSString * const kSMFExampleCtrllerP    =@"SMFExampleControllerPasscode";
NSString * const kSMFExampleFileBrowser =@"SMFExampleFileBrowser";
@implementation SMFExamples

SYNTHESIZE_SINGLETON_FOR_CLASS(SMFExamples, examples)
-(SMFBookcaseController *)bookcase
{
    SMFBookcaseController *c = [[SMFBookcaseController alloc]init ];
    SMFBookcaseDelegateAndDatasourceExample *d = [[SMFBookcaseDelegateAndDatasourceExample alloc] init];
    [c setDelegate:d];
    [c setDatasource:d];
    [d autorelease];
    return [c autorelease];
}
-(SMFMoviePreviewController *)moviePreview
{
    SMFMoviePreviewController *c = [[SMFMoviePreviewController alloc]init];
    SMFMoviePreviewDelegateAndDatasourceExample *e = [[SMFMoviePreviewDelegateAndDatasourceExample alloc]init];
    [c setDelegate:e];
    [c setDatasource:e];
    [e autorelease];
    return [c autorelease];
}
-(SMFGridController *)grid
{
    return [[[SMFGridController alloc]initWithPath:nil]autorelease];
}
-(SMFPhotoBrowserController *)photoBrowser
{
    BRDataStore *store = [SMFPhotoMethods dataStoreForPath:@"/System/Library/PrivateFrameworks/AppleTV.framework/DefaultAnimalPhotos/"];
    BRPhotoControlFactory* controlFactory = [BRPhotoControlFactory standardFactory];
    SMFPhotoCollectionProvider* provider    = [SMFPhotoCollectionProvider providerWithDataStore:store controlFactory:controlFactory];//[[ATVSettingsFacade sharedInstance] providerForScreenSaver];//[collection provider];
    SMFPhotoBrowserController* pc  = [SMFPhotoBrowserController controllerForProvider:provider];
    [pc setTitle:@"DefaultAnimalPhotos"];
    return pc;

}
-(SMFFolderBrowser *)browseFolder
{
    SMFFolderBrowser *f = [[SMFFolderBrowser alloc] initWithPath:@"/var/mobile"];
    return [f autorelease];
}
-(SMFPasscodeController *)passcode
{
    SMFPasscodeController *p = [SMFPasscodeController passcodeWithTitle:@"Passcode" withDescription:@"This is a test Passcode Controller" withBoxes:5 withDelegate:self];
    return p;
}
-(void)push:(BRController *)ctrl
{
    [[[BRApplicationStackManager singleton] stack] pushController:ctrl];
}
-(SMFControllerPasscodeController *)controllerPasscode
{
    SMFFolderBrowser *f = [[[SMFFolderBrowser alloc] initWithPath:@"/var/mobile"] autorelease];
    SMFControllerPasscodeController *c = [SMFControllerPasscodeController controllerPasscodeControllerForController:f withPasscode:1000];
    c.description=@"Passcode required to block access to certain menus... can be used for parental checks. Code in this case is 1000";
    c.boxes=5;
    c.title=@"Controller Passcode Controller";
    return c;
}
#pragma mark delegate methods
-(void)passcodeTextDidEndEditing:(id)sender
{
    NSString *value= [sender stringValue];
    BRAlertController *al = [BRAlertController alertOfType:0 titled:@"Passcode" primaryText:value secondaryText:@"was entered in the demo controller"];
    [[[BRApplicationStackManager singleton]stack]swapController:al];
}
#pragma mark management
-(NSArray *)identifiers
{
    return [NSArray arrayWithObjects:
            kSMFExampleBookcase,
            kSMFExampleMovie,
            kSMFExampleGrid,
            kSMFExamplePhotoBrowser,
            kSMFExamplePasscode,
            kSMFExampleCtrllerP, 
            kSMFExampleFileBrowser,
            nil];
}
-(NSArray *)titles
{
    return [self identifiers];
}
-(BRController *)controllerForIdentifier:(NSString *)identifier
{
#define iETS(two) if([identifier isEqualToString:(two)])
    iETS( kSMFExampleBookcase)
        return [self bookcase];
    else iETS(kSMFExampleMovie)
        return [self moviePreview];
    else iETS(kSMFExampleGrid)
        return [self grid];
    else iETS(kSMFExamplePhotoBrowser)
        return [self photoBrowser];
    else iETS(kSMFExamplePasscode)
        return [self passcode];
    else iETS(kSMFExampleCtrllerP)
        return [self controllerPasscode];
    else iETS(kSMFExampleFileBrowser)
        return [self browseFolder];
    return nil;
}
@end
