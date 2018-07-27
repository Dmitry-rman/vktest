//
//  VkStartViewController.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VkStartViewController.h"
#import "VKFriendsViewController.h"
#import "VKTest-Swift.h"

static NSString *const kVkFriendsSegue = @"vkFriendsSegue";

@interface VkStartViewController (){
 
}

@end

@implementation VkStartViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark Actions

- (IBAction) enterButtonTap:(id)sender{
    
    __weak typeof(self) weakSelf = self;
    [_dataProvider prepareWithCompletion:^{
         [weakSelf performSegueWithIdentifier: kVkFriendsSegue sender: weakSelf];
    } fail:^(NSString * _Nonnull failMessage) {
        [weakSelf showMessage: failMessage
                    WithTitle: NSLocalizedString(@"Error on VK authorization. Please, try again.", nil)];
    }];
}

#pragma mark Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString: kVkFriendsSegue]){
        VKFriendsViewController* controller = (VKFriendsViewController*)segue.destinationViewController;
        controller.dataProvider = _dataProvider;
    }
}
@end
