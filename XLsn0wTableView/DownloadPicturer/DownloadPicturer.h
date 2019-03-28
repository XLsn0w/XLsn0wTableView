
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DownloadPicturer : NSObject

+ (DownloadPicturer *)shared;
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
