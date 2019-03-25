
#import "DownloadPicturerPath.h"

static NSString *const BSYDownloadPicture_Archive_PictureUrl = @"/Documents/pic.plist";
@implementation DownloadPicturerPath
/**
 获取图片存贮位置
 @return 返回地址
 */
+(NSString *)getBSYDownloadPicturePath
{
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
