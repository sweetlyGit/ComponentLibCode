//
//  YYOUCarShareCollectionCell.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarShareCollectionCell.h"
#import "YYOUCommonHeader.h"
#import "UIColor+YYOUHexString.h"
@implementation YYOUCarShareCollectionCell
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.shareImageView];
        [self addSubview:self.titleLabel];
        
    }
    return self;
}
- (UIImageView *)shareImageView {
    if (!_shareImageView) {
        _shareImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, ((SCREEN_WIDTH/5)-20), ((SCREEN_WIDTH/5)-20))];
    }
    return _shareImageView;
}
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.shareImageView.frame) + 5, SCREEN_WIDTH / 5, 20)];
        _titleLabel.textColor = [UIColor colorWithHexString:@"#666666"];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12];
    }
    return _titleLabel;
}
@end
