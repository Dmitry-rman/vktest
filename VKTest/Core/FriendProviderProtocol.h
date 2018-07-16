//
//  FriendProviderProtocol.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#define kDataProviderChangedFriendsListNotification  @"kDataProviderChangedFriendsListNotification"

@class VKFriendData;

@protocol FriendProviderProtocol <NSObject>
- (void) getFriendInfoByID: (NSNumber*) friendID
            WithCompletion: (void(^)(VKFriendData *friendInfo)) completionHandler
                     Error: (void(^)(NSError *error)) errorHandler;
- (void) prepareWithCompletion: (void(^)(void)) completion
                          Fail: (void(^)(NSString *failMessage)) failHandler;
- (NSArray<VKFriendData*>*) friends;
- (void) reloadFriendList;
@end
