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
#import "XLsn0wTableViewWebImager.h"

static NSString *const BSYDownloadPicture_Archive_PictureUrl = @"/Documents/XLsn0wTableViewWebImager.plist";

@implementation DownloadPicturerPath
/**
 获取图片存贮位置
 @return 返回地址
 */
+(NSString *)getBSYDownloadPicturePath {
    NSString *path_sandox = NSHomeDirectory();
    //创建一个存储plist文件的路径
    NSString *plistPath = [path_sandox stringByAppendingPathComponent:BSYDownloadPicture_Archive_PictureUrl];
    return plistPath;
}

/**
 存储图片
 @return 是否存储成功
 */
+(BOOL )saveBSYDownloadPictureWithImage:(UIImage *)image ImageUrl:(NSString *)ImageUrl
{
    BOOL saveBool = true;
    NSString *imagePath = [self getBSYDownloadPicturePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:imagePath];
    if (!dict) {
        dict= [NSMutableDictionary dictionary];
    }
    if (![[dict allKeys] containsObject:ImageUrl]) {
        NSData *data = UIImageJPEGRepresentation(image, 0.1f);
        //把图片转换为Base64的字符串
        NSString *image64 =[data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
        [dict setObject:image64 forKey:ImageUrl];
        //写入plist文件
        if (![dict writeToFile:imagePath atomically:YES]) {
            saveBool  = false;
        }
    }
    return saveBool;
}

/**
 获取存储的图片
 */
+(UIImage *)getBSYDownloadPictureImageUrl:(NSString *)ImageUrl
{
    
    NSString *imagePath = [self getBSYDownloadPicturePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:imagePath];
    NSString *imageString = [dict objectForKey:imagePath];
    UIImage *decodedImage = nil;
    if (imageString) {
        // 将base64字符串转为NSData
        NSData *decodeData = [[NSData alloc]initWithBase64EncodedString:imageString options:(NSDataBase64DecodingIgnoreUnknownCharacters)];
        // 将NSData转为UIImage
        decodedImage= [UIImage imageWithData:decodeData];
    }
    return decodedImage;
}
/**
 删除所有已经缓存的图片
 */
+(BOOL)removeBSYDownloadPictureImage
{
    BOOL removeBool = false;
    NSString *imagePath = [self getBSYDownloadPicturePath];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithContentsOfFile:imagePath];
    [dict removeAllObjects];
    if ([[dict allKeys] count]==0) {
        [dict writeToFile:imagePath atomically:YES];
        removeBool = true;
    }
    return removeBool;
}
@end

@implementation XLsn0wTableViewWebImager

+(XLsn0wTableViewWebImager *)shared {
    static XLsn0wTableViewWebImager * s_instance_dj_singleton = nil ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (s_instance_dj_singleton == nil) {
            s_instance_dj_singleton = [[XLsn0wTableViewWebImager alloc] init];
        }
    });
    return (XLsn0wTableViewWebImager *)s_instance_dj_singleton;
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
