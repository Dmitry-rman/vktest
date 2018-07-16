//
//  VKTestTableViewController.m
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import "VKTestTableViewController.h"


@interface VKTestTableViewController () <UITableViewDelegate, UITableViewDataSource>{
 
}

@end

@implementation VKTestTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self configurateTable];
}

- (void) configurateTable{
    _tableConfig = [JMSTableViewConfig new];
}


#pragma mark - UITableView -

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_tableConfig numberOfSections];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableConfig numberOfRowsInSection:section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewAutomaticDimension;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self cellAtIndexPath:indexPath];
}

- (NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return [_tableConfig headerTextInSection: section];
}

- (NSString*) tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return  [_tableConfig footerTextInSection: section];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return UITableViewAutomaticDimension;
}

#pragma mark -
- (UITableViewCell*) cellAtIndexPath: (NSIndexPath*) indexPath{
    NSAssert( YES, @"cell is not configured");
    return nil;
}
@end
