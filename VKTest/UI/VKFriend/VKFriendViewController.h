//
//  ViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestTableViewController.h"
#import "FriendProviderProtocol.h"

@class VKFriendData;

@interface VKFriendViewController : VKTestTableViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@property (strong, nonatomic) VKFriendData *friendInfo;
@end

