//
//  VKDataProvider.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <Foundation/Foundation.h>
#import "FriendProviderProtocol.h"

@class VKSdk;
@class VKFriendData;

@interface VKDataProvider : NSObject <FriendProviderProtocol>

@property (nonatomic, readonly) VKSdk *vkSDK;
@end
