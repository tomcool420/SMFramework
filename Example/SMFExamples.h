//
//  SMFExamples.h
//  SMFramework
//
//  Created by Thomas Cool on 7/13/11.
//  Copyright 2011 tomcool.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "../SMFramework.h"
#import "../SMFBookcaseController.h"
#import "SMFGridController.h"
@interface SMFExamples : NSObject<SMFPasscodeControllerDelegate>{
    
}
+(SMFExamples *)examples;
-(SMFBookcaseController *)bookcase;
-(SMFMoviePreviewController *)moviePreview;
-(SMFGridController *)grid;
-(SMFPhotoBrowserController *)photoBrowser;
-(void)push:(BRController *)ctrl;
-(SMFFolderBrowser *)browseFolder;
-(SMFPasscodeController *)passcode;
-(SMFControllerPasscodeController *)controllerPasscode;

-(NSArray *)titles;
-(NSArray *)identifiers;
-(BRController *)controllerForIdentifier:(NSString *)identifier;


#pragma mark delegate methods
-(void)passcodeTextDidEndEditing:(id)sender;
@end
