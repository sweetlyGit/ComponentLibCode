//
//  YYOUCarBaseTableViewCell.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/25.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseTableViewCell.h"
#import "YYOUCommonHeader.h"
@implementation YYOUCarBaseTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = GRAYCOLOR;
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
@end
