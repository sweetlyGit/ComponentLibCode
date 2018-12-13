//
//  UILabel+YYOUCarLabel.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (YYOUCarLabel)
+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font;

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor;

+ (instancetype)labelWithText:(NSString *)text font:(UIFont *)font alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithText:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithFont:(UIFont *)font alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithFont:(UIFont *)font textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment;

+ (instancetype)labelWithFrame:(CGRect)frame text:(NSString *)text textColor:(UIColor *)textColor font:(UIFont *)font backgroundColor:(UIColor *)backgroundColor alignment:(NSTextAlignment)alignment;
@end
