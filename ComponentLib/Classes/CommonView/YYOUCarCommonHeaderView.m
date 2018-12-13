//
//  YYOUCarCommonHeaderView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/15.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarCommonHeaderView.h"
#import "YYOUCommonHeader.h"
@implementation YYOUCarCommonHeaderView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        WEAK_SELF
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor whiteColor];
        [self addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(weakSelf.mas_left).offset(0);
            make.right.equalTo(weakSelf.mas_right).offset(0);
            make.top.equalTo(weakSelf.mas_top).offset(0);
            make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
            make.height.equalTo(@1);
        }];
    }
    return self;
}
@end
