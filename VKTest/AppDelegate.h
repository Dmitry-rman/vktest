//
//  AppDelegate.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) showError: (NSError*) error;
- (void) showMessage: (NSString*) message
           WithTitle: (NSString*) tittle;
- (void) showMessage: (NSString*) message
           WithTitle: (NSString*) tittle
       AndCompletion: (void(^)(void)) completion;
@end

