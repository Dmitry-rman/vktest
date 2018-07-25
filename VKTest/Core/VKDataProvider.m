//
//  VKDataProvider.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKDataProvider.h"
#import "VKSdk.h"
#import "VKFriendData.h"
#import "VKUser.h"

static NSString *const VK_APP_ID = @"6631966";
static NSString *const vkFriendFields = @"id,first_name,last_name,city,country,photo_100,online,online_mobile,lists,contacts,connections,status,last_seen,common_count,relation,relatives,counters,sex";

typedef void(^VKPrepareSuccessHandler)(void);
 typedef void(^VKPrepareFailHandler)(NSString *failMessage);

@interface VKDataProvider() <VKSdkDelegate>{
   NSMutableArray *_friends;
}

@property (nonatomic, strong) VKPrepareSuccessHandler vkPrepareSuccessHandler;
@property (nonatomic, strong) VKPrepareFailHandler vkPrepareFailHandler;
@end

@implementation VKDataProvider

- (instancetype) init{
    
    if (self  = [super init]){
        _vkSDK = [VKSdk initializeWithAppId:VK_APP_ID];
        [_vkSDK registerDelegate: self];
        _friends = [NSMutableArray array];
    }
   
    return self;
}

#pragma mark FriendProviderProtocol

- (void) getFriendInfoByID: (NSNumber*) friendID
            WithCompletion: (void(^)(VKFriendData *friendInfo)) completionHandler
                     Error: (void(^)(NSError *error)) errorHandler{
    
   
    [[[VKApi users] get: @{ VK_API_FIELDS : vkFriendFields,
                            VK_API_USER_IDS : friendID.stringValue }] executeWithResultBlock:^(VKResponse *response) {
        VKUser * user = ((VKUsersArray*)response.parsedModel).firstObject;
        VKFriendData *infoData = nil;
        if(user){
           infoData = [ self friendDataFromUser: user];
        }
        if(completionHandler)completionHandler(infoData);
    } errorBlock:^(NSError *error) {
         if(errorHandler) errorHandler(error);
    }];
}

- (void) prepareWithCompletion: (void(^)(void)) completion
                          Fail: (void(^)(NSString *failMessage)) failHandler{
    
    NSArray *scope = @[VK_PER_FRIENDS, VK_PER_STATUS];
    __weak typeof(self) weakSelf = self;
    
    [VKSdk wakeUpSession: scope
           completeBlock:^(VKAuthorizationState state, NSError *err) {
        
               switch (state) {
                   case VKAuthorizationAuthorized:
                       // authorized
                       if(completion)completion();
                       break;
                   
                   case VKAuthorizationInitialized:
                       // User not yet authorized, proceed to next step
                       weakSelf.vkPrepareFailHandler = failHandler;
                       weakSelf.vkPrepareSuccessHandler = completion;
                       [VKSdk authorize:scope];
                       break;
                       
                   default:
                       if(failHandler)failHandler(NSLocalizedString(@"Error on VK authorization, Please, try later.", nil));
                       break;
               }}];
}

- (NSArray<VKFriendData*>*) friends{
    return _friends;
}

- (void) reloadFriendList{
    
    [[[VKApi friends] get:@{ VK_API_FIELDS : vkFriendFields }]
     executeWithResultBlock:^(VKResponse *response) {
         [self->_friends removeAllObjects];
         for (VKUser *vkuser in (VKUsersArray*)response.parsedModel){
             VKFriendData *infoData = [ self friendDataFromUser: vkuser];
             [self->_friends addObject: infoData];
         }
         [[NSNotificationCenter defaultCenter] postNotificationName: kDataProviderChangedFriendsListNotification
                                                             object: nil];
     } errorBlock:^(NSError *error) {
         NSLog(@"Error: %@", error);
     }];
}

- (VKFriendData*) friendDataFromUser: (VKUser*) vkuser{
    NSMutableDictionary *stats = [NSMutableDictionary dictionary];
    if(vkuser.counters){
        if(vkuser.counters.friends){
            [stats setObject: vkuser.counters.friends.stringValue forKey:NSLocalizedString(@"друзей", nil)];
        }
        if(vkuser.counters.mutual_friends){
            [stats setObject: vkuser.counters.mutual_friends.stringValue forKey:NSLocalizedString(@"общих", nil)];
        }
        if(vkuser.counters.followers){
            [stats setObject: vkuser.counters.followers.stringValue forKey:NSLocalizedString(@"подписчика", nil)];
        }
        if(vkuser.counters.user_photos){
            [stats setObject: vkuser.counters.user_photos.stringValue forKey:NSLocalizedString(@"фото", nil)];
        }
        if(vkuser.counters.audios){
            [stats setObject: vkuser.counters.audios.stringValue forKey:NSLocalizedString(@"аудио", nil)];
        }
        if(vkuser.counters.videos){
            [stats setObject: vkuser.counters.videos.stringValue forKey:NSLocalizedString(@"видео", nil)];
        }
    }
    
    VKFriendData *infoData = [[VKFriendData alloc] initWithName: [NSString stringWithFormat: @"%@%@%@",
                                                                  vkuser.first_name,
                                                                  vkuser.last_name != nil? @" " : @"",
                                                                  vkuser.last_name != nil? vkuser.last_name : @""]
                                                         UserID: vkuser.id
                                                         Online: vkuser.online.boolValue
                                                            Sex: vkuser.sex.integerValue
                                                        Vizited: vkuser.last_seen.time
                                                           Info: vkuser.city.title
                                                 PhotoURLString: vkuser.photo_100
                                                       Counters: stats
                                                      AndFriend: YES];
    return infoData;
}

- (void) clean{
    self.vkPrepareFailHandler = nil;
    self.vkPrepareSuccessHandler = nil;
}

#pragma mark VK SDK delegate

- (void)vkSdkAccessAuthorizationFinishedWithResult:(VKAuthorizationResult *)result{
    
    if (result.token) {
        if (self.vkPrepareSuccessHandler)self.vkPrepareSuccessHandler();
    } else if (result.error) {
         if(self.vkPrepareFailHandler)self.vkPrepareFailHandler(result.error.localizedDescription);
    }
    
    [self clean];
}

- (void)vkSdkUserAuthorizationFailed{

     if(self.vkPrepareFailHandler)self.vkPrepareFailHandler(NSLocalizedString(@"VK authorization error.", nil));
     [self clean];
}

#pragma mark dealloc

- (void) dealloc{
    [self clean];
}
@end
