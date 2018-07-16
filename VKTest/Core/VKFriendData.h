//
//  VKFriendData.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    UserSex_unknown = 0,
    UserSex_man = 1,
    UserSex_woman = 2,
} UserSex;

@interface VKFriendData : NSObject

@property (nonatomic, readonly) NSNumber *userID;
@property (nonatomic, readonly) BOOL isOnline;
@property (nonatomic, readonly) NSString *name;
@property (nonatomic, readonly) NSString *vizitText;
@property (nonatomic, readonly) NSString *infoText;
@property (nonatomic, readonly) NSURL *photoImageURL;
@property (nonatomic, readonly) BOOL isYourFriend;
@property (nonatomic, readonly) NSDictionary *statCounters;

- (instancetype) initWithName: (NSString*) name
                       UserID: (NSNumber*) userID
                       Online: (BOOL) online
                          Sex: (UserSex) sex
                      Vizited: (NSNumber*) vizited
                         Info: (NSString*) info
               PhotoURLString: (NSString*) photoUrlString
                     Counters: (NSDictionary*) counters
                    AndFriend:(BOOL) isFriend;

@end
