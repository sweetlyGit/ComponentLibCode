//
//  YYOUCarCommonToolManager.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/2.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYOUCarBaseViewController.h"
#import <CoreLocation/CLLocationManagerDelegate.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarCommonToolManager : NSObject
/**
 单例工具初始化
 */
+(instancetype)shareCommonToolManager;

/**
 图片压缩到指定大小

 @param targetSize 压缩到指定大小
 @param img 图片
 @return 压缩好后的图片
 */
+(UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize img:(UIImage *)img;

+(void)pushToViewController:(YYOUCarBaseViewController *)viewController navigation:(UINavigationController *)navigationController;

/**
 判断是否开启定位

 @return 返回是否开启定位
 */
+(BOOL)isLocationServiceOpen;

/**
 获取加密时的随机数

 @return 时间搓和随机数字典
 */
+(NSDictionary *)getRandomDict;

/**
 画背景颜色（车联网）
 
 @param viewSize 背景大小
 @return imageview
 */
+ (UIImageView*)carNetWorkBackgroundImageColor:(CGSize)viewSize;

@end

NS_ASSUME_NONNULL_END
