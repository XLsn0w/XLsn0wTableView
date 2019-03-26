//
//  ViewController.m
//  XLsn0wTableView
//
//  Created by mac on 2019/3/25.
//  Copyright © 2019年 XLsn0w. All rights reserved.
//

#import "ViewController.h"
#import "DrawTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    DrawTableView* tableView = [[DrawTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
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
//
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
