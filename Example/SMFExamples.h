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
@interface SMFExamples : NSObject{
    
}
+(SMFExamples *)examples;
-(SMFBookcaseController *)bookcase;
-(SMFMoviePreviewController *)moviePreview;
-(void)push:(BRController *)ctrl;
@end
