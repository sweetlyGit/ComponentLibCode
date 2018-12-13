//
//  YYOUCarTxtFiled+YYOUCarTextsFiled.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/10.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarTxtFiled.h"

@interface YYOUCarTxtFiled (YYOUCarTextsFiled)
+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font keyboardType:(UIKeyboardType)boardType;

+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font keyboardType:(UIKeyboardType)boardType secureTextEntry:(BOOL)textEntry;
+(instancetype)textFiledWithPlaceHoder:(NSString *)placeHoder borderStyle:(UITextBorderStyle)borderStyle textColor:(UIColor *)color textFont:(UIFont *)font secureTextEntry:(BOOL)textEntry keyboardType:(UIKeyboardType)boardType borderColor:(UIColor *)borderColor;
@end
