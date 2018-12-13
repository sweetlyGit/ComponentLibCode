//
//  YYOUCarWebViewHelper.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
NS_ASSUME_NONNULL_BEGIN
@protocol YYOUCarWebViewHelperDelegate <NSObject>
@optional
//- (void)JSOCActionWithDictory:(NSDictionary *)dict type:(NSString *)type;
-(void)JSOCActionWithResult:(id)result type:(NSString *)type;
@end
@interface YYOUCarWebViewHelper : NSObject<WKScriptMessageHandler>
@property (weak, nonatomic) id<YYOUCarWebViewHelperDelegate> delegate;
+ (instancetype)initWithWebWebView:(WKWebView *)webView delegate:(id)delegate;
@end

NS_ASSUME_NONNULL_END
