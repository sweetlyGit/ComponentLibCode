//
//  YYOUCarUserInfoManager.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
//定义字段和服务器返回字段必须一一对应
@interface YYOUCarUserInfoManager : NSObject
///用户名
@property (nonatomic,copy) NSString *userName;
///用户id
@property (nonatomic,copy) NSString *userId;
///用户昵称
@property (nonatomic,copy) NSString *nickname;
///用户头像
@property (nonatomic,copy) NSString *iconsPhoto;
///用户手机号
@property (nonatomic,copy) NSString *phone;
///用户生日
@property (nonatomic,copy) NSString *birthday;
///用户邮箱
@property (nonatomic,copy) NSString *email;
///上次登录时间
@property (nonatomic,copy) NSString *logTime;
///地址
@property (nonatomic,copy) NSString *address;
///地区
@property (nonatomic,copy) NSString *area;
///城市
@property (nonatomic,copy) NSString *city;
///驾驶证有效期
@property (nonatomic,copy) NSString *driverLicenseExpired;
///登录错误次数限制，如果超过5次，密码需要重置 integer
@property (nonatomic,copy) NSString *errCount;
///0消息提示，1消息不提示 integer
@property (nonatomic,copy) NSString *hintStat;
///身份证号
@property (nonatomic,copy) NSString *identityCard;
///等级
@property (nonatomic,copy) NSString *level;
///密码,不予展示
@property (nonatomic,copy) NSString *password;
///省份
@property (nonatomic,copy) NSString *province;
///个人二维码url
@property (nonatomic,copy) NSString *qrCodeUrl;
///唯一登录标志
@property (nonatomic,copy) NSString *recommendedName;
///注册时间
@property (nonatomic,copy) NSString *registerDate;
///学历
@property (nonatomic,copy) NSString *schooling;
///分数 integer
@property (nonatomic,copy) NSString *score;
///1：男2：女 integer
@property (nonatomic,copy) NSString *sex;
///分享日期
@property (nonatomic,copy) NSString *shareDate;
///每日分享次数 integer
@property (nonatomic,copy) NSString *shareNum;
///0：正常 1：停用 integer
@property (nonatomic,copy) NSString *status;
///TOKEN
@property (nonatomic,copy) NSString *token;
///1：车主 2：销售店 3：车厂 integer
@property (nonatomic,copy) NSString *userType;
///微信号
@property (nonatomic,copy) NSString *wxCode;
///婚姻：0 未婚 1 已婚 2 离异
@property (nonatomic,copy) NSString *marriage;
///头像
@property (nonatomic,copy) NSString *avatar;



//存在问题 服务器返回字段 没有定义会奔溃 不一致会奔溃 解决id问题

/**
 单例工具初始化
 */
+(instancetype)shareUserInfo;

/**
 通过单例模式给工具赋值

 @param infoDict 服务器返回用户数据
 */
+(void)configInfo:(NSDictionary *)infoDict;

/**
 登出操作
 */
+(void)loginOut;
@end
