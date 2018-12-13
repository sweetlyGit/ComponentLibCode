//
//  YYOUCarShareMenuView.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYOUCarShareModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface YYOUCarShareMenuView : UIView
-(id)initWithFrame:(CGRect)frame shareIcons:(NSArray *)icons shareTitle:(NSArray *)titles shareModel:(YYOUCarShareModel *)model;
@property(nonatomic,copy) void(^removeShareViewBlock)(void);
@end

NS_ASSUME_NONNULL_END
