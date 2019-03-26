//
//  aTableViewCell.m
//  TestTableManagerDemo
//
//  Created by JDragon on 2016/12/19.
//  Copyright © 2016年 JDragon. All rights reserved.
//

#import "aTableViewCell.h"
#import "TableViewManager.h"

@interface aTableViewCell () <JDTableManagerDelegate>

@end

@implementation aTableViewCell

-(void)PrepareToWithAppear:(NSObject *)data WithCurentVC:(UIViewController *)curentVC WithIndexPath:(NSIndexPath *)indexPath {
    self.textLabel.text = [data isKindOfClass:[NSString class]]?(NSString*)data:data.description;
    
    NSLog(@"data====%@",data);
}

@end
