//
//  VKFriendsViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestTableViewController.h"
#import "VKTest-Swift.h"

@protocol FriendProviderProtocol;

@interface VKFriendsViewController : VKBaseViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@end
