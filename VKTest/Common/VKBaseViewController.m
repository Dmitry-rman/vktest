//
//  VKBaseViewController.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKBaseViewController.h"
#import "AppDelegate.h"
#import "MBProgressHUD.h"

@interface VKBaseViewController (){
   
}

@end

@implementation VKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) showError:(NSError *)error{
    [(AppDelegate*)[UIApplication sharedApplication].delegate showError:error];
}

- (void) showMessage: (NSString*) message WithTitle: (NSString*) tittle{
    [(AppDelegate*)[UIApplication sharedApplication].delegate showMessage: message WithTitle:tittle];
}

- (void) showBusy{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void) hideBusy{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    });
}
@end
