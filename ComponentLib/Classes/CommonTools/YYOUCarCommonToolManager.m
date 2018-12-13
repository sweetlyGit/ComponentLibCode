//
//  YYOUCarCommonToolManager.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/2.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarCommonToolManager.h"
#import "YYOUCarUIUtils.h"
#import "NSString+YYOUCarString.h"
static YYOUCarCommonToolManager *commonTool;

@implementation YYOUCarCommonToolManager
+(instancetype)shareCommonToolManager{
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        commonTool = [[YYOUCarCommonToolManager alloc] init];
    });
    return commonTool;
}
#pragma mark -->拍照图片过大   需要压缩
//图片压缩到指定大小
+(UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize img:(UIImage *)img{
    
    UIImage *sourceImage = img;
    UIImage *newImage = nil;
    CGSize  imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    UIGraphicsEndImageContext();
    return newImage;
}
+(void)pushToViewController:(YYOUCarBaseViewController *)viewController navigation:(UINavigationController *)navigationController{
    YYOUCarBaseViewController *viewControl = [(YYOUCarBaseViewController *)[YYOUCarBaseViewController alloc] init];
    [navigationController pushViewController:viewControl animated:YES];
}

+(BOOL)isLocationServiceOpen{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied) {
        return NO;
    } else{
        return YES;
    }
}
+(NSDictionary *)getRandomDict{
    NSInteger x = arc4random() % 10000001;
    NSString *randomString = [NSString stringWithFormat:@"%ld",(long)x];
    NSString *currentTime = [NSString nullToString:[YYOUCarUIUtils getCurrentTime]];
    NSDictionary *randomDict = [NSDictionary dictionaryWithObjectsAndKeys:randomString,@"nonce",currentTime,@"occurtime", nil];
    return randomDict;
}
+ (UIImageView*)carNetWorkBackgroundImageColor:(CGSize)viewSize
{
    
    UIGraphicsBeginImageContext(viewSize);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    //创建CGMutablePathRef
    CGMutablePathRef path = CGPathCreateMutable();
    //绘制Path
    CGRect rect = CGRectMake(0, 0, viewSize.width, viewSize.height);
    CGPathMoveToPoint(path, NULL, CGRectGetMinX(rect), CGRectGetMinY(rect));
    //    CGPathAddLineToPoint(path, NULL, CGRectGetMidX(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL,0, CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMaxY(rect));
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(rect), CGRectGetMinY(rect));
    CGPathCloseSubpath(path);
    //绘制渐变
    [self drawRadialGradient:gc path:path startColor:RGB(103, 104, 105).CGColor endColor:RGB(38, 40, 45).CGColor];
    //注意释放CGMutablePathRef
    CGPathRelease(path);
    //从Context中获取图像，并显示在界面上
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *imgView = [[UIImageView alloc] initWithImage:img];
    return imgView;
}
+ (void)drawRadialGradient:(CGContextRef)context
                      path:(CGPathRef)path
                startColor:(CGColorRef)startColor
                  endColor:(CGColorRef)endColor
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    CGRect pathRect = CGPathGetBoundingBox(path);
    CGPoint center = CGPointMake(CGRectGetMidX(pathRect), CGRectGetMidY(pathRect));
    CGFloat radius = MAX(pathRect.size.width / 2.0, pathRect.size.height / 2.0) * sqrt(2);
    CGContextSaveGState(context);
    CGContextAddPath(context, path);
    CGContextEOClip(context);
    CGContextDrawRadialGradient(context, gradient, center, 0, center, radius, 0);
    CGContextRestoreGState(context);
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}
@end
