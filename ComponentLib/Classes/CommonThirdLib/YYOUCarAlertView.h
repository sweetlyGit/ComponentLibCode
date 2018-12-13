//
//  YYOUCarAlertView.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,CZAlertViewStyle) {
    CZAlertViewAlert = 0,//中间弹框
    CZAlertViewSheet,//底部弹框
};

typedef void (^clickBlock)(NSInteger itemIndex);
@interface YYOUCarAlertView : UIView
/*
 
 调用的时候回调实在闭包里面,请注意避免循环引用
 
 */

/**
 弹框封装
 
 @param title 标题
 @param message 信息
 @param cancelTitle 取消按钮文字
 @param actionsArr 按钮数组
 @param style 弹框类型(中间或者是底部)
 @param controller 弹出视图的父视图
 @param itemBlock 回调
 */
+ (void)AlertViewWithTitle:(NSString *)title message:(NSString *)message acitons:(NSArray *)actionsArr style:(CZAlertViewStyle)style inView:(UIViewController*)controller itemblock:(clickBlock)itemBlock;
@end
