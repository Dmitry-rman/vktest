//
//  VkStartViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//


#import "VKBaseViewController.h"
#import "VKTest-Swift.h"

@protocol FriendProviderProtocol;

@interface VkStartViewController : VKBaseViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@end
