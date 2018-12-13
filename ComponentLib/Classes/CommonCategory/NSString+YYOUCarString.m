//
//  NSString+YYOUCarString.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "NSString+YYOUCarString.h"

@implementation NSString (YYOUCarString)

+ (CGSize)boundingRectWithText:(NSString *)text font:(UIFont *)font size:(CGSize)size {
    NSDictionary *dic = @{NSFontAttributeName:font};
    CGSize rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return rect;
}

+ (BOOL)isEmpty:(NSString *)str
{
    if ([str isKindOfClass:[NSNumber class]]) {
        NSNumber *tmpNum = (NSNumber *)str;
        NSString *tmpStr = [tmpNum stringValue];
        
        if (tmpStr == nil) {
            return YES;
        }
        
        return NO;
    }
    
    if (str == nil) {
        return YES;
    }
    
    if ((NSNull *) str == [NSNull null]) {
        return YES;
    }
    
    if ([str isEqual: @"(null)"]) {
        return YES;
    }
    
    if ([str isEqualToString:@"null"]) {
        return YES;
    }
    
    if ([str length] == 0) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] length] == 0) {
        return YES;
    }
    
    return NO;
}
+ (NSString *)nullToString:(id)str{
    NSString * nullStr = [NSString stringWithFormat:@"%@",str];
    if ([[self class] isEmpty:[NSString stringWithFormat:@"%@",nullStr]]) {
        return @"";
    }else{
        return nullStr;
    }
}
+(NSString *)subStringFrom:(NSString *)startString to:(NSString *)endString contentString:(NSString *)content{
    NSRange startRange = [content rangeOfString:startString];
    NSRange endRange = [content rangeOfString:endString];
    NSRange range = NSMakeRange(startRange.location + startRange.length, endRange.location - startRange.location - startRange.length);
    return [content substringWithRange:range];
}
+(NSString *)removeSpacesWithString:(NSString *)string{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}
@end
