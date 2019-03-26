
#import "UIView+Additions.h"
#import <QuartzCore/QuartzCore.h>
#import <objc/runtime.h>

@implementation UIView (Additions)

///定义常量 必须是C语言字符串
static char *touchBeganBlockKey = "touchBeganBlock";

- (void)setTouchBeganBlock:(touchBlock)touchBeganBlock {
    /*
     objc_AssociationPolicy参数使用的策略：
     OBJC_ASSOCIATION_ASSIGN;            //assign策略
     OBJC_ASSOCIATION_COPY_NONATOMIC;    //copy策略
     OBJC_ASSOCIATION_RETAIN_NONATOMIC;  // retain策略
     
     OBJC_ASSOCIATION_RETAIN;
     OBJC_ASSOCIATION_COPY;
     */
    /*
     关联方法：
     objc_setAssociatedObject(id object, const void *key, id value, objc_AssociationPolicy policy);
     
     参数：
     * id object 给哪个对象的属性赋值
     const void *key 属性对应的key
     id value  设置属性值为value
     objc_AssociationPolicy policy  使用的策略，是一个枚举值，和copy，retain，assign是一样的，手机开发一般都选择NONATOMIC
     */
    
    objc_setAssociatedObject(self, touchBeganBlockKey, touchBeganBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (touchBlock)touchBeganBlock{
    return objc_getAssociatedObject(self, touchBeganBlockKey);
}

static char *touchMoveBlockKey = "touchMoveBlock";

- (void)setTouchMoveBlock:(touchBlock)touchMoveBlock {
    objc_setAssociatedObject(self, touchMoveBlockKey, touchMoveBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (touchBlock)touchMoveBlock {
    return objc_getAssociatedObject(self, touchMoveBlockKey);
}

static char *touchEndBlockKey = "touchEndBlock";

- (void)setTouchEndBlock:(touchBlock)touchEndBlock {
    objc_setAssociatedObject(self, touchEndBlockKey, touchEndBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (touchBlock)touchEndBlock {
    return objc_getAssociatedObject(self, touchEndBlockKey);
}

static char *lineColorKey = "lineColor";

- (void)setLineColor:(UIColor *)lineColor {
    objc_setAssociatedObject(self, lineColorKey, lineColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (UIColor *)lineColor {
    return objc_getAssociatedObject(self, lineColorKey);
}

- (float)boundsWidth{
    return self.bounds.size.width;
}

- (float)boundsHeight{
    return self.bounds.size.width;
}

- (void)setBoundsWidth:(float)w{
    CGRect frame = self.bounds;
    frame.size.width = w;
    self.bounds = frame;
}

- (void)setBoundsHeight:(float)h{
    CGRect frame = self.bounds;
    frame.size.height = h;
    self.bounds = frame;
}

- (float)x{
    return self.frame.origin.x;
}

- (float)y{
    return self.frame.origin.y;
}

- (float)width{
    return self.frame.size.width;
}

- (float)height{
    return self.frame.size.height;
}

- (void)setX:(float)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (void)setY:(float)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (void)setWidth:(float)w{
    CGRect frame = self.frame;
    frame.size.width = w;
    self.frame = frame;
}

- (void)setHeight:(float)h{
    CGRect frame = self.frame;
    frame.size.height = h;
    self.frame = frame;
}

- (void)fadeIn{
    [self fadeInOnComplet:nil];
}

- (void)fadeOut{
    [self fadeOutOnComplet:nil];
}

- (void)fadeInOnComplet:(void(^)(BOOL finished))complet{
    self.alpha = 0;
    [UIView animateWithDuration:.18 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 1;
    } completion:complet];
}

- (void)fadeOutOnComplet:(void(^)(BOOL finished))complet{
    [UIView animateWithDuration:.18 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        self.alpha = 0;
    } completion:complet];
    if ([UIView areAnimationsEnabled]) {
        [UIView setAnimationsEnabled:YES];
    }
}

- (void)removeAllSubviews{
    for (UIView *temp in self.subviews) {
        [temp removeFromSuperview];
    }
}

- (void)removeSubviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag!=tag) {
            if ([temp isKindOfClass:[UIImageView class]]) {
                [(UIImageView *)temp setImage:nil];
            }
            [temp removeFromSuperview];
        }
    }
}

- (void)removeSubviewExceptClass:(Class)class{
    for (UIView *temp in self.subviews) {
        if (![temp isKindOfClass:class]) {
            [temp removeFromSuperview];
        }
    }
}

- (UIView *)addLine:(UIColor *)color frame:(CGRect)frame{
    UIView *line = [[UIView alloc] initWithFrame:frame];
    line.backgroundColor = color;
    [self addSubview:line];
    return line;
}

- (UIImage *)toRetinaImageRealTime{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toRetinaImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, YES, 0);
    [self drawViewHierarchyInRect:self.bounds
               afterScreenUpdates:NO];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toAlphaRetinaImageRealTime{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toAlphaRetinaImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    [self drawViewHierarchyInRect:self.bounds
               afterScreenUpdates:NO];
    UIImage *screenShotimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShotimage;
}

- (UIImage *)toImageWithRect:(CGRect)frame{
    return [self toImageWithRect:frame withAlpha:NO];
}

- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha{
    UIGraphicsBeginImageContextWithOptions(frame.size, !alpha, 1);//这里通过设置scale为1来截取{[UIScreen screenWidth], 49}大小的图,而不是在retina下截取2x大小的图
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextConcatCTM(context, CGAffineTransformMakeTranslation(-frame.origin.x, -frame.origin.y));
    [self.layer renderInContext:context];
    UIImage *screenShot1 = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot1;
}

- (UIImage *)visbleToImage{
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    if ([self isKindOfClass:[UIScrollView class]]) {
        CGPoint offset=[(UIScrollView *)self contentOffset];
        CGContextTranslateCTM(context, -offset.x, -offset.y);
    }
//    [self.layer renderInContext:context];
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *visibleScrollViewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return visibleScrollViewImage;
}

- (void)addShadowWithAlpha:(float)alpha{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
    [self.layer setShadowColor:[UIColor grayColor].CGColor];
    [self.layer setShadowOpacity:alpha];
    [self.layer setShadowRadius:10.0f];
    [self.layer setShadowPath:[path CGPath]];
}

- (void)addShadow{
    [self addShadowWithAlpha:1];
}

- (void)addShadowWithColor:(UIColor *)color{
    UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(0, 5, self.bounds.size.width, self.bounds.size.height)];
    [self.layer setShadowColor:color.CGColor];
    [self.layer setShadowOpacity:1];
    [self.layer setShadowRadius:10.0f];
    [self.layer setShadowPath:[path CGPath]];
}

- (void)removeShadow{
    self.layer.shadowOpacity = 0;
    self.layer.shadowRadius = 0;
}

- (UIView *)findAndResignFirstResponder{
    if (self.isFirstResponder) {
        return self;
    }
    for (UIView *subView in self.subviews) {
        UIView *temp = [subView findAndResignFirstResponder];
        if (temp!=nil) {
            return temp;
        }
    }
    return nil;
}

- (void)addCorner{
    UIImageView *cornder = [[UIImageView alloc] initWithImage:[[UIImage imageNamed:@"corner.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)]];
    cornder.contentMode = UIViewContentModeScaleAspectFit;
    cornder.frame = CGRectMake(0, 0, self.width, self.height);
    [self addSubview:cornder];
}

- (void)shake:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.5;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)shakeRepeat:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    animation.repeatCount = NSIntegerMax;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)shakeX:(float)range{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.6;
    animation.values = @[ @(-range), @(range), @(-range/2), @(range/2), @(-range/5), @(range/5), @(0) ];
    [self.layer addAnimation:animation forKey:@"shake"];
}

///那么如何应对这个问题呢？不要在滚动视图使用cornerRadius或者mask。如果你非要作死怎么办呢？那么这样也可以拯救你：
///这样大部分情况下可以马上挽救你的帧数在55帧每秒以上。shouldRasterize = YES会使视图渲染内容被缓存起来，下次绘制的时候可以直接显示缓存，当然要在视图内容不改变的情况下。
- (void)rasterize{
    self.layer.shouldRasterize = YES;
    self.layer.rasterizationScale = [UIScreen mainScreen].scale;
}

+ (void)vveboAnimations:(void (^)(void))animations{
    [UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:nil];
}

+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:.18 delay:0 animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations{
    [UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:nil];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:duration delay:0 animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    [UIView vveboAnimateWithDuration:duration delay:delay options:UIViewAnimationOptionCurveLinear animations:animations completion:completion];
}

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion{
    if (![UIView areAnimationsEnabled]) {
        [UIView setAnimationsEnabled:YES];
    }
    [UIView animateWithDuration:duration delay:delay options:options animations:animations completion:completion];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touchBeganBlock) {
        self.touchBeganBlock([touches anyObject], self);
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touchEndBlock) {
        self.touchEndBlock([touches anyObject], self);
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touchMoveBlock) {
        self.touchMoveBlock([touches anyObject], self);
    }
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    if (self.touchEndBlock) {
        self.touchEndBlock([touches anyObject], self);
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)addLine:(CGRect)rect {
    UIColor *color = self.lineColor;
    if (self.lineColor==nil) {
        color = [UIColor grayColor];
    }
    UIView *line = [[UIView alloc] initWithFrame:rect];
    line.backgroundColor = color;
    [self addSubview:line];
}

- (BOOL)hasActionSheetOrAlert{
    if ([self isKindOfClass:[UIAlertView class]]||[self isKindOfClass:[UIActionSheet class]]) {
        return YES;
    }
    for (UIView *subView in self.subviews) {
        BOOL temp = [subView hasActionSheetOrAlert];
        if (temp) {
            return temp;
        }
    }
    return NO;
}

- (UIView *)subviewWithTag:(NSInteger)tag{
    for (UIView *temp in self.subviews) {
        if (temp.tag==tag) {
            return temp;
        }
    }
    return nil;
}

@end
