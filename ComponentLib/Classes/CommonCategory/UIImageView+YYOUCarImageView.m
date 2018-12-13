//
//  UIImageView+YYOUCarImageView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "UIImageView+YYOUCarImageView.h"
#import "YYOUCommonHeader.h"
#import "UIImage+YYOUCarImage.h"
@implementation UIImageView (YYOUCarImageView)

//主项目加载本地图片资源
+(UIImageView *)imageViewWithName:(NSString *)name{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:name];
    return imageView;
}
+ (UIImageView *)imageViewWithName:(NSString *)name bundelName:(NSString *)bundleName superView:(id)superView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imgWithName:name bundleName:bundleName];
    [superView addSubview:imageView];
    return imageView;
}
+(UIImageView *)imageViewWithFrame:(CGRect)frame{
    return [self imageViewWithName:@"" bundleName:@"" imageFrame:frame];
}
+(UIImageView *)imageViewWithName:(NSString *)name bundleName:(NSString *)bundleName imageFrame:(CGRect)frame{
    return [self imageViewWithName:name bundleName:bundleName imageFrame:frame contentModel:UIViewContentModeScaleToFill corRadifous:CGSizeZero];
}
+(UIImageView *)imageViewWithName:(NSString *)name bundleName:(NSString *)bundleName imageFrame:(CGRect)frame contentModel:(UIViewContentMode)contentModel corRadifous:(CGSize)corRadSize{
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
    imageView.image = [UIImage imgWithName:name bundleName:bundleName];
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:imageView.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:corRadSize];
    //cornerRadii=imageView.bounds.size 为圆形
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc]init];
    //设置大小
    maskLayer.frame = imageView.bounds;
    //设置图形样子
    maskLayer.path = maskPath.CGPath;
    imageView.layer.mask = maskLayer;
    imageView.contentMode = contentModel;
    return imageView;
}
@end
