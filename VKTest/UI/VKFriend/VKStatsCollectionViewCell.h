//
//  VKStatsCollectionViewCell.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev on 16/07/2018.
//  Copyright © 2018 RMan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKStatsCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *countLabel;
@end
