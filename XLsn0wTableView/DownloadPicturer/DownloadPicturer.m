
#import "DownloadPicturer.h"
#import "DownloadPicturerPath.h"

@implementation DownloadPicturer

+(DownloadPicturer *)shared {
    static DownloadPicturer * s_instance_dj_singleton = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance_dj_singleton == nil) {
            s_instance_dj_singleton = [[DownloadPicturer alloc] init];
        }
    });
    return (DownloadPicturer *)s_instance_dj_singleton;
}

/**
 传入 imageUrl地址 下载图片
 @param imageUrl 图片地址
 @param succeedCallBack 下载成功以后回掉
  @param failCallBack 下载失败以后回掉
 */
-(void)bsy_DownloadPictureWithUrl:(NSString *)imageUrl succeedCallBack:(void(^)(UIImage *image))succeedCallBack    failCallBack:(void(^)(void))failCallBack
{

    if ([imageUrl isKindOfClass:[NSString class]]&&[imageUrl length]>0) {
        [self existimageUrl:imageUrl succeedCallBack:^(UIImage *image) {

            dispatch_async(dispatch_get_main_queue(), ^{
                if (succeedCallBack) {
                    succeedCallBack(image);
                }
            });

        } failCallBack:^{

            dispatch_async(dispatch_get_main_queue(), ^{
                if (failCallBack) {
                    failCallBack();
                }
            });

        }];
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failCallBack) {
                failCallBack();
            }
        });

    }
}


/**
 存在图片地址
 @param imageUrl 图片地址
 @param succeedCallBack 下载成功以后回掉
 @param failCallBack 下载失败以后回掉
 */
-(void)existimageUrl:(NSString *)imageUrl succeedCallBack:(void(^)(UIImage *image))succeedCallBack    failCallBack:(void(^)(void))failCallBack
{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{

            NSString *imagePath = [DownloadPicturerPath getBSYDownloadPicturePath];
            NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:imagePath];
            if ([[dict allKeys] containsObject:imageUrl]) {
                UIImage *image = [DownloadPicturerPath getBSYDownloadPictureImageUrl:imagePath];
                if (image) {
                        if (succeedCallBack) {
                            succeedCallBack(image);
                        }
                }else{
                    //没有存的图片去下载
                    [self downloadImageWithimageUrl:imageUrl succeedCallBack:^(UIImage *image) {
                        if (succeedCallBack) {
                            succeedCallBack(image);
                        }
                        [DownloadPicturerPath saveBSYDownloadPictureWithImage:image ImageUrl:imageUrl];
                    } failCallBack:^{
                        if (failCallBack) {
                            failCallBack();
                        }
                    }];

                }
            }else{
                //没有存的图片去下载
                [self downloadImageWithimageUrl:imageUrl succeedCallBack:^(UIImage *image) {
                    if (succeedCallBack) {
                        succeedCallBack(image);
                    }
                    [DownloadPicturerPath saveBSYDownloadPictureWithImage:image ImageUrl:imageUrl];
                } failCallBack:^{
                    if (failCallBack) {
                        failCallBack();
                    }
                }];

            }
        });
}

/**
 下载图片的具体实现
 @param imageUrl 图片地址
 @param succeedCallBack 下载成功以后回掉
 @param failCallBack 下载失败以后回掉
 */
-(void)downloadImageWithimageUrl:(NSString *)imageUrl succeedCallBack:(void(^)(UIImage *image))succeedCallBack    failCallBack:(void(^)(void))failCallBack
{

    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
    UIImage *image = [UIImage imageWithData:data];
        if (image) {
            if (succeedCallBack) {
                succeedCallBack(image);
            }
        }else{
            if (failCallBack) {
                failCallBack();
            }
        }
}
/**
 删除所有缓存的图片
 @param succeedCallBack 删除成功
 @param failCallBack 删除失败
 */
-(void)bsy_removeDownloadPictureSucceedCallBack:(void(^)(BOOL removeBool))succeedCallBack    failCallBack:(void(^)(BOOL removeBool))failCallBack
{
    BOOL removeBool =  [DownloadPicturerPath removeBSYDownloadPictureImage];
    if (removeBool==true) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (succeedCallBack) {
                succeedCallBack(removeBool);
            }
        });
    }else{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (failCallBack) {
                failCallBack(removeBool);
            }
        });
    }
}
@end
