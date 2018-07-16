//
//  VKFriendsViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestTableViewController.h"
#import "FriendProviderProtocol.h"

@interface VKFriendsViewController : VKBaseViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@end
