//
//  VKTestProfileCell.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <UIKit/UIKit.h>
#import "VKFriendTableViewCell.h"

@class VKFriendData;

@interface VKTestProfileCell : VKFriendTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *vizitTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *onlineLabel;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@end
