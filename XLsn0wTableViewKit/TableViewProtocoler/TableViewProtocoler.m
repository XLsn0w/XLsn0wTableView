
#import "TableViewProtocoler.h"
#import "UITableView+FDTemplateLayoutCell.h"

#ifndef KTJLogRed
#define KTJLogRed(frmt, ...) NSLog((@"\033[fg250,0,0;" frmt @";"), ##__VA_ARGS__)
#endif

@interface TableViewProtocoler () <UITableViewDelegate, UITableViewDataSource>

@end
@implementation TableViewProtocoler

- (void (^)(id))configurationTableView:(UITableView *)tableview dataSource:(id)dataSource indexPath:(NSIndexPath *)indexPath {
    return ^(id cell) {
        if ([_delegate respondsToSelector:@selector(ktjtableView:configureCell:withDataSource:indexPath:)]) {
            [_delegate ktjtableView:tableview configureCell:cell withDataSource:dataSource indexPath:indexPath];
        }
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.style==UITableViewStylePlain?1:[tableView.ktj_dataSource count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.style==UITableViewStylePlain?[tableView.ktj_dataSource count]:[tableView.ktj_dataSource[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    if ([self.delegate respondsToSelector:@selector(ktjtableView:reuseIdentifierWithDataSource:indexPath:)]) {
        identifier = [self.delegate ktjtableView:tableView reuseIdentifierWithDataSource:tableView.ktj_dataSource indexPath:indexPath];
    } else {
        KTJLogRed(@"KTJTableViewProtocoler->delegate->tableView:reuseIdentifierWithDataSource: ==> nil");
        return nil;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    [self configurationTableView:tableView dataSource:tableView.ktj_dataSource indexPath:indexPath](cell);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier;
    if ([self.delegate respondsToSelector:@selector(ktjtableView:reuseIdentifierWithDataSource:indexPath:)]) {
        identifier = [self.delegate ktjtableView:tableView reuseIdentifierWithDataSource:tableView.ktj_dataSource indexPath:indexPath];
    } else {
        KTJLogRed(@"KTJTableViewProtocoler->delegate->tableView:reuseIdentifierWithDataSource: ==> nil");
        return 44;
    }

    return [tableView fd_heightForCellWithIdentifier:identifier cacheByIndexPath:indexPath configuration:[self configurationTableView:tableView dataSource:tableView.ktj_dataSource indexPath:indexPath]];
}
#pragma mark - 精简list
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.delegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view;
    if ([self.delegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        view = [self.delegate tableView:tableView viewForHeaderInSection:section];
    }
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view;
    if ([self.delegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        view = [self.delegate tableView:tableView viewForFooterInSection:section];
    }
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        height = [self.delegate tableView:tableView heightForFooterInSection:section];
    }
    return height;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    CGFloat height = CGFLOAT_MIN;
    if ([self.delegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        height = [self.delegate tableView:tableView heightForHeaderInSection:section];
    }
    return height;
}

@end


#import <objc/runtime.h>
@implementation UITableView (KTJTableViewProtocoler)

- (TableViewProtocoler *)ktj_protocoler {
    TableViewProtocoler *protocoler = objc_getAssociatedObject(self, @selector(ktj_protocoler));
    if (protocoler) {
        return protocoler;
    }
    
    protocoler = [[TableViewProtocoler alloc] init];
    self.ktj_protocoler = protocoler;
    
    return protocoler;
}
- (void)setKtj_protocoler:(TableViewProtocoler *)ktj_protocoler {
    if (self.ktj_simpleList) {
        self.dataSource = ktj_protocoler;
        self.delegate = ktj_protocoler;
    }
    objc_setAssociatedObject(self, @selector(ktj_protocoler), ktj_protocoler, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)ktj_dataSource {
    return objc_getAssociatedObject(self, @selector(ktj_dataSource));
}
- (void)setKtj_dataSource:(id)ktj_dataSource {
    objc_setAssociatedObject(self, @selector(ktj_dataSource), ktj_dataSource, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setKtj_simpleList:(BOOL)ktj_simpleList {
    if (objc_getAssociatedObject(self, @selector(ktj_protocoler))) {
        self.dataSource = self.ktj_protocoler;
        self.delegate = self.ktj_protocoler;
    }
    objc_setAssociatedObject(self, @selector(ktj_simpleList), @(ktj_simpleList), OBJC_ASSOCIATION_COPY_NONATOMIC);
}
- (BOOL)ktj_simpleList {
    NSNumber *simple = objc_getAssociatedObject(self, @selector(ktj_simpleList));
    return simple?[simple boolValue]:NO;
}
@end

@implementation UITableViewCell (KTJTableViewProtocoler)

+ (NSString *)ktj_defaultIDFA {
    return NSStringFromClass(self);
}

@end
