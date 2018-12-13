//
//  YYOUCarWebViewHelper.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/12.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarWebViewHelper.h"
#import "YYOUCommonHeader.h"
@interface YYOUCarWebViewHelper ()
@property (weak, nonatomic) WKWebView *webView;
@end
@implementation YYOUCarWebViewHelper
+(instancetype)initWithWebWebView:(WKWebView *)webView delegate:(id)delegate{
    YYOUCarWebViewHelper *helper = [[YYOUCarWebViewHelper alloc] init];
    helper.webView = webView;
    helper.delegate = delegate;
    return helper;
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    id messageResut = message.body;
        /*if ([self.delegate respondsToSelector:@selector(JSOCActionWithDictory:type:)]) {
            [self.delegate JSOCActionWithDictory:[NSDictionary dictionaryWithDictionary:messageResut] type:[NSString nullToString:message.name]];
        }*/
    if ([self.delegate respondsToSelector:@selector(JSOCActionWithResult:type:)]) {
        [self.delegate JSOCActionWithResult:messageResut type:[NSString nullToString:message.name]];
    }
}
@end
