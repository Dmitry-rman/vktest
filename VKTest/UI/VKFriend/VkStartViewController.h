//
//  VkStartViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//


#import "VKBaseViewController.h"
#import "FriendProviderProtocol.h"

@interface VkStartViewController : VKBaseViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@end
