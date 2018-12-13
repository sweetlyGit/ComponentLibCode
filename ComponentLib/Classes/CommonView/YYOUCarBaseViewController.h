//
//  ViewController.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/30.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import "YYOUCommonHeader.h"
#import "UIView+Toast.h"
@interface YYOUCarBaseViewController : UIViewController
///公用数组
@property(nonatomic,copy)NSMutableArray *dataArray;
///请求成功回调
@property(nonatomic,copy) void(^requestSuccessBolck)(NSDictionary *result);

///请求失败回调
@property(nonatomic,copy) void(^requestFailBolck)(NSError *resultError);

/**
 导航条设置

 @param color 导航条颜色
 @param title 导航条标题
 @param font 导航条标题字体大小
 @param titleColor 导航条字体颜色
 @param leftItem 导航条左边按钮
 @param rightItem 右边按钮
 */
- (void)naviGationBarColor:(UIColor *)color title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor leftItem:(NSString *)leftItem rightItem:(NSString *)rightItem;


/**
 导航按钮的点击事件

 @param button 导航按钮
 */
- (void)navigationClick:(UIButton *)button;

/**
 网络状态判断
 */
- (void)ba_netType;

/**
 get请求
 @param url 请求地址
 @param parameters 请求参数
 */
- (void)getDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters;

/**
 post请求
 @param url 请求地址
 @param parameters 请求参数
 @param requestType 请求类型：1:application/json,2:application/x-www-form-urlencoded
 */
//- (void)postDataRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters randomDict:(NSDictionary *)randomDict requestType:(NSString *)requestType;
- (void)postDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters requestType:(NSString *)requestType;
/**
 下载
 @param url 下载地址
 @param filePath 下载路径
 */
- (void)downloadDataRequestUrl:(NSString *)url filePath:(NSString *)filePath;

/**
 上传图片
 */
- (void)uploadImageDataWithImageArray:(NSArray *)images url:(NSString *)url;

/**
 系统底部弹框

 @param message 提示信息
 @param actionArr 底部按钮
 */
-(void)setBottomSheetMessage:(NSString *)message actionArray:(NSArray *)actionArr;
/**
 底部按钮响应事件

 @param action 事件区分
 */
-(void)bottomSheetClickAction:(UIAlertAction *)action;

-(void)jumpToLoginViewController;
@end

