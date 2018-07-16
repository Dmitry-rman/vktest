//
//  VKFriendData.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKFriendData.h"
#import "NSDate+Helper.h"

@implementation VKFriendData


- (instancetype) initWithName: (NSString*) name
                       UserID: (NSNumber*) userID
                       Online: (BOOL) online
                          Sex: (UserSex) sex
                      Vizited: (NSNumber*)vizited
                         Info: (NSString*) info
               PhotoURLString: (NSString*) photoUrlString
                     Counters: (NSDictionary*) counters
                    AndFriend:(BOOL) isFriend{
    
    if (self = [super init]){
        _name = name;
        _isOnline = online;
        _userID = userID;
         NSDate *vizitDate = [NSDate dateWithTimeIntervalSince1970: vizited.doubleValue];
        _vizitText = [NSString stringWithFormat: NSLocalizedString(@"заходил%@ %@", nil), sex == UserSex_woman? @"а" : @"", [vizitDate string]];
        _infoText = info;
        _photoImageURL = [NSURL URLWithString: photoUrlString];
        _isYourFriend = isFriend;
        _statCounters = counters;
    }
    
    return self;
}

@end
