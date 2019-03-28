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
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSAssert([self.groupArray[indexPath.section] isKindOfClass:[NSArray class]], @"groupArray中的数据必须是数组类型");

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    
    if (self.groupArray.count > indexPath.section &&
            [self.groupArray[indexPath.section] count]) {
        id dataModel = [self.groupArray[indexPath.section] objectAtIndex:indexPath.row];
        
        //这里的setDataModel：是更新cell数据模型的方法，可自行定义，可参考FCXTableViewCell
#pragma clang diagnostic push
#pragma clang diagnostic ignored"-Wundeclared-selector"
        if ([cell respondsToSelector:@selector(setDataModel:)]) {
            [cell performSelectorOnMainThread:@selector(setDataModel:) withObject:dataModel waitUntilDone:NO];
        }
#pragma clang diagnostic pop
    }
    return cell;
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
