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

@end
