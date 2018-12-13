//
//  UIImage+YYOUCarImage.m
//  ActionSheetPicker-3.0
//
//  Created by yonyou on 2018/12/11.
//

#import "UIImage+YYOUCarImage.h"

@implementation UIImage (YYOUCarImage)
+(UIImage *)imgWithName:(NSString *)name bundleName:(NSString *)bundleName{
    
    NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    UIImage *image =nil;
    if (bundleURL) {
        NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
        NSInteger scale = [[UIScreen mainScreen] scale];
        NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", name,scale];
        image = [UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]];
        
    }
    return image;
}
@end
