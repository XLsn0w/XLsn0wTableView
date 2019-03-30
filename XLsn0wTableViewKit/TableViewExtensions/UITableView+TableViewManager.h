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
#import "TableViewManager.h"

@interface UITableView (TableViewManager)

#pragma mark----------------------------TableDataSource--------------------------------

/**
 *  根据TabType获取DataSource(单个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
                  reuseIdentifier:(NSString *)reuseIdentifier;
/**
 *  根据TabType获取DataSource(多个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
               reuseIdentifierArr:(NSArray *)reuseIdentifierArr;
/**
 *  根据TabType获取DataSource(带数据源---单个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
                 reuseIdentifier:(NSString *)reuseIdentifier;
/**
 *  根据TabType获取DataSource(带数据源---多个Cell)
 *
 *  @return TableViewDataSource
 */
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
              reuseIdentifierArr:(NSArray *)reuseIdentifierArr;


#pragma mark----------------------------TableDelegate--------------------------------
/**
 *  获取tabDelagate
 *
 *  @return TableViewDelagate
 */
- (id)JDTab_DelegateWithHeaderHeight:(CGFloat)hHeight
                        footerHeight:(CGFloat)fHeight
                         selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock;

//- (id)JDTab_DelegateWithAutoHeight HeaderHeight:(CGFloat)hHeight
//                                   footerHeight:(CGFloat)fHeight
//                                    selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock;
@end

