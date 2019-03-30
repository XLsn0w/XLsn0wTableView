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

typedef void(^touchBlock)(UITouch *t, UIView *target);

@interface UIView (Additions)

@property (nonatomic, copy) touchBlock touchBeganBlock;
@property (nonatomic, copy) touchBlock touchEndBlock;
@property (nonatomic, copy) touchBlock touchMoveBlock;
@property (nonatomic, strong) UIColor* lineColor;

- (float)x;
- (float)y;
- (float)width;
- (float)height;

- (void)setX:(float)x;
- (void)setY:(float)y;
- (void)setWidth:(float)w;
- (void)setHeight:(float)h;

- (float)boundsWidth;
- (float)boundsHeight;
- (void)setBoundsWidth:(float)w;
- (void)setBoundsHeight:(float)h;

- (void)fadeIn;
- (void)fadeOut;
- (void)fadeInOnComplet:(void(^)(BOOL f))complet;
- (void)fadeOutOnComplet:(void(^)(BOOL f))complet;

- (void)removeAllSubviews;
- (void)removeSubviewWithTag:(NSInteger)tag;
- (void)removeSubviewExceptTag:(NSInteger)tag;
- (void)removeSubviewExceptClass:(Class)class1;

- (UIImage *)toAlphaRetinaImageRealTime;
- (UIImage *)toRetinaImage;
- (UIImage *)toAlphaRetinaImage;
- (UIImage *)toImageWithRect:(CGRect)frame;
- (UIImage *)toImageWithRect:(CGRect)frame withAlpha:(BOOL)alpha;
- (UIImage *)visbleToImage;

- (void)addShadowWithColor:(UIColor *)color;
- (void)addShadow;
- (void)addShadowWithAlpha:(float)alpha;
- (void)removeShadow;
- (UIView *)findAndResignFirstResponder;
- (UIView *)addLine:(UIColor *)color frame:(CGRect)frame;

- (void)addCorner;
- (void)shake:(float)range;
- (void)shakeRepeat:(float)range;
- (void)shakeX:(float)range;
- (void)rasterize;

+ (void)vveboAnimations:(void (^)(void))animations;
+ (void)vveboAnimations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;
+ (void)vveboAnimateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay options:(UIViewAnimationOptions)options animations:(void (^)(void))animations completion:(void (^)(BOOL finished))completion;

- (void)addLine:(CGRect)rect;
- (BOOL)hasActionSheetOrAlert;
- (UIView *)subviewWithTag:(NSInteger)tag;
@end
