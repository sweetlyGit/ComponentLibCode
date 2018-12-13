//
//  YYOUCarCommonModel.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/12/3.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface YYOUUserInfoModel : NSObject
@property (nonatomic,copy)NSString *avatar;
@property (nonatomic,copy)NSString *userId;
@property (nonatomic,copy)NSString *nickname;
@property (nonatomic,copy)NSString *phone;
@property (nonatomic,copy)NSString *newsSummary;
@property (nonatomic,copy)NSString *userType;
@end

@interface YYOUCarCommonModel : NSObject
///业务id
@property (nonatomic,copy)NSString *idString;
///业务标题
@property (nonatomic,copy)NSString *title;
///用户id
@property (nonatomic,copy)NSString *userId;
///评论内容
@property (nonatomic,copy)NSString *content;
//经度
@property (nonatomic,copy)NSString *latitude;
//纬度
@property (nonatomic,copy)NSString *longitude;
///用户信息
@property (nonatomic,strong)YYOUUserInfoModel *userInfo;
@end

NS_ASSUME_NONNULL_END
