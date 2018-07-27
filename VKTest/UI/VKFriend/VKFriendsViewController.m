//
//  VKFriendsViewController.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKFriendsViewController.h"
#import "LGRefreshView.h"
#import "VKFriendViewController.h"
#import "VKFriendTableViewCell.h"
#import "VKTest-Swift.h"

#define kDataProviderChangedFriendsListNotification @"kDataProviderChangedFriendsListNotification"
static NSString *const kVkFriendInfoSegue = @"vkFriendInfoSegue";
static NSString *const kVKFriendCellID = @"vkFriendCellID";

@interface VKFriendsViewController () <UITableViewDelegate, UITableViewDataSource>{
    NSArray<VKFriendData*> *_friends;
}

@property (strong, nonatomic) LGRefreshView *refreshView;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@end

@implementation VKFriendsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    __weak typeof(self) weakSelf = self;
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(reloadData)
                                                 name: kDataProviderChangedFriendsListNotification
                                               object: nil];
    
    _refreshView = [LGRefreshView refreshViewWithScrollView: self.tableView
                                             refreshHandler:^(LGRefreshView *refreshView){
                                                 if (weakSelf) {
                                                     [weakSelf.dataProvider reloadFriendList];
                                                 }
                                             }];
    _refreshView.tintColor = self.navigationController.navigationBar.barTintColor;
    _refreshView.backgroundColor =  [UIColor clearColor];
    
    [_refreshView triggerAnimated: YES];
}

- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear: animated];

    [self.tableView deselectRowAtIndexPath: self.tableView.indexPathForSelectedRow animated: YES];
}

- (void) reloadData{
    [self.tableView reloadData];
    [self.refreshView endRefreshing];
}

#pragma mark TableView DataSource

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataProvider.friends.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    VKFriendData *friendInfo = _dataProvider.friends[indexPath.row];
    VKFriendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: kVKFriendCellID];
    [cell updateWithFriendInfo: friendInfo];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
   
    __weak typeof(self) weakSelf = self;
    VKFriendData *friendInfo = _dataProvider.friends[indexPath.row];
    [self showBusy];
    [self.dataProvider getFriendInfoWithId: @(friendInfo.userID.integerValue)
                                 onSuccess:^(VKFriendData * _Nullable friendInfo) {
        [weakSelf showFriend: friendInfo];
        [weakSelf hideBusy];
    } onFail: nil];
   /*
                          [weakSelf showError: error];
                          [weakSelf hideBusy];
               */
    
}

#pragma mark -

- (void) showFriend: (VKFriendData *) friendInfo{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    VKFriendViewController* controller = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([VKFriendViewController class])];
    controller.dataProvider = self.dataProvider;
    controller.friendInfo = friendInfo;
    [self.navigationController pushViewController: controller animated: YES];
}

#pragma mark dealloc
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: kDataProviderChangedFriendsListNotification
                                                  object: nil];
}
@end
