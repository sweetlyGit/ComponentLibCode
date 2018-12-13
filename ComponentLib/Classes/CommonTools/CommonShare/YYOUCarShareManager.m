//
//  YYOUCarShareManager.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarShareManager.h"
#import "NSString+YYOUCarString.h"
#import "WXApi.h"

static YYOUCarShareManager * shareManager = nil;

@implementation YYOUCarShareManager
+ (YYOUCarShareManager *)shareManage{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager = [[YYOUCarShareManager alloc] init];
    });
    return shareManager;
}
-(void)shareToThirdWithIndex:(NSInteger )index shareModel:(YYOUCarShareModel *)model{
    if (index == 0 ) {
        //微信分享
        [self sendNewsContent:WXSceneSession shareModel:model];
    }else{
        //微信朋友圈
        [self sendNewsContent:WXSceneTimeline shareModel:model];
    }
}
-(void)sendNewsContent:(int)scene shareModel:(YYOUCarShareModel *)shareModel {
    shareModel.shareType = @"1";
    if ([shareModel.shareType isEqualToString:@"0"]) {
        //文字
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.text   = shareModel.title;
        req.bText = YES;
        req.scene = scene;
        [WXApi sendReq:req];
    }else if ([shareModel.shareType isEqualToString:@"1"]){
        //图文
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = [NSString nullToString:shareModel.title];
        message.description =  [NSString nullToString:shareModel.summary];
        if (shareModel.shareImage) {
            [message setThumbImage:shareModel.shareImage];//图片必须小于32k 否则点击分享无反应
        }
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = shareModel.shareUrl;
        message.mediaObject = ext;
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene =  scene;
        [WXApi sendReq:req];
    }else if ([shareModel.shareType isEqualToString:@"2"]){
        //图片
        WXMediaMessage *message = [WXMediaMessage message];
        // 设置消息缩略图的方法
        if (shareModel.shareImage) {
            [message setThumbImage:shareModel.shareImage];
        }
        // 多媒体消息中包含的图片数据对象
        WXImageObject *imageObject = [WXImageObject object];
        UIImage *image = shareModel.shareImage;
        // 图片真实数据内容
        NSData *data = UIImagePNGRepresentation(image);
        imageObject.imageData = data;
        message.mediaObject = imageObject;
        
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = scene;// 分享到朋友圈
        [WXApi sendReq:req];
    }else{
        //视频
        SendMessageToWXReq *req1 = [[SendMessageToWXReq alloc]init];
        // 是否是文档
        req1.bText =  NO;
        req1.scene = scene;
        //创建分享内容对象
        WXMediaMessage *urlMessage = [WXMediaMessage message];
        urlMessage.title =shareModel.title;//分享标题
        urlMessage.description = shareModel.summary;//分享描述
        [urlMessage setThumbImage:shareModel.shareImage];//分享图片,使用SDK的setThumbImage方法可压缩图片大小
        //创建多媒体对象
        static NSString *kLinkURL = @"";
        WXVideoObject *video = [WXVideoObject object];
        video.videoUrl = kLinkURL;//分享链接
        //完成发送对象实例
        urlMessage.mediaObject = video;
        req1.message = urlMessage;
        //发送分享信息
        [WXApi sendReq:req1];
    }
    
}
@end
