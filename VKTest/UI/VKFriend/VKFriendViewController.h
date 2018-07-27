//
//  ViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestTableViewController.h"
#import "VKTest-Swift.h"

@class VKFriendData;
@protocol FriendProviderProtocol;

@interface VKFriendViewController : VKTestTableViewController

@property (strong, nonatomic) NSObject <FriendProviderProtocol> *dataProvider;
@property (strong, nonatomic) VKFriendData *friendInfo;
@end

