//
//  ViewController.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKFriendViewController.h"
#import "JMSTableViewConfig.h"
#import "VKTestProfileCell.h"
#import "LGRefreshView.h"
#import "VKTest-Swift.h"

static NSString *const kProfilCellID = @"profileCellID";

typedef NS_ENUM(NSInteger, VKFriendRowIdentifier) {
    VKFriendRowIdentifierPersonalInfo,
};

typedef NS_ENUM(NSInteger, VKFriendSectionIdentifier) {
    VKFriendSectionIdentifierPersonalInfo,
};

@interface VKFriendViewController (){
    
}
@property (strong, nonatomic) LGRefreshView *refreshView;
@end

@implementation VKFriendViewController

- (void) awakeFromNib{
    [super  awakeFromNib];
    NSLog(@"%s",  __PRETTY_FUNCTION__);
}

- (void) viewDidLoad{
    [super viewDidLoad];
    
    self.navigationItem.title = self.friendInfo.name;
}

- (void) configurateTable{
    
    [super configurateTable];
   
    __weak typeof(self) weakSelf = self;
   
    [_tableConfig appendSectionWithIdentifier: VKFriendSectionIdentifierPersonalInfo
                                   completion:^(JMSTableViewSection *section) {
        section.footerText =  @"";
        section.headerText =  @"";
        [section appendRowWithIdentifier:VKFriendSectionIdentifierPersonalInfo
                              completion:^(JMSTableViewRow * row) {
                row.cell = [weakSelf.tableView dequeueReusableCellWithIdentifier:kProfilCellID];
        }];
    }];
    
    _refreshView = [LGRefreshView refreshViewWithScrollView: self.tableView
                                             refreshHandler:^(LGRefreshView *refreshView){
                        if (weakSelf) {
                            [weakSelf reloadData];
                        }
                    }];
    _refreshView.tintColor = self.navigationController.navigationBar.barTintColor;
    _refreshView.backgroundColor =  [UIColor clearColor];
}

- (void) reloadData{
    
    __weak typeof(self) weakSelf = self;
    
    [_dataProvider getFriendInfoWithId: @(self.friendInfo.userID.integerValue)
                             onSuccess:^(VKFriendData * _Nullable friendInfo) {
                                 weakSelf.friendInfo = friendInfo;
                                 weakSelf.navigationItem.title = friendInfo.name;
                                 
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [weakSelf.refreshView endRefreshing];
                                     [weakSelf.tableView reloadData];
                                 });
                             } onFail:^(NSError * _Nullable error) {
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [weakSelf.refreshView endRefreshing];
                                     [weakSelf showError: error];
                                 });
                             }];
}

#pragma mark Actions

- (IBAction) messageButtonClick:(id)sender{
    NSLog(@"message");
}

- (IBAction) addButtonClick:(id)sender{
    NSLog(@"add");
}

- (IBAction) infoButtonClick:(id)sender{
    NSLog(@"info");
}

#pragma mark -
//overloaded
- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

//overloaded
- (UITableViewCell*) cellAtIndexPath: (NSIndexPath*) indexPath{
    JMSTableViewRow * row = [_tableConfig rowAtIndexPath:indexPath];
    switch (row.identifier) {
        case VKFriendRowIdentifierPersonalInfo:
            [self configurateProfileCell:(VKTestProfileCell *)row.cell];
            break;
        default:
            break;
    }
    return row.cell;
}

- (void) configurateProfileCell: (VKTestProfileCell*) cell{
    [cell updateWithFriendInfo: self.friendInfo];
}

#pragma mark dealloc
- (void) dealloc{
    NSLog(@"%s",  __PRETTY_FUNCTION__);
}
@end
