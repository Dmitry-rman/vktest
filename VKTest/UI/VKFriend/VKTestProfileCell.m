//
//  VKTestProfileCell.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestProfileCell.h"
#import "VKFriendData.h"
#import "VKStatsCollectionViewCell.h"

@interface VKTestProfileCell()   <UICollectionViewDelegate, UICollectionViewDataSource>{
    VKFriendData *_friendData;
    UIFont *_counterStatTitleFont;
    UIFont *_counterStatFont;
}

@property (nonatomic, weak) IBOutlet UICollectionView *statCollectionView;
@end

@implementation VKTestProfileCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.addButton.layer.cornerRadius = self.addButton.bounds.size.height/2;
    self.messageButton.layer.cornerRadius = self.messageButton.bounds.size.height/2;
    
    _counterStatTitleFont = [UIFont systemFontOfSize: 13.0f];
    _counterStatFont = [UIFont systemFontOfSize: 17.0f];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) updateWithFriendInfo: (VKFriendData*) friendData{
    _friendData = friendData;
    [super updateWithFriendInfo: friendData];
    
    self.vizitTimeLabel.text = friendData.vizitText;
    self.infoLabel.text = friendData.infoText;
    
    [self.messageButton setTitle: NSLocalizedString(@"Сообщение", nil) forState: UIControlStateNormal];
    
    if(friendData.isYourFriend){
        [self.addButton setTitle: NSLocalizedString(@"У вас в друзьях", nil) forState: UIControlStateNormal];
        self.addButton.backgroundColor = [UIColor grayColor];
    }
    else{
        [self.addButton setTitle: NSLocalizedString(@"Добавить в друзья", nil) forState: UIControlStateNormal];
        self.addButton.backgroundColor = self.messageButton.backgroundColor;
    }
    
    self.onlineLabel.text = friendData.isOnline == YES ? NSLocalizedString(@"online", nil) :  NSLocalizedString(@"offline", nil);
    [self.statCollectionView reloadData];
}


#pragma mark UICollectionView DataSource

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView
      numberOfItemsInSection:(NSInteger)section{
    return _friendData.statCounters.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                           cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    VKStatsCollectionViewCell *cell  = [collectionView dequeueReusableCellWithReuseIdentifier: @"infoCellID"
                                                                                  forIndexPath: indexPath];
    
    NSString *statKey =  _friendData.statCounters.allKeys[indexPath.row];
    cell.titleLabel.text = statKey;
    cell.countLabel.text = _friendData.statCounters[statKey];
    cell.countLabel.font = _counterStatFont;
    cell.titleLabel.font = _counterStatTitleFont;
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *statKey =  _friendData.statCounters.allKeys[indexPath.row];
    NSString *testString = _friendData.statCounters[statKey];

    CGSize statTitleSize =[statKey sizeWithAttributes: @{ NSFontAttributeName : _counterStatTitleFont}];
    CGSize statCounterSize = [testString sizeWithAttributes: @{ NSFontAttributeName : _counterStatFont}];
    
    return CGSizeMake( MAX(statTitleSize.width, statCounterSize.width), 50.f);
}
@end
