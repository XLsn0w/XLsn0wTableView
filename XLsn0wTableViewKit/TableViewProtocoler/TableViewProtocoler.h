//
//  KTJTableViewProtocoler.h
//  KTJTableViewProtocoler
//
//  Created by 孙继刚 on 15/9/6.
//  Copyright (c) 2015年 Madordie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TableViewProtocol;

@interface TableViewProtocoler : NSObject

@property (nonatomic, weak) id<TableViewProtocol> delegate;

//  这俩可以自己实现。。
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
//  优化请直接调用这两个方法。然后实现代理方法进行替换。
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

//  如果使用必须实现这两个方法
@protocol TableViewProtocol <NSObject>
/**
 *  获取重用标识符
 *
 *  @param tableView  当前的TableView
 *  @param dataSource 数据源
 *  @param indexPath  位置
 *
 *  @return 当前cell的重用标识符
 */
- (NSString *)ktjtableView:(UITableView *)tableView reuseIdentifierWithDataSource:(id)dataSource indexPath:(NSIndexPath *)indexPath;
/**
 *  使用数据源 填充cell
 *
 *  @param tableView  当前的TableView
 *  @param cell       cell
 *  @param dataSource 数据源
 *  @param indexPath  位置
 */
- (void)ktjtableView:(UITableView *)tableView configureCell:(id)cell withDataSource:(id)dataSource indexPath:(NSIndexPath *)indexPath;

/**
 *  *** 简单列表 ***
 */
@optional
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

@end


@interface UITableView (KTJTableViewProtocoler)

@property (nonatomic, strong) TableViewProtocoler *ktj_protocoler;

@property (nonatomic, strong) id ktj_dataSource;

/**
 *  如果simple == YES, 那么其代理数据源均指向ktj_protocoler。
 */
@property (nonatomic, assign) BOOL ktj_simpleList;  // Default NO.

@end

@interface UITableViewCell (KTJTableViewProtocoler)

+ (NSString *)ktj_defaultIDFA;

@end

#if 0

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView = [UITableView new];
    self.tableView.frame = self.view.bounds;
    [self.view addSubview:self.tableView];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.ktj_protocoler.delegate = self;
    
    self.tableView.ktj_dataSource = @[@"1", @"2", @"3", @"4"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - < *** ViewController      代理     👇 ***>
//KTJ的方法不多只有两个，只实现了四个方法，其实只用调用最后两个就好。
- (void)ktjtableView:(UITableView *)tableView configureCell:(UITableViewCell *)cell withDataSource:(id)dataSource indexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = dataSource[indexPath.row];
}
- (NSString *)ktjtableView:(UITableView *)tableView reuseIdentifierWithDataSource:(id)dataSource indexPath:(NSIndexPath *)indexPath {
    return @"UITableViewCell";
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableView.ktj_protocoler tableView:tableView numberOfRowsInSection:section];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView.ktj_protocoler tableView:tableView cellForRowAtIndexPath:indexPath];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView.ktj_protocoler tableView:tableView heightForRowAtIndexPath:indexPath];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //tableView.ktj_protocoler 中没有的方法直接写就好啦！！
    NSLog(@"哇哈哈");
}

#endif
