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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName: @"Main" bundle: nil];
    VKFriendViewController* controller = [storyboard instantiateViewControllerWithIdentifier: NSStringFromClass([VKFriendViewController class])];
    controller.dataProvider = _dataProvider;
    controller.friendInfo = _dataProvider.friends[indexPath.row];
    [self.navigationController pushViewController: controller animated: YES];
}

#pragma mark dealloc
- (void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: kDataProviderChangedFriendsListNotification
                                                  object: nil];
}
@end
