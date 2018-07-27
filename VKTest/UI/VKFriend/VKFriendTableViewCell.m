//
//  VKFriendTableViewCell.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev

#import "VKFriendTableViewCell.h"
#import "VKTest-Swift.h"

#import <AFNetworking/UIImageView+AFNetworking.h>

@implementation VKFriendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.photoImageView.layer.cornerRadius =  self.photoImageView.bounds.size.width/2;
    self.photoImageView.layer.masksToBounds = YES;
}

- (void) updateWithFriendInfo: (VKFriendData*) friendData{
    if(friendData){
        self.friendNameLabel.text = friendData.name;
        [self.photoImageView setImageWithURL: friendData.photoImageURL
                            placeholderImage: [UIImage imageNamed: @"empty_avatar"]];
    }
}
@end
