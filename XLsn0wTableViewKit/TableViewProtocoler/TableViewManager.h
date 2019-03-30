
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^TableViewDidSelectCellBlock)(NSIndexPath *indexPath);

@protocol XLsn0wTableManagerDelegate <NSObject>

- (void)PrepareToWithAppear:(NSObject *)data
               WithCurentVC:(UIViewController*)curentVC
              WithIndexPath:(NSIndexPath*)indexPath;

@end

typedef enum XLsn0wTableViewSectionType:NSUInteger {
    NumberOfRowsInSectionNum=0,  // NumRows----Of Group Section
    NumberOfRowsInSectionCount,  // NumRows----of One Section
    NumberOfRowsInSectionOne,    // Oneows-----of Section
    Test
} JDTabHelpType;

@interface TableViewManager : NSObject

@property(nonatomic,assign) JDTabHelpType  tabHelpType;

#pragma mark----------------------------TableDelegate--------------------------------
+ (instancetype)tabDelegateWithtableView:(UITableView *)tableView
                            HeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(TableViewDidSelectCellBlock)selectBlock;

#pragma mark----------------------------TableDataSource--------------------------------
- (instancetype)initWithSource:(NSArray *)source
                       tabType:(JDTabHelpType)tabType
                     tableView:(UITableView *)tableView
                     isSection:(BOOL)isSection
                         tabVC:(UIViewController*)tabVC
            andReuseIdentifier:(NSString *)reuseIdentifier;

-(instancetype)initWithSource:(NSArray *)source
                      tabType:(JDTabHelpType)tabType
                    tableView:(UITableView *)tableView
                    isSection:(BOOL)isSection
                        tabVC:(UIViewController*)tabVC
        andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;

+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
                     TabVC:(UIViewController*)TabVC
                 isSection:(BOOL)isSection
        andReuseIdentifier:(NSString *)reuseIdentifier;


+ (instancetype)dataSource:(NSArray *)source
                   tabType:(JDTabHelpType)tabType
                 tableView:(UITableView *)tableView
                     TabVC:(UIViewController*)TabVC
                 isSection:(BOOL)isSection
     andReuseIdentifierArr:(NSArray *)reuseIdentifierArr;

// 合并delegate和
-(void)setCellAutoHeightAndeHeaderHeight:(CGFloat)hHeight
                            footerHeight:(CGFloat)fHeight
                             selectBlock:(TableViewDidSelectCellBlock)selectBlock;

-(void)setReuseArrayInSectionTypeWithArray:(NSArray*)array;



//ReloadData
-(void)updateReloadData:(NSArray*)datas;


-(void)updateData:(NSArray*)datas;

@end



//self.aTableView.estimatedRowHeight = 50;
//[self.aTableView registerClass:[XLsn0wTableViewCell class] forCellReuseIdentifier:@"aTableViewCell"];
//
/////同一种cell
//self.tabDelagate = [self.aTableView JDTab_DelegateWithHeaderHeight:10
//                                                      footerHeight:10
//                                                       selectBlock:^(NSIndexPath *indexPath) {
//                                                           NSLog(@"选中");
//                                                       }];
//// 需要实现JDTableManagerDelegate 代理在cell里面
//self.tabDataSource = [self.aTableView JDTab_DataSourceWithSource:@[@"111",@"222"] withTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
//
////第二种方式，可以不带原数据
//self.tabDataSource = [self.aTableView JDTab_DataSourceWithTabType:NumberOfRowsInSectionCount withVC:self isSection:true reuseIdentifier:@"aTableViewCell"];
//[self.tabDataSource updateReloadData:@[@"111",@"222"]];
