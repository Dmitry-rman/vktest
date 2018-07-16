//
//  VKTestTableViewController.h
//  VKTest
//
//  Created by Dmitry Kudryavtsev
//

#import <UIKit/UIKit.h>
#import "JMSTableViewConfig.h"
#import "VKBaseViewController.h"

@interface VKTestTableViewController : VKBaseViewController{
    JMSTableViewConfig *_tableConfig;
}

@property (nonatomic, strong) IBOutlet UITableView *tableView;

- (void) configurateTable;
- (UITableViewCell*) cellAtIndexPath: (NSIndexPath*) indexPath;
@end
