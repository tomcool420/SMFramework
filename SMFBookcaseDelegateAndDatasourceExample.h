//
//  SMFBookcaseDelegateAndDatasourceExample.h
//  SMFramework
//
//  Created by Chris Jensen on 2/26/11.
//

#import "SMFBookcaseController.h"

@interface SMFBookcaseDelegateAndDatasourceExample : NSObject <SMFBookcaseControllerDatasource, SMFBookcaseControllerDelegate> {

}

@end


/* Example of setup:
 
	SMFBookcaseDelegateAndDatasourceExample *example = [[SMFBookcaseDelegateAndDatasourceExample alloc] init];
	SMFBookcaseController *bookcaseController = [[SMFBookcaseController alloc] init];
	bookcaseController.delegate = example;
	bookcaseController.datasource = example;
	[[[BRApplicationStackManager singleton] stack] pushController:bookcaseController];
	[bookcaseController release];
*/