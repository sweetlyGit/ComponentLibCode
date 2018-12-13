//
//  UIImageView+YYOUCarImageView.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (YYOUCarImageView)

//主项目加载本地图片资源
+(UIImageView *)imageViewWithName:(NSString *)name;

/**
 设置imageView
 
 @param name 图片名称
 @param bundleName 资源名
 @param superView 父类
 @return imageView
 */
+ (UIImageView *)imageViewWithName:(NSString *)name bundelName:(NSString *)bundleName superView:(id)superView;


+(UIImageView *)imageViewWithFrame:(CGRect)frame;


/**
 imageView扩展
 
 @param name 图片名称
 @param bundleName 图片资源包名
 @param frame 图片大小
 @return 返回图片
 */
+(UIImageView *)imageViewWithName:(NSString *)name bundleName:(NSString *)bundleName imageFrame:(CGRect)frame;
/**
 imageView扩展
 
 @param name 图片名称
 @param bundleName 资源包名
 @param frame 图片大小
 @return 返回图片
 */
+(UIImageView *)imageViewWithName:(NSString *)name bundleName:(NSString *)bundleName imageFrame:(CGRect)frame contentModel:(UIViewContentMode)contentModel corRadifous:(CGSize)corRadSize;
@end
