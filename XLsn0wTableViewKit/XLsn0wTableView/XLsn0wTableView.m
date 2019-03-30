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
#import "XLsn0wTableView.h"

@interface XLsn0wTableView () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString *cellIdentifier;

@end

@implementation XLsn0wTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)setGroupArray:(NSMutableArray *)groupArray {
    NSAssert(groupArray, @"groupArray必须是数组类型");
    if (![groupArray isKindOfClass:[NSArray class]]) {
        return;
    }
    if (_groupArray != groupArray) {
        _groupArray = groupArray;
        [self reloadData];
    }
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    NSAssert(dataArray, @"dataArray必须是数组类型");
    if (![dataArray isKindOfClass:[NSArray class]]) {
        return;
    }
    self.groupArray = [[NSMutableArray alloc] initWithObjects:dataArray, nil];
}

- (void)registerClass:(Class)cellClass forCellReuseIdentifier:(NSString *)identifier {
    self.cellIdentifier = identifier;
    [super registerClass:cellClass forCellReuseIdentifier:identifier];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groupArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.groupArray[section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    XLsn0wTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XLsn0wTableViewCell" forIndexPath:indexPath];
//    [self configureCell:cell atIndexPath:indexPath];
//    return cell;
//}
//
//- (void)configureCell:(XLsn0wTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
//    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
//    cell.model = self.datas[indexPath.row];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(XLsn0wTableViewCell *cell) {
//        [self configureCell:cell atIndexPath:indexPath];
//    }];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([self.groupArray[indexPath.section] isKindOfClass:[NSArray class]], @"groupArray中的数据必须是数组类型");
    return [self.cellForRowDelegate cellForRowAtIndexPath:indexPath];

//    Class cla = NSClassFromString(self.cellClassString);
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
//    if (self.groupArray.count > indexPath.section &&
//            [self.groupArray[indexPath.section] count]) {
//        id dataModel = [self.groupArray[indexPath.section] objectAtIndex:indexPath.row];
//
//        //这里的addDataFromModel：是更新cell数据模型的自定义方法 传属性用set方法也行
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored"-Wundeclared-selector"
//        if ([cell respondsToSelector:@selector(addDataFromModel:)]) {
//            [cell performSelectorOnMainThread:@selector(addDataFromModel:) withObject:dataModel waitUntilDone:NO];
//        }
//#pragma clang diagnostic pop
//    }
//    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([self.groupArray[indexPath.section] isKindOfClass:[NSArray class]], @"groupArray中的数据必须是数组类型");

    if (self.groupArray.count > indexPath.section &&
        [self.groupArray[indexPath.section] count] > indexPath.row &&
        self.didSelectRowBlock) {
        
        self.didSelectRowBlock(indexPath, [self.groupArray[indexPath.section] objectAtIndex:indexPath.row]);
    }
}

@end
