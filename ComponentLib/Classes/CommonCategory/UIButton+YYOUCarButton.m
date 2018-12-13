//
//  UIButton+YYOUCarButton.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "UIButton+YYOUCarButton.h"

@implementation UIButton (YYOUCarButton)
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor{
    return [UIButton buttonWithText:text normalColor:normalColor selectColor:[UIColor clearColor]];
}

+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor{
    return [UIButton buttonWithText:text normalColor:normalColor selectColor:selectedColor font:[UIFont systemFontOfSize:17] backGroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
}

+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor backGroundColor:(UIColor *)backColor font:(UIFont *)textFont{
    return [UIButton buttonWithText:text normalColor:normalColor selectColor:[UIColor clearColor] font:textFont backGroundColor:backColor];
    
}
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont{
    return [UIButton buttonWithText:text normalColor:normalColor selectColor:selectedColor font:textFont backGroundColor:[UIColor whiteColor]];
}

+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont backGroundColor:(UIColor *)backColor {
    return [UIButton buttonWithText:text normalColor:normalColor selectColor:selectedColor font:textFont backGroundColor:backColor alignment:NSTextAlignmentLeft];
}
+(instancetype)buttonWithText:(NSString *)text normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectedColor font:(UIFont *)textFont backGroundColor:(UIColor *)backColor alignment:(NSTextAlignment)alignment{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitleColor:normalColor forState:UIControlStateNormal];
    [button setTitleColor:selectedColor forState:UIControlStateSelected];
    button.titleLabel.font = textFont;
    button.backgroundColor = backColor;
    button.titleLabel.textAlignment = alignment;
    return button;
}
@end
