//
//  YYOUCarShareModel.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarShareModel : NSObject
///标题
@property(nonatomic,copy)NSString *title;
///详情
@property(nonatomic,copy)NSString *summary;
///链接
@property(nonatomic,copy)NSString *shareUrl;
///图片
@property(nonatomic,strong) UIImage *shareImage; //下载过后的 分享图片
/// 图片地址
@property(nonatomic,copy) NSString  *titleImage;//分享的图片地址 第一次下载
///分享类型 文字  图文 图片 视频
@property(nonatomic,copy) NSString  *shareType;
@end

NS_ASSUME_NONNULL_END
