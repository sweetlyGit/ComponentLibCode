//
//  YYOUCarTxtFiled+YYOUCarTextsFiled.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarTxtFiled+YYOUCarTextsFiled.h"

@implementation YYOUCarTxtFiled (YYOUCarTextsFiled)
+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font keyboardType:(UIKeyboardType)boardType{
    return [self textFiledWithPlaceHoder:placeHoder borderStyle:borderStyle textColor:color textFont:font keyboardType:boardType secureTextEntry:NO];
}
+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font keyboardType:(UIKeyboardType)boardType secureTextEntry:(BOOL)textEntry{
    return [self textFiledWithPlaceHoder:placeHoder borderStyle:borderStyle textColor:color textFont:font secureTextEntry:textEntry keyboardType:boardType borderColor:[UIColor clearColor]];
}
+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font secureTextEntry:(BOOL)textEntry keyboardType:(UIKeyboardType)boardType borderColor:(UIColor *)borderColor{
    YYOUCarTxtFiled *Textfiled = [[YYOUCarTxtFiled alloc] init];
    Textfiled.placeholder = placeHoder;
    Textfiled.borderStyle = borderStyle;
    Textfiled.leftViewMode = UITextFieldViewModeAlways;
    Textfiled.clearButtonMode = UITextFieldViewModeWhileEditing;
    Textfiled.textColor = color;
    Textfiled.font = font;
    Textfiled.keyboardType = boardType;
    Textfiled.layer.borderColor = borderColor.CGColor;
    return Textfiled;
}
@end
