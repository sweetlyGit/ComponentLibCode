//
//  PickerPhoto.m
//  ZLAssetsPickerDemo
//
//  Created by 张磊 on 14-11-15.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "ZLPhotoPickerBrowserPhoto.h"
//#import "YYOUImgInfoApi.h"
#import <SDWebImage/SDWebImageManager.h>
@interface ZLPhotoPickerBrowserPhoto()
@property (nonatomic, copy) NSString *photoSize;
@end
@implementation ZLPhotoPickerBrowserPhoto
- (instancetype)init {
    self = [super init];
    if (self) {
        _photoSize = @"";
    }
    return self;
}

- (void)setPhotoObj:(id)photoObj{
    _photoObj = photoObj;
    
    if ([photoObj isKindOfClass:[ZLPhotoAssets class]]) {
        ZLPhotoAssets *asset = (ZLPhotoAssets *)photoObj;
        self.asset = asset;
    }else if ([photoObj isKindOfClass:[NSURL class]]){
        self.photoURL = photoObj;
    }else if ([photoObj isKindOfClass:[UIImage class]]){
        self.photoImage = photoObj;
    }else if ([photoObj isKindOfClass:[NSString class]]){
        self.photoURL = [NSURL URLWithString:photoObj];
    }else{
        NSAssert(true == true, @"您传入的类型有问题");
    }
}

- (UIImage *)photoImage{
    if (!_photoImage && self.asset) {
        if ([self.asset isKindOfClass:[UIImage class]]) {
            _photoImage = (UIImage *)self.asset;
        }else if([self.asset isKindOfClass:[ZLPhotoAssets class]]){
            _photoImage = [self.asset originImage];
        }
    }
    return _photoImage;
}

- (UIImage *)aspectRatioImage{
    if (!_aspectRatioImage) {
        return [self.asset aspectRatioImage];
    }
    return _aspectRatioImage;
}

- (UIImage *)thumbImage{
    if (!_thumbImage) {
        if (self.asset) {
            _thumbImage = [self.asset thumbImage];
        }else if (_photoImage){
            _thumbImage = _photoImage;
        }else if ([_toView isKindOfClass:[UIImageView class]]){
            _thumbImage = ((UIImageView *)_toView).image;
        }
    }
    return _thumbImage;
}

- (void)setOriginPhotoURL:(NSURL *)originPhotoURL {
    
    _originPhotoURL = originPhotoURL;
    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    [manager cachedImageExistsForURL:originPhotoURL completion:^(BOOL isInCache) {
        if (isInCache) {
            self->_hasOriginPhotoInCache = YES;
        }else{
            self->_hasOriginPhotoInCache = NO;
        }
    }];
}

#pragma mark - 传入一个图片对象，可以是URL/UIImage/NSString，返回一个实例
+ (instancetype)photoAnyImageObjWith:(id)imageObj{
    ZLPhotoPickerBrowserPhoto *photo = [[self alloc] init];
    [photo setPhotoObj:imageObj];
    return photo;
}

#pragma mark -  传入原图url，可以是URL/UIImage/NSString，获取原图大小
- (void)requestOriginImageSize:(NSString *)imageUrl success:(void (^)(NSInteger))success fail:(void (^)(NSInteger))fail {
    self.getSizeSuccess = success;
    self.getSizeFail = fail;
    __weak typeof(self)weakSelf = self;
    NSString *seperatorChar = [[NSUserDefaults standardUserDefaults] valueForKey:@"seperatorChar"];
    if (seperatorChar && ![seperatorChar isEqualToString:@""]) {
        NSArray *seperateArray = [imageUrl componentsSeparatedByString:seperatorChar];
        if (seperateArray.count > 2) {
            NSString *sizeStr = seperateArray[1];
            NSString *checkedNumString = [sizeStr stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
            if(checkedNumString.length > 0) {
                [self loadOriginImageSize:imageUrl success:success fail:fail];
            }
            else {
                _photoSize = [self transferSizeToString:sizeStr.longLongValue] ;
                weakSelf.getSizeSuccess(self.photoIndex);
            }
        }
        else {
            [self loadOriginImageSize:imageUrl success:success fail:fail];
        }
    }
    else {
        [self loadOriginImageSize:imageUrl success:success fail:fail];
    }
    
}

- (void)loadOriginImageSize:(NSString *)imageUrl success:(void (^)(NSInteger))success fail:(void (^)(NSInteger))fail {
    NSString *keyName = [[NSUserDefaults standardUserDefaults] valueForKey:@"keyName"];
    if (keyName) {
       /* __weak typeof(self)weakSelf = self;
        YYOUImgInfoApi *api = [[YYOUImgInfoApi alloc]init];
        api.baseUrl = [NSString stringWithFormat:@"%@",imageUrl];
        NSArray *keyArr = [keyName componentsSeparatedByString:@"|"];
        [api startWithCompletionBlockWithSuccess:^(__kindof YTKBaseRequest * _Nonnull request) {
            NSDictionary *dic = [request.responseData objectFromJSONData];
            NSLog(@"===============%@",dic[@"FileSize"]);
            NSLog(@"================%@",request.requestUrl);
//            NSString *imgsize = dic[@"FileSize"][@"value"];
            id result = dic;
            for (NSString *key in keyArr) {
                result = result[key];
            }
            if ([result isKindOfClass:[NSString class]]) {
                NSString *size = (NSString *)result;
                if (size.longLongValue>0) {
                    weakSelf.photoSize = [weakSelf transferSizeToString:size.longLongValue];
                }
            }
            if (![weakSelf.photoSize isEqualToString:@""]) {
                weakSelf.getSizeSuccess(self.photoIndex);
            }
            else {
                weakSelf.getSizeFail(self.photoIndex);
            }
            
        } failure:^(__kindof YTKBaseRequest * _Nonnull request) {
            
            NSLog(@"========%@",request.error.description);
            weakSelf.getSizeFail(self.photoIndex);
        }];*/
    }
}

- (NSString *)transferSizeToString:(long long)size {
    if (size/(1024*1024)>0) {
        return [NSString stringWithFormat:@"%.2fM",(float)(size/(1024*1024))];
    }
    else {
        if (size/1024 > 0) {
            return [NSString stringWithFormat:@"%.2lldK",size/1024];
        }
        else {
            return [NSString stringWithFormat:@"%.2lldB",size];
        }
    }
}

@end
