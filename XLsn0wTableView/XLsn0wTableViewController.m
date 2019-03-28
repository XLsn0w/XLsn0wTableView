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

@interface XLsn0wTableViewController ()

@property (nonatomic, strong) XLsn0wTableView *tableView;
@property (nonatomic, strong) UITableView *aTableView;

@property (nonatomic, strong) NSMutableArray *datas;

@property (nonatomic,strong) TableViewManager   *tabDelagate;
@property (nonatomic,strong) TableViewManager   *tabDataSource;

@end

@implementation XLsn0wTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView = [[XLsn0wTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:_tableView];
    [_tableView registerClass:[XLsn0wTableViewCell class] forCellReuseIdentifier:@"XLsn0wTableViewCell"];
}

- (void)setUIConfig {
    self.aTableView.estimatedRowHeight = 50;
    [self.aTableView registerClass:[XLsn0wTableViewCell class] forCellReuseIdentifier:@"aTableViewCell"];
    
    ///同一种cell
    self.tabDelagate = [self.aTableView JDTab_DelegateWithHeaderHeight:10
                                                          footerHeight:10
                                                           selectBlock:^(NSIndexPath *indexPath) {
                                                               NSLog(@"选中");
                                                           }];
    // 需要实现JDTableManagerDelegate 代理在cell里面
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithSource:@[@"111",@"222"] withTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
    
    //第二种方式，可以不带原数据
    self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
    [self.tabDataSource updateReloadData:@[@"111",@"222"]];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XLsn0wTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XLsn0wTableViewCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(XLsn0wTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    cell.fd_enforceFrameLayout = NO; // Enable to use "-sizeThatFits:"
    cell.model = self.datas[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView fd_heightForCellWithIdentifier:@"cell" cacheByIndexPath:indexPath configuration:^(XLsn0wTableViewCell *cell) {
        [self configureCell:cell atIndexPath:indexPath];
    }];
}

//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
//    if (!cell) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
//    }
//
//    DemoModel *model = self.datas[indexPath.row];
//    cell.textLabel.text = model.text;
//
//
//    if (model.iconImage) {
//        cell.imageView.image = model.iconImage;
//    }else{
//        cell.imageView.image = [UIImage imageNamed:@"placeholder"];
//
//        /**
//         runloop - 滚动时候 - trackingMode，
//         - 默认情况 - defaultRunLoopMode
//         ==> 滚动的时候，进入`trackingMode`，defaultMode下的任务会暂停
//         停止滚动的时候 - 进入`defaultMode` - 继续执行`trackingMode`下的任务 - 例如这里的loadImage
//         */
//        //        [self performSelector:@selector(p_loadImgeWithIndexPath:)
//        //                   withObject:indexPath afterDelay:0.0
//        //                      inModes:@[NSDefaultRunLoopMode]];
//
//        //拖动的时候不显示
//        if (!tableView.dragging && !tableView.decelerating) {
//            //下载图片数据 - 并缓存
//            [self p_loadImgeWithIndexPath:indexPath];
//        }
//    }
//    return cell;
//}
//
//
//- (void)p_loadImgeWithIndexPath:(NSIndexPath *)indexPath{
//
//    DemoModel *model = self.datas[indexPath.row];
//
//
//    //保存当前正在下载的操作
//    ImageDownload *manager = self.imageLoadDic[indexPath];
//    if (!manager) {
//
//        manager = [ImageDownload new];
//        //开始加载-保存到当前下载操作字典中
//        [self.imageLoadDic setObject:manager forKey:indexPath];
//    }
//
//    [manager loadImageWithModel:model success:^{
//        //主线程刷新UI
//        dispatch_async(dispatch_get_main_queue(), ^{
//            UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//            cell.imageView.image = model.iconImage;
//        });
//
//        //加载成功-从保存的当前下载操作字典中移除
//        [self.imageLoadDic removeObjectForKey:indexPath];
//    }];
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//
//    [self.navigationController pushViewController:[NextViewController new] animated:YES];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 100;
//}
//
//#pragma mark - <UIScrollViewDelegate>
//
//- (void)p_loadImage{
//
//    //拿到界面内-所有的cell的indexpath
//    NSArray *visableCellIndexPaths = self.tableView.indexPathsForVisibleRows;
//
//    for (NSIndexPath *indexPath in visableCellIndexPaths) {
//
//        DemoModel *model = self.datas[indexPath.row];
//
//        if (model.iconImage) {
//            continue;
//        }
//
//        [self p_loadImgeWithIndexPath:indexPath];
//    }
//}
//
////手放开了 - 停止拖动
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
//
//    if(!decelerate){
//        //直接停止-无动画
//        [self p_loadImage];
//    }else{
//        //有动画效果的(惯性) - 会走`scrollViewDidEndDecelerating`方法，这里不用设置
//    }
//}
//
////是否有动画效果
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//
//    [self p_loadImage];
//}


@end
