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
#import <UIKit/UIKit.h>

@class XLsn0wTableView;

@protocol XLsn0wTableViewCellForRowDelegate <NSObject>

- (UITableViewCell *)cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

/**
 *  选中某行
 *
 *  @param indexPath 位置
 *  @param data      数据
 */
typedef void(^XLsn0wTableViewSelectRowAtIndexPathBlock)(NSIndexPath *indexPath, id data);

typedef void(^XLsn0wTableViewCellForRowAtIndexPathBlock)(NSIndexPath *indexPath, id data);


/**
 *  note:这里父类实现的UITableViewDataSource的代理方法仅供参考，
 *  调用时注意要写registerClass:forCellReuseIdentifier:，
 *  如有特殊功能样式可自行实现.
 */
@interface XLsn0wTableView : UITableView

@property (nonatomic, weak) id<XLsn0wTableViewCellForRowDelegate> cellForRowDelegate;
@property (nonatomic, strong) UITableViewCell* idTableViewCell;
@property (nonatomic, strong) NSString* cellClassString;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, strong) NSMutableArray *groupArray;//!<数据源（需要分组，有多组的，里面的数据一定要是数组）
@property (nonatomic, strong) NSMutableArray *dataArray;//!<数据源(不需要分组或只有一组的)
@property (nonatomic, copy) XLsn0wTableViewSelectRowAtIndexPathBlock didSelectRowBlock;//!<选中某行的操作

@end
