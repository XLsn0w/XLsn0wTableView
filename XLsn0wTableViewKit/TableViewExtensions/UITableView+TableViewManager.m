
//
//  UITableView+JDragonTableManager.m
//  TestTableManager
//
//  Created by JDragon on 2016/12/15.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "UITableView+TableViewManager.h"

@implementation UITableView (TableViewManager)

- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
                 reuseIdentifier:(NSString *)reuseIdentifier
{
    return [TableViewManager
            dataSource:source tabType:tabType tableView:self TabVC:VC isSection:isSection andReuseIdentifier:reuseIdentifier];
}
- (id)JDTab_DataSourceWithSource:(NSArray *)source
                     withTabType:(JDTabHelpType)tabType
                          withVC:(UIViewController*)VC
                       isSection:(BOOL)isSection
              reuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    return [TableViewManager dataSource:source tabType:tabType tableView:self TabVC:VC isSection:isSection andReuseIdentifierArr:reuseIdentifierArr];
}

- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
                  reuseIdentifier:(NSString *)reuseIdentifier
{
    return [TableViewManager
            dataSource:nil tabType:tabType tableView:self TabVC:VC isSection:isSection andReuseIdentifier:reuseIdentifier];
    
}
- (id)JDTab_DataSourceWithTabType:(JDTabHelpType)tabType
                           withVC:(UIViewController*)VC
                        isSection:(BOOL)isSection
               reuseIdentifierArr:(NSArray *)reuseIdentifierArr
{
    
    return [TableViewManager dataSource:nil tabType:tabType tableView:self TabVC:VC isSection:isSection andReuseIdentifierArr:reuseIdentifierArr];
}

- (id)JDTab_DelegateWithHeaderHeight:(CGFloat)hHeight
                        footerHeight:(CGFloat)fHeight
                         selectBlock:(void(^)(NSIndexPath *indexPath))selectBlock
{
    
    return [TableViewManager tabDelegateWithtableView:self HeaderHeight:hHeight footerHeight:fHeight selectBlock:selectBlock];
}

@end
