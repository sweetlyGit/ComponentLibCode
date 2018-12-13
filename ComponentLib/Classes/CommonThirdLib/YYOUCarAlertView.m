//
//  YYOUCarAlertView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarAlertView.h"
@implementation YYOUCarAlertView
/*
 回调为零默认为取消按钮
 */

+ (void)AlertViewWithTitle:(NSString *)title message:(NSString *)message acitons:(NSArray *)actionsArr style:(CZAlertViewStyle)style inView:(UIViewController*)controller itemblock:(clickBlock)itemBlock{
    UIAlertControllerStyle alertStyle;
    if (!style) {
        alertStyle = UIAlertControllerStyleAlert;
    }else{
        alertStyle = UIAlertControllerStyleActionSheet;
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertStyle];
    for (NSInteger i = 0; i < actionsArr.count; i++) {
        [alertController addAction:[UIAlertAction actionWithTitle:actionsArr[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            itemBlock(i+1);
        }]];
    }
    [controller presentViewController:alertController animated:YES completion:nil];
}
@end
