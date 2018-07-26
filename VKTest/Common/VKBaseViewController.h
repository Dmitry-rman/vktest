//
//  VKBaseViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <UIKit/UIKit.h>

@interface VKBaseViewController : UIViewController

- (void) showError: (NSError*) error;
- (void) showMessage: (NSString*) message WithTitle: (NSString*) tittle;
- (void) showBusy;
- (void) hideBusy;
@end
