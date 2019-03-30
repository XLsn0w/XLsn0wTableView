/*********************************************************************************************
 *   __      __   _         _________     _ _     _    _________   __         _         __   *
 *   \ \    / /  | |        | _______|   | | \   | |  |  ______ |  \ \       / \       / /   *
 *    \ \  / /   | |        | |          | |\ \  | |  | |     | |   \ \     / \ \     / /    *
 *     \ \/ /    | |        | |______    | | \ \ | |  | |     | |    \ \   / / \ \   / /     *
 *     /\/\/\    | |        |_______ |   | |  \ \| |  | |     | |     \ \ / /   \ \ / /      *
 *    / /  \ \   | |______   ______| |   | |   \ \ |  | |_____| |      \ \ /     \ \ /       *
 *   /_/    \_\  |________| |________|   |_|    \__|  |_________|       \_/       \_/        *
 *                                                                                           *
 *********************************************************************************************/
#import "XLsn0wTableViewController.h"

@interface XLsn0wTableViewController () <XLsn0wTableViewCellForRowDelegate>

@property (nonatomic, strong) XLsn0wTableView *tableView;
@property (nonatomic, strong) NSMutableArray *datas;

@end

@implementation XLsn0wTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[XLsn0wTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = UIColor.lightGrayColor;
    [_tableView registerClass:[XLsn0wTableViewCell class] forCellReuseIdentifier:@"XLsn0wTableViewCell"];
    self.tableView.dataArray = [NSMutableArray arrayWithObjects:@"1", @"2", nil];
    self.tableView.cellHeight = 80;
    self.tableView.cellForRowDelegate = self;
}

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLsn0wTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"XLsn0wTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColor.redColor;
    return cell;
}

@end
