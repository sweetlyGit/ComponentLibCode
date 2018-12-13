//
//  YYOUCarUIUtils.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarUIUtils.h"
#import "NSString+YYOUCarString.h"
#import "YYOUCommonHeader.h"
static NSString *_key = @"admin";
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";

static Byte iv[8]={0x12, 0x34, 0x56, 0x78, 0x90, 0xAB, 0xCD, 0xEF};
#define imageMaximumHeight 800
#define imageMaximumWidth  800
@implementation YYOUCarUIUtils

+(BOOL)isPhoneNumber:(NSString *)phone{
    NSString *express = @"^0{0,1}(13[0-9]|15[0-9]|18[0-9]|14[0-9])[0-9]{8}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF matches %@", express];
    BOOL boo = [pred evaluateWithObject:phone];
    return boo;
}

+(NSString *)getCurrentTime{
    NSDate *currentDate=[NSDate date];
    return [NSString stringWithFormat:@"%ld",(long)[currentDate timeIntervalSince1970]];
}

+(NSString *)formatTimeWithTimer:(NSString *)timer timeType:(int)timeType{
    // timer 是服务器返回的13位时间戳
    // iOS 生成的时间戳是10位
    NSTimeInterval interval  = [timer doubleValue] / 1000.0;
    NSDate *timeDate = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (timeType == 1) {
        //年月日时分秒
        [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    }else if (timeType == 2){
        //年月日时分
        [formatter setDateFormat:@"YYYY-MM-dd HH:mm"];
    }else if (timeType == 3){
        //年月日
        [formatter setDateFormat:@"YYYY年MM月dd日"];
    }else{
        //月日
        [formatter setDateFormat:@"MM月dd日"];
    }
    //将时间转换为字符串
    NSString *lasteTimer = [formatter stringFromDate:timeDate];
    return [NSString nullToString:lasteTimer];
}

+(NSString *)getTimerDistantStartTime:(NSString *)startTime endTime:(NSString *)endTime{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *starDate = [NSDate dateWithTimeIntervalSince1970:[startTime doubleValue]/1000.0];//开始时间
    NSDate *endDate = [NSDate dateWithTimeIntervalSince1970:[endTime doubleValue]/1000.0];//结束时间
    unsigned int unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond ;
    
    NSDateComponents *lastDate = [calendar components:unitFlags fromDate:starDate toDate:endDate options:0];
 NSLog(@"%ld%ld%ld%ld",lastDate.day,lastDate.hour,lastDate.minute,lastDate.second);
    return [NSString nullToString:[NSString stringWithFormat:@"%ld",lastDate.day]];
}

+(NSString *)getRandomString{
    NSInteger x = arc4random() % 10000001;
    NSString *randomString = [NSString stringWithFormat:@"%ld",(long)x];
    return randomString;
}
//字符串数组按首字排序,
+(NSString *)sortHeaderDict:(NSDictionary *)params{
    NSArray * array = [[params allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSString *strSign = @"";
    for (int i = 0; i< [array count]; i++) {
        strSign = [strSign stringByAppendingFormat:@"%@=%@",[array objectAtIndex:i],[params objectForKey:[array objectAtIndex:i]]];
    }
    return strSign;
}
+(NSString *)encryptionWithString:(NSString *)encryString{
    //拼接好第一次MD5加密
    NSString *strMd5 = [[YYOUCarUIUtils md5:encryString] lowercaseString];
    //MD5后的字符串拼接好KEY
    NSString * md5Str = [NSString stringWithFormat:@"%@%@",strMd5,_key];
    //拼接好key的字符串再次MD5加密
    NSString *result = [[YYOUCarUIUtils md5:md5Str] lowercaseString];
    //result 作为sign的value
    return  [NSString removeSpacesWithString:result];
}
//字符串数组按首字排序,不支持大小写混排并加密
+ (NSString *)sortDictionary:(NSMutableDictionary *)params{
    NSArray * array = [[params allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        NSComparisonResult result = [obj1 compare:obj2];
        return result;
    }];
    
    NSString *strSign = @"";
    for (int i = 0; i< [array count]; i++) {
            strSign = [strSign stringByAppendingFormat:@"%@=%@",[array objectAtIndex:i],[params objectForKey:[array objectAtIndex:i]]];
    }
    //排序好后第一次MD5加密
    NSString *strMd5 = [[YYOUCarUIUtils md5:strSign] lowercaseString];
    //MD5后的字符串拼接好KEY
    NSString * md5Str = [NSString stringWithFormat:@"%@%@",strMd5,_key];
    //拼接好key的字符串再次MD5加密
    NSString *result = [[YYOUCarUIUtils md5:md5Str] lowercaseString];
    //result 作为sign的value
    return  [NSString removeSpacesWithString:result];
}

+ (NSString *)md5:(NSString *)string {
        
    if (string == nil) { return nil; }
    
    const char *str = [string cStringUsingEncoding:NSUTF8StringEncoding];
    CC_LONG strLen = (CC_LONG)[string lengthOfBytesUsingEncoding:NSUTF8StringEncoding];
    unsigned char *result = calloc(CC_MD5_DIGEST_LENGTH, sizeof(unsigned char));
    CC_MD5(str, strLen, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; ++i) {
        [hash appendFormat:@"%02x", result[i]];
    }
    
    free(result);
    
    return hash;
}
+(void)setUserDefaultValue:(NSString *)value ForKey:(NSString *)key{
    NSUserDefaults *tokenDefault = [NSUserDefaults standardUserDefaults];
    [tokenDefault setObject:value forKey:key];
    [tokenDefault synchronize];
}
+(NSString *)getUserDefaultForKey:(NSString *)key{
    NSUserDefaults *tokenDefault = [NSUserDefaults standardUserDefaults];
   return  [NSString nullToString:[tokenDefault objectForKey:key]];
}
+(void)removeUserDefaultForKey:(NSString *)key{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
+(UIImage*)imageKb:(NSUInteger)sizeOriginKB image:(UIImage*)image
{
    if (sizeOriginKB >900) {
        float a = 900;
        float b = (float)sizeOriginKB;
        float q = sqrtf(a / b);
        
        CGSize sizeImage = [image size];
        CGFloat widthSmall = sizeImage.width * q;
        CGFloat heighSmall = sizeImage.height * q;
        CGSize sizeImageSmall = CGSizeMake(widthSmall, heighSmall);
        
        UIGraphicsBeginImageContext(sizeImageSmall);
        CGRect smallImageRect = CGRectMake(0, 0, sizeImageSmall.width, sizeImageSmall.height);
        [image drawInRect:smallImageRect];
        UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        return smallImage;
    }
    return image;
}

+(UIImage *)compressionSize:(UIImage*)image
{
    CGSize imageSize = image.size;
    if(image.size.height>image.size.width&&image.size.height>imageMaximumHeight) {
        
        imageSize.height = image.size.height*(imageMaximumHeight/image.size.height);
        imageSize.width = image.size.width*(imageMaximumHeight/image.size.height);
        
    } else if (image.size.width>image.size.height&&image.size.width>imageMaximumWidth) {
        
        imageSize.width = image.size.width*(imageMaximumWidth/image.size.width);
        imageSize.height = image.size.height*(imageMaximumWidth/image.size.width);
        
    } else if (image.size.width==image.size.height&&image.size.width>imageMaximumWidth) {
        
        imageSize.width = image.size.width*(imageMaximumWidth/image.size.width);
        imageSize.height = image.size.height*(imageMaximumWidth/image.size.width);
    }
    
    
    UIGraphicsBeginImageContext(CGSizeMake(floor(imageSize.width),floor(imageSize.height)));
    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0,0, imageSize.width, imageSize.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage =UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    //返回新的改变大小后的图片
    return scaledImage;
}
@end
