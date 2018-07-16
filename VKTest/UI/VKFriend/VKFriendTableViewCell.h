//
//  VKFriendTableViewCell.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <UIKit/UIKit.h>

@class VKFriendData;

@interface VKFriendTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UILabel *friendNameLabel;
- (void) updateWithFriendInfo: (VKFriendData*) friendData;
@end
