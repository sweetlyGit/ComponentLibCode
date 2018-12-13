//
//  YYOUCarCommonModel.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/12/3.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarCommonModel.h"

@implementation YYOUUserInfoModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"userId":@"id"
             };
}
@end

@implementation YYOUCarCommonModel

+(NSDictionary *)mj_objectClassInArray{
    return @{@"userList":[YYOUUserInfoModel class],@"insterestedsList":[YYOUUserInfoModel class]};
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"idString":@"id"
             };
}
@end
