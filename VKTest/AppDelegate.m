//
//  AppDelegate.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev

#import "AppDelegate.h"
#import "VKSdk.h"
#import "VKDataProvider.h"
#import "VKFriendsViewController.h"
#import "VkStartViewController.h"

@interface AppDelegate (){
  
}

@property (nonatomic, strong) VKDataProvider *dataProvider;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    _dataProvider = [VKDataProvider new];
    UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
    
    __weak typeof(self) weakSelf = self;
    [_dataProvider prepareWithCompletion:^{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
        VKFriendsViewController *controller =  (VKFriendsViewController*)[storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([VKFriendsViewController class])];
        controller.dataProvider = weakSelf.dataProvider;
        navController.viewControllers = @[controller];
        [self.window makeKeyAndVisible];
    }
                                    Fail:^(NSString *failMessage) {
                                        [weakSelf showMessage: failMessage
                                                    WithTitle: NSLocalizedString(@"Error on VK authorization. Please, try again.", nil)];
                                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
                                        VkStartViewController *controller =  (VkStartViewController*)[storyboard instantiateViewControllerWithIdentifier:NSStringFromClass([VkStartViewController class])];
                                        controller.dataProvider = weakSelf.dataProvider;
                                        navController.viewControllers = @[controller];
                                    }];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

//iOS 9 workflow
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options {
    [VKSdk processOpenURL:url fromApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]];
    return YES;
}

- (void) showError:(NSError *)error{
    [self showMessage:error.localizedDescription
            WithTitle:NSLocalizedString(@"Error", nil)];
}

- (void) showMessage: (NSString*) message WithTitle: (NSString*) tittle{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle: tittle
                                                                             message: message
                                                                      preferredStyle: UIAlertControllerStyleAlert];
    [self.window.rootViewController presentViewController: alertController
                                                 animated: YES
                                               completion: nil];
}

@end
