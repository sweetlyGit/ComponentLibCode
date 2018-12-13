//
//  MBProgressHUD+YYOUCarMBProgress.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/31.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (YYOUCarMBProgress)
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view;
+ (void)hideHUDForView:(UIView *)view;

@end
