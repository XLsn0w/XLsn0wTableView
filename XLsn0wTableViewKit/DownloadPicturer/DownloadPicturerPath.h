
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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
