//
//  YYOUCarShareMenuView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/11/9.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarShareMenuView.h"
#import <SDWebImage/SDImageCache.h>
#import "YYOUCommonHeader.h"
#import "UIColor+YYOUHexString.h"
#import "YYOUCarShareCollectionCell.h"
#import "YYOUCarShareManager.h"
#import "WXApi.h"
#import "UIView+Toast.h"
#import "UIImage+YYOUCarImage.h"
#define CollectionViewCellHeight (10 + (SCREEN_WIDTH/5) + 5 +10)//每一个cell的高
@interface YYOUCarShareMenuView()<UICollectionViewDelegate,UICollectionViewDataSource>
///菜单view
@property (nonatomic, strong) UIView * menuView;
///取消按钮
@property (nonatomic, strong) UIButton * cancelButton;
///菜单
@property (nonatomic, strong) UICollectionView * menuCollectionView;
@property (nonatomic, assign) NSInteger collectionSections;
@property (strong,nonatomic) SDImageCache *imageCache;
@property (nonatomic, strong) NSMutableArray * shareTitleArray;//分享标题
@property (nonatomic, strong) NSMutableArray * shareImageArray;//分享图片
@property(nonatomic,strong)YYOUCarShareModel *shareModel;
@property(nonatomic,strong)UIButton *topButton;
@end
@implementation YYOUCarShareMenuView
-(id)initWithFrame:(CGRect)frame shareIcons:(NSArray *)icons shareTitle:(NSArray *)titles shareModel:(YYOUCarShareModel *)model{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
        self.shareTitleArray = [NSMutableArray arrayWithArray:titles];
        self.shareImageArray = [NSMutableArray arrayWithArray:icons];
        self.shareModel = model;
        self.collectionSections = 1;
        [self addSubview:self.topButton];
        [self addSubview:self.menuView];
        
        self.imageCache = [SDImageCache sharedImageCache];

        
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
//        [self addGestureRecognizer:tap];
    }
    return self;
}
//-(void)tapGesture:(UITapGestureRecognizer *)tap{
//    if (self.removeShareViewBlock) {
//        self.removeShareViewBlock();
//    }
//}
-(UIButton *)topButton{
    if (!_topButton) {
        CGFloat addHeight = 0;
        NSInteger ind = self.collectionSections;
        if (iPhoneX) {
            addHeight = 15;
        }else{
            addHeight = 0;
        }
        _topButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _topButton.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.frame.size.height-((CollectionViewCellHeight*ind)+48+addHeight));
        _topButton.backgroundColor = [UIColor clearColor];
        [_topButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topButton;
}
//取消按钮
- (UIButton *)cancelButton {
    if (!_cancelButton) {
        NSInteger ind = self.collectionSections;
        _cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, ind * CollectionViewCellHeight, SCREEN_WIDTH, 48)];
        _cancelButton.backgroundColor = [UIColor colorWithHexString:@"#F3F2F2"];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButton addTarget:self action:@selector(cancelAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelButton;
}
//取消
- (void)cancelAction:(UIButton *)sender {
    if (self.removeShareViewBlock) {
        self.removeShareViewBlock();
    }
}
- (UICollectionView *)menuCollectionView {
    if (!_menuCollectionView) {
        UICollectionViewFlowLayout * flowOut = [[UICollectionViewFlowLayout alloc] init];
        flowOut.minimumLineSpacing = 0;
        flowOut.minimumInteritemSpacing = 0;
        _menuCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowOut];
        NSInteger ind = self.collectionSections;
//        if (self.actionTitleArray.count>5) {
//            ind = self.collectionSections+1;
//        }else{
//            ind = self.collectionSections;
//        }
        _menuCollectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, CollectionViewCellHeight * ind);
        _menuCollectionView.delegate = self;
        _menuCollectionView.dataSource = self;
        _menuCollectionView.scrollEnabled = NO;
        _menuCollectionView.backgroundColor = [UIColor whiteColor];
        [_menuCollectionView registerClass:[YYOUCarShareCollectionCell class] forCellWithReuseIdentifier:@"YYOUCarShareCollectionCell"];
    }
    return _menuCollectionView;
}
#pragma mark - CollectionViewDatesource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    //分享存在
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    //含有分享的东西
    return self.shareTitleArray.count;
//
    //    //只有一行
    //    if (self.collectionSections <= 5) {
    //        return self.titleArray.count;
    //    }
    
    //    //两行
    //    NSInteger num = section * 5;
    //    return (self.titleArray.count - num) > 5 ? 5 : (self.titleArray.count - 5);
}
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    YYOUCarShareCollectionCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YYOUCarShareCollectionCell" forIndexPath:indexPath];
    cell.shareImageView.image = [UIImage imgWithName:self.shareImageArray[indexPath.row] bundleName:@"CZCommonLibBundle"];
//    [UIImage imageNamed:self.shareImageArray[indexPath.row]];
    cell.titleLabel.text = self.shareTitleArray[indexPath.row];
    return cell;
}
#pragma mark - CollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    WEAK_SELF
  YYOUCarShareCollectionCell * cell = (YYOUCarShareCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if ([cell.titleLabel.text isEqualToString:@"举报"]) {
        //举报
        [self makeToast:@"已举报" duration:0.2 position:CSToastPositionCenter];
        double delayInSeconds = 0.5;
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW,delayInSeconds * NSEC_PER_SEC);
        dispatch_after(popTime, mainQueue, ^{
            if (weakSelf.removeShareViewBlock) {
                weakSelf.removeShareViewBlock();
            }
        });
    }else{
        if ([WXApi isWXAppInstalled]) {
            if (self.removeShareViewBlock) {
                self.removeShareViewBlock();
            }
            [self weiXinShareWithModel:self.shareModel indexRow:indexPath.row];
        }else{
            [self makeToast:@"还没有安装微信哦" duration:0.4 position:CSToastPositionCenter];
        }
    }
}
-(void)weiXinShareWithModel:(YYOUCarShareModel *)model indexRow:(NSInteger)index{
    
    UIImage *image = [self.imageCache imageFromDiskCacheForKey:[NSString nullToString:model.titleImage]];
    if (image != nil) {
        model.shareImage =  [UIImage imageWithData:[self imageWithImage:image scaledToSize:CGSizeMake(300, 300)]];
    }else{
        WEAK_SELF
        //下载图片
        [[SDWebImageManager sharedManager] loadImageWithURL:[NSURL URLWithString:model.titleImage] options:SDWebImageContinueInBackground progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {} completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
            if (image!=nil) {
                [weakSelf.imageCache storeImage:image forKey:[NSString nullToString:model.titleImage] completion:nil];
                model.shareImage =  [UIImage imageWithData:[self imageWithImage:image scaledToSize:CGSizeMake(300, 300)]];
                NSLog(@"图片下载成功");
            }else{
                model.shareImage = [UIImage imgWithName:@"position_picture" bundleName:@"CZCommonLibBundle"];
//                [UIImage imageNamed:@"position_picture.png"];
                NSLog(@"图片下载失败");
            }
        }];
    }

    YYOUCarShareManager *shareManager = [YYOUCarShareManager shareManage];
    [shareManager shareToThirdWithIndex:index shareModel:model];
}
- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
{
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 1, 0);
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH / 5.0, CollectionViewCellHeight);

}
//菜单view
- (UIView *)menuView {
    if (!_menuView) {
        CGFloat addHeight = 0;
        CGFloat menuViewHeight = 388;
        if (iPhoneX) {
            addHeight = 15;
            menuViewHeight = 388 + 15;
        }
        
        _menuView = [[UIView alloc] init];
        NSInteger ind = self.collectionSections;
//        if (self.actionTitleArray.count>5) {
//            ind = self.collectionSections+1;
//        }else{
//            ind = self.collectionSections;
//        }
//
        _menuView.frame = CGRectMake(0, self.frame.size.height-CollectionViewCellHeight-48, SCREEN_WIDTH, CollectionViewCellHeight * ind + 48 + addHeight);
        _menuView.backgroundColor = [UIColor colorWithHexString:@"#F3F2F2"];
        [_menuView addSubview:self.menuCollectionView];
        [_menuView addSubview:self.cancelButton];
    }
    return _menuView;
}
@end
