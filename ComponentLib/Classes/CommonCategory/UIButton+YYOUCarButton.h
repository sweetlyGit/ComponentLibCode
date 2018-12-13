//
//  UIButton+YYOUCarButton.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (YYOUCarButton)
#pragma mark***设置带文本和文本颜色的按钮
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor;

#pragma mark***设置带文本文本正常状态颜色和文本选中状态颜色的按钮
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor;
#pragma mark***设置按钮 正常， 背景色 字体大小
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor backGroundColor:(UIColor *)backColor font:(UIFont *)textFont;
#pragma mark***设置按钮 正常，选中  字体大小
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont;
#pragma mark***设置按钮 正常，选中 背景色 字体大小
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont backGroundColor:(UIColor *)backColor;
#pragma mark***设置按钮
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont backGroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment;
@end
