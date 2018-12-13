//
//  YYOUCarShareManager.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YYOUCarShareModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarShareManager : NSObject
+ (YYOUCarShareManager *)shareManage;
-(void)shareToThirdWithIndex:(NSInteger )index shareModel:(YYOUCarShareModel *)model;
@end

NS_ASSUME_NONNULL_END
