//
//  YYOUCommonHeader.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#ifndef YYOUCommonHeader_h
#define YYOUCommonHeader_h
#import <Masonry/Masonry.h>
#import "UIButton+YYOUCarButton.h"
#import "UILabel+YYOUCarLabel.h"
#import "UIImageView+YYOUCarImageView.h"
#import "YYOUCarUserInfoManager.h"
#import "NSString+YYOUCarString.h"
#import "UIImageView+WebCache.h"
#import "YYOUCommonHeader.h"
#import "YYOUCarUIUtils.h"

///服务器域名地址
#define REQUESTURL @"http://10.180.4.224:31080/api/"
//#define UPLOADIMAGE_URL  @"oss/upload"
#define UPLOADIMAGE_URL  @"file/oss/uploads"

#define GiftEncryptionKey @"admin"
//当前屏幕高度
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

//当前屏幕高度
#define SCREENH_HEIGHT [UIScreen mainScreen].bounds.size.height

//以RGB三原色设置s颜色
#define RGB(r, g, b)  [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//默认的页面背景色
#define GRAYCOLOR  RGB(246, 246, 246)

//弱引用
#define WEAK_SELF  __weak __typeof(&*self)weakSelf = self;

//判断当前设备是否为iPhone X
#define iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125,2436), [[UIScreen mainScreen] currentMode].size) : NO)

//当前APP主题颜色，统一设置导航颜色
#define THEME_NAVCOLOR RGB(56, 139, 250)

// 底部tabbar占用高度
#define TABBAR_HEIGHT (iPhoneX ? 83.0f:49.0f) // 适配iPhone x 底栏高度
//导航高度
#define NAVIGATION_HEIGHT (iPhoneX ? 88.f:64.f)

//常用用户信息->用户ID
#define YUSERID [NSString stringWithFormat:@"%@",[YYOUCarUserInfoManager shareUserInfo].userId]

//常用用户信息 ->用户名
#define YUSER_NAME [NSString stringWithFormat:@"%@",[YYOUCarUserInfoManager shareUserInfo].userName]

//新版iPhone适配
#define TheIPhoneXSeries \
({\
BOOL whethIsIphoneX;\
if (CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)) {\
whethIsIphoneX = YES;\
} else if (CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size)) {\
whethIsIphoneX = YES;\
} else if (CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)) {\
whethIsIphoneX = YES;\
} else {\
whethIsIphoneX = NO;\
}\
(whethIsIphoneX);\
})



















#endif /* YYOUCommonHeader_h */
