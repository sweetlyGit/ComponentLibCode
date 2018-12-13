//
//  NSString+YYOUCarString.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (YYOUCarString)
/**
 *  计算文字宽高
 *
 *  @param text 传入文字
 *  @param font 文字字体
 *  @param size 宽高限制
 *
 *  @return 返回计算结果
 */
+ (CGSize)boundingRectWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size;
/**
 判断字符串是否为空
 
 @param str 传入判断字符串
 @return 是否为空
 */
+ (BOOL)isEmpty:(NSString *)str;        // 是否空字符串

/**
 防止空字符串
 
 @param str 字符串
 @return 返回处理后的字符串
 */
+ (NSString *)nullToString:(id)str;
/**
 //去除空格

 @return 要处理的字符串
 */
+(NSString *)removeSpacesWithString:(NSString *)string;
/**
 字符串的截取
 
 @param startString 开始字符串
 @param endString 结束字符串
 @return 截取后的字符串
 */
+(NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString contentString:(NSString *)content;
@end
