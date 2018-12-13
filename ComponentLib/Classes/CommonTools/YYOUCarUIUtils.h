//
//  YYOUCarUIUtils.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/10/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarUIUtils : NSObject
/**
 md5加密

 @param string 要加密的字符串
 @return 加密好的r返回值
 */
+(NSString *) md5:(NSString *)string;
/**
 判断手机号是否合法

 @param phone 手机号
 @return 是否合法的布尔值
 */
+(BOOL)isPhoneNumber:(NSString *)phone;
/**
 参数排序加密

 @param params 要参与排序加密的参数字典
 @return 加密后的返回值
 */
+ (NSString *)sortDictionary:(NSMutableDictionary *)params;
/**
 获取系统当前时间

 @return 当前系统时间
 */
+ (NSString *)getCurrentTime;

/**
 格式化时间戳

 @param timer 需要格式化的时间戳
 @param timeType 可根据自己需求配置TimerType
 @return 格式化好的时间
 */
+(NSString *)formatTimeWithTimer:(NSString *)timer timeType:(int)timeType;
/**
 计算两个日期之间的差值

 @param startTime 开始时间
 @param endTime 结束时间
 @return 时间差
 */
+(NSString *)getTimerDistantStartTime:(NSString *)startTime endTime:(NSString *)endTime;
/**
 获取随机字符串

 @return 随机字符串
 */
+(NSString *)getRandomString;
/**
 对参数数进行排序拼接

 @param params 参数字典
 @return 排序拼接好的字符串
 */
+(NSString *)sortHeaderDict:(NSDictionary *)params;

/**
 对字符串进行加密

 @param encryString 要加密的字符串
 @return 加密结果
 */
+(NSString *)encryptionWithString:(NSString *)encryString;
/**
 本地化存储
 @param value 存储的value
 @param key 存储的key
 */
+(void)setUserDefaultValue:(NSString *)value ForKey:(NSString *)key;

/**
 获取本地化存储的value
 @param key 本地化存储的key
 @return key 本地化存储的value
 */
+(NSString *)getUserDefaultForKey:(NSString *)key;

/**
 移除本地化存储

 @param key 本地化存储的key
 */
+(void)removeUserDefaultForKey:(NSString *)key;
/**
 计算图片大小

 @param sizeOriginKB 图片大小
 @param image 图片
 @return 小图
 */
+(UIImage *)imageKb:(NSUInteger)sizeOriginKB image:(UIImage*)image;

/**
 压缩图片

 @param image 图片
 @return 压缩后的图片
 */
+ (UIImage *)compressionSize:(UIImage*)image;
@end

NS_ASSUME_NONNULL_END
