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
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLsn0wTableViewWebImager : NSObject///XLsn0wTableViewWebImage

+ (XLsn0wTableViewWebImager *)shared;

/**
 传入 imageUrl地址 下载图片

 @param imageUrl 图片地址
 @param succeedCallBack 下载成功以后回掉
 @param failCallBack 下载失败以后回掉
 */
-(void)bsy_DownloadPictureWithUrl:(NSString *)imageUrl
                  succeedCallBack:(void(^)(UIImage *image))succeedCallBack
                     failCallBack:(void(^)(void))failCallBack;
/**
 删除所有缓存的图片

 @param succeedCallBack 删除成功
 @param failCallBack 删除失败
 */
-(void)bsy_removeDownloadPictureSucceedCallBack:(void(^)(BOOL removeBool))succeedCallBack
                                   failCallBack:(void(^)(BOOL removeBool))failCallBack;

@end

@interface DownloadPicturerPath : NSObject

/**
 获取图片存贮位置
 
 @return 返回地址
 */
+ (NSString *)getBSYDownloadPicturePath;

/**
 存储图片
 @return 是否存储成功
 */
+(BOOL)saveBSYDownloadPictureWithImage:(UIImage *)image ImageUrl:(NSString *)ImageUrl;

/**
 获取存储的图片
 */
+(UIImage *)getBSYDownloadPictureImageUrl:(NSString *)ImageUrl;


/**
 删除所有已经缓存的图片
 */
+(BOOL)removeBSYDownloadPictureImage;

@end
