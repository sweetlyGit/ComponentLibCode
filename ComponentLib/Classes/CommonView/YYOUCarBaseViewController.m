//
//  ViewController.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/8/30.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseViewController.h"
#import <BANetManager/BANetManager.h>
#import <BANetManager/BADataEntity.h>
#import <Toast/Toast.h>
#import "UILabel+YYOUCarLabel.h"
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import "NSString+YYOUCarString.h"
#import "YYOUCarUIUtils.h"
#import "UIImage+YYOUCarImage.h"
//#import "YYOUCarLoginViewController.h"
@interface YYOUCarBaseViewController ()<UIGestureRecognizerDelegate>
@property(nonatomic,strong)UIPercentDrivenInteractiveTransition *interactiveTransition;
@end

@implementation YYOUCarBaseViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = RGB(238, 238, 238);
    self.navigationController.navigationBar.barTintColor = THEME_NAVCOLOR;
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    id target = self.navigationController.interactivePopGestureRecognizer.delegate;
    // handleNavigationTransition:为系统私有API,即系统自带侧滑手势的回调方法，我们在自己的手势上直接用它的回调方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    panGesture.delegate = self; // 设置手势代理，拦截手势触发
    [self.view addGestureRecognizer:panGesture];
    // 一定要禁止系统自带的滑动手势
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当当前控制器是根控制器时，不可以侧滑返回，所以不能使其触发手势
    if(self.navigationController.childViewControllers.count == 1)
    {
        return NO;
    }
    
    return YES;
}
-(void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{
    
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (void)naviGationBarColor:(UIColor *)color title:(NSString *)title titleFont:(UIFont *)font titleColor:(UIColor *)titleColor leftItem:(NSString *)leftItem rightItem:(NSString *)rightItem{
    //如果右边按钮不设置图片设置文字,在图片名字里面的时候一定要加上.png
    self.navigationController.navigationBar.barTintColor = color;
    self.navigationController.navigationBar.titleTextAttributes=
  @{NSForegroundColorAttributeName:[UIColor whiteColor],
    NSFontAttributeName:font};
    self.navigationItem.title = title;
    
    if (leftItem.length>0) {
        UIView *containerView = [UIView new];
        containerView.frame = (CGRect){.size = CGSizeMake(22, 18)};
        UIButton *leftbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        leftbutton.frame = containerView.frame;
        leftbutton.tag = 100;
        [leftbutton addTarget:self action:@selector(navigationClick:) forControlEvents:UIControlEventTouchUpInside];
//        [leftbutton setBackgroundImage:[UIImage imageNamed:leftItem] forState:UIControlStateNormal];
        
//        NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:@"CZCommonLibBundle" withExtension:@"bundle"];
//        UIImage *image =nil;
//        if (bundleURL) {
//            NSBundle *bundle = [NSBundle bundleWithURL:bundleURL];
//            NSInteger scale = [[UIScreen mainScreen] scale];
//            NSString *imgName = [NSString stringWithFormat:@"%@@%zdx.png", leftItem,scale];
//           image = [UIImage imageWithContentsOfFile:[bundle pathForResource:imgName ofType:nil]];
//
//        }
        [leftbutton setBackgroundImage:[UIImage imgWithName:leftItem bundleName:@"CZCommonLibBundle"] forState:UIControlStateNormal];
        [containerView addSubview:leftbutton];
        UIBarButtonItem *leftItem=[[UIBarButtonItem alloc]initWithCustomView:containerView];
    self.navigationItem.leftBarButtonItem=leftItem;
    }
//    if (rightItem.length>0) {
        UIView *containerView = [UIView new];
        containerView.frame = (CGRect){.size = CGSizeMake(22, 24)};
        UIButton *rightbutton=[UIButton buttonWithType:UIButtonTypeCustom];
        rightbutton.frame = containerView.frame;
        rightbutton.tag = 101;
        [rightbutton addTarget:self action:@selector(navigationClick:) forControlEvents:UIControlEventTouchUpInside];
        [containerView addSubview:rightbutton];
//        [rightbutton setBackgroundImage:[UIImage imageNamed:rightItem] forState:UIControlStateNormal];
    [rightbutton setBackgroundImage: [UIImage imgWithName:rightItem bundleName:@"CZCommonLibBundle"] forState:UIControlStateNormal];
        if ([rightItem containsString:@"png"]) {
            //图片
        }else{
            //设置文字
            if (rightItem.length>0) {
                rightbutton.enabled = YES;
                containerView.frame = (CGRect){.size = CGSizeMake(35, 24)};
                rightbutton.frame = containerView.frame;
                [rightbutton setTitle:[NSString nullToString:rightItem] forState:UIControlStateNormal];
                rightbutton.titleLabel.font = [UIFont boldSystemFontOfSize:15];
                [rightbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            }else{
                rightbutton.enabled = NO;
            }
        }
        UIBarButtonItem *rightBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:containerView];
        self.navigationItem.rightBarButtonItem=rightBarButtonItem;
//    }
}
- (void)navigationClick:(UIButton *)button{
    if (button.tag == 100) {
        [self.navigationController popViewControllerAnimated:YES ];
    }else{
        
    }
}
//- (void)postDataRequestUrl:(NSString *)url parameters:(NSDictionary *)parameters randomDict:(NSDictionary *)randomDict requestType:(NSString *)requestType{
- (void)postDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters requestType:(NSString *)requestType{
    WEAK_SELF
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    NSString *randomString = [NSString nullToString:[YYOUCarUIUtils getRandomString]];
    NSString *currentTime = [NSString nullToString:[YYOUCarUIUtils getCurrentTime]];
    NSDictionary *randDict = [NSDictionary dictionaryWithObjectsAndKeys:randomString,@"nonce",currentTime,@"occurtime", nil];
    NSDictionary *Finallyparam = nil;
    NSString *postUrlString = nil;
    
    if ([requestType isEqualToString:@"1"]) {
//        content-type: application/json
          //随机参数拼接排序
        BANetManagerShare.requestSerializer = BAHttpRequestSerializerJSON;
        //json格式默认请求类型为：application-json  http请求类型为：application/x-www-form-urlencoded
        // 自定义更改 responseSerializer
        BANetManagerShare.responseSerializer = BAHttpResponseSerializerJSON;
//         NSString *headerSortString = [YYOUCarUIUtils sortHeaderDict:randomDict];
        NSString *headerSortString = [YYOUCarUIUtils sortHeaderDict:randDict];
         //参数转json
//         NSString *jsonString = [parameters JSONString];
        NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
        
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
         //随机参数排序与参数拼接结果
         NSString *finallString = [NSString stringWithFormat:@"%@json=%@",headerSortString,jsonString];
         //拼接内容加密结果作为sign的value
         [BANetManager ba_setValue:[NSString nullToString:[YYOUCarUIUtils encryptionWithString:finallString]] forHTTPHeaderKey:@"sign"];
        
        Finallyparam = [NSDictionary dictionaryWithDictionary:parameters];
        
        postUrlString = [NSString stringWithFormat:@"%@?nonce=%@&occurtime=%@",url,randomString,currentTime];
    }else{
//        content-type: application/x-www-form-urlencoded
        BANetManagerShare.requestSerializer = BAHttpRequestSerializerHTTP;
        //json格式默认请求类型为：application-json  http请求类型为：application/x-www-form-urlencoded
        // 自定义更改 responseSerializer
        BANetManagerShare.responseSerializer = BAHttpResponseSerializerHTTP;
        /*NSMutableDictionary *paramDict = [NSMutableDictionary dictionaryWithDictionary:parameters];*/
        //业务参数
        Finallyparam = [NSDictionary dictionaryWithDictionary:parameters];
        //业务参数拼接随机参数字典用于sign加密
        [parameters addEntriesFromDictionary:randDict];
        [BANetManager ba_setValue:[NSString nullToString:[YYOUCarUIUtils sortDictionary:parameters]] forHTTPHeaderKey:@"sign"];
        //最终请求地址，随机数拼给后台
        postUrlString = [NSString stringWithFormat:@"%@?nonce=%@&occurtime=%@",url,randomString,currentTime];
    }
    [BANetManager ba_setValue:@"001" forHTTPHeaderKey:@"x-client-id"];
    [BANetManager ba_setValue:[YYOUCarUIUtils getUserDefaultForKey:@"token"] forHTTPHeaderKey:@"token"];
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = postUrlString;
    entity.parameters = Finallyparam;
    entity.needCache = NO;

    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *dict = nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict = [NSDictionary dictionaryWithDictionary:response];
        }else{
            NSError *error = nil;
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        }
        NSInteger resultCode = [[NSString nullToString:[dict objectForKey:@"resultCode"]] integerValue];
        if (resultCode == 900) {
            //后台不能捕获的错误
            [weakSelf.view makeToast:@"系统错误" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40104){
            //用户未登录
            [weakSelf.view makeToast:@"您目前还未登录,请先去登录" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40105){
            //登录信息已过期
            [weakSelf.view makeToast:@"登录信息已过期,请重新登录" duration:0.2 position:CSToastPositionCenter];
        }else{
            if (weakSelf.requestSuccessBolck) {
                weakSelf.requestSuccessBolck(dict);
            }
        }

//        if (resultCode == 200) {
        
              /*  id dataDict = [dict objectForKey:@"data"];
                NSDictionary *resultDict = nil;
                if ([dataDict isKindOfClass:[NSDictionary class]]) {
                    resultDict = [NSDictionary dictionaryWithDictionary:dataDict];
                }else{
                    resultDict = [NSDictionary dictionaryWithDictionary:dict];
                }*/
//        }else{
//            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
//        }
    } failureBlock:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view];
        if (weakSelf.requestFailBolck) {
            weakSelf.requestFailBolck(error);
        }
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSLog(@"蜗牛似的");
    }];
}

#pragma mark***get请求
- (void)getDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters{
    NSString *randomString = [NSString nullToString:[YYOUCarUIUtils getRandomString]];
    NSString *currentTime = [NSString nullToString:[YYOUCarUIUtils getCurrentTime]];
    NSDictionary *randDict = [NSDictionary dictionaryWithObjectsAndKeys:randomString,@"nonce",currentTime,@"occurtime", nil];
    //参数后拼接随机数和当前时间  与原来相比无论是参数还是加密，都在原字典中加入了当前时间和随机数
    [parameters addEntriesFromDictionary:randDict];
    WEAK_SELF
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url;
    entity.needCache = NO;
    entity.parameters = parameters;
    
    //设置请求头
    [BANetManager ba_setValue:@"001" forHTTPHeaderKey:@"x-client-id"];
    [BANetManager ba_setValue:[NSString nullToString:[YYOUCarUIUtils sortDictionary:parameters]] forHTTPHeaderKey:@"sign"];
        [BANetManager ba_setValue:[YYOUCarUIUtils getUserDefaultForKey:@"token"] forHTTPHeaderKey:@"token"];
    [BANetManager ba_request_GETWithEntity:entity successBlock:^(id response) {
        NSDictionary *dict = nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict = [NSDictionary dictionaryWithDictionary:response];
        }else{
            NSError *error = nil;
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        }
        NSInteger resultCode = [[NSString nullToString:[dict objectForKey:@"resultCode"]] integerValue];
        if (resultCode == 900) {
            //后台不能捕获的错误
            [weakSelf.view makeToast:@"系统错误" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40104){
            //用户未登录
            [weakSelf.view makeToast:@"您目前还未登录,请先去登录" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40105){
            //登录信息已过期
            [weakSelf.view makeToast:@"登录信息已过期,请重新登录" duration:0.2 position:CSToastPositionCenter];
        }else{
            if (weakSelf.requestSuccessBolck) {
                weakSelf.requestSuccessBolck(dict);
            }
        }
        /*NSInteger resultCode = [[dict objectForKey:@"resultCode"] integerValue];
        NSString *errMsg = [NSString nullToString:[dict objectForKey:@"errMsg"]];
        if (resultCode == 200) {
            if (weakSelf.requestSuccessBolck) {
                weakSelf.requestSuccessBolck(dict);
            }
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }*/
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self.view];
        if (weakSelf.requestFailBolck) {
            weakSelf.requestFailBolck(error);
        }
    } progressBlock:nil];
}
-(void)uploadFileWithName:(NSString *)fileName url:(NSString *)url parameters:(NSDictionary *)parameters{
    /*BADataEntity *entity = [BADataEntity new];
    entity.urlString = url;
    entity.needCache = NO;
    entity.parameters = parameters;*/
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = url;
    imageEntity.parameters = parameters;
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        
    } failurBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        
    }];
}
#pragma mark - 下载视频、图片
- (void)downloadDataRequestUrl:(NSString *)url filePath:(NSString *)filePath{
    /*!
     下载前先判断该用户是否已经下载，目前用了两种方式：
     1、第一次下载完用变量保存，
     2、查找路径中是否包含改文件的名字
     如果下载完了，就不要再让用户下载，也可以添加alert的代理方法，增加用户的选择！
        if (isFinishDownload || result2)
        {
            [[[UIAlertView alloc] initWithTitle:@"温馨提示：" message:@"您已经下载该视频！" delegate:nil cancelButtonTitle:@"确 定" otherButtonTitles:nil, nil] show];
            return;
        }*/
    BAFileDataEntity *fileEntity = [BAFileDataEntity new];
    fileEntity.urlString = url;
    fileEntity.filePath = filePath;
    [BANetManager ba_downLoadFileWithEntity:fileEntity successBlock:^(id response) {
        NSLog(@"下载完成");
        
    } failureBlock:^(NSError *error) {
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
    }];
}

#pragma mark - 上传图片
- (void)uploadImageDataWithImageArray:(NSArray *)images url:(NSString *)url{
    WEAK_SELF
    /*!
     1、此上传图片单张、多图上传！
     2、注意：如果使用PHP后台，后台不会对接此接口的话 只需要把文件夹中的 postdynamic.php 文件发送给你们的PHP后台
     */
    [MBProgressHUD showMessage:@"上传图片..." toView:self.view];
    //图片数组一定要传
    BAImageDataEntity *imageEntity = [BAImageDataEntity new];
    imageEntity.urlString = url;
    imageEntity.imageArray = images;
    imageEntity.imageType = @"png";
    imageEntity.imageScale = 0.6f;
    [BANetManager ba_uploadImageWithEntity:imageEntity successBlock:^(id response) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSDictionary *dict = nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict = [NSDictionary dictionaryWithDictionary:response];
        }else{
            NSError *error = nil;
            dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
            
        }
        NSInteger resultCode = [[dict objectForKey:@"resultCode"] integerValue];
        NSString *errMsg = [NSString nullToString:[dict objectForKey:@"errMsg"]];
        if (resultCode == 200) {
            if (weakSelf.requestSuccessBolck) {
                weakSelf.requestSuccessBolck(dict);
            }
        }else{
            [weakSelf.view makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }
 
    } failurBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:weakSelf.view];
        NSLog(@"图片上传失败");
    } progressBlock:nil];

}

-(void)setBottomSheetMessage:(NSString *)message actionArray:(NSArray *)actionArr{
    WEAK_SELF
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:nil message:[NSString nullToString:message]
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    for (int i =0; i<actionArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString nullToString:[actionArr objectAtIndex:i]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [weakSelf bottomSheetClickAction:action];
        }];
        [alert addAction:action];
    }
    [self presentViewController:alert animated:YES completion:nil];
}
-(void)bottomSheetClickAction:(UIAlertAction *)action{
    //子类重写
}
-(void)jumpToLoginViewController{
//    YYOUCarLoginViewController *login = [[YYOUCarLoginViewController alloc] init];
//    [self.navigationController pushViewController:login animated:YES];
}
#pragma mark - 网络类型判断
- (void)ba_netType
{
    //    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0:
            {
                msg = @"未知网络";
            }
                break;
            case 1:
            {
                msg = @"没有网络";
//                在没有网络时做提示
                [self.view makeToast:msg duration:0.2 position:CSToastPositionCenter];
            }
                break;
            case 2:
            {
                msg = @"您的网络类型为：手机 3G/4G 网络";
            }
                break;
            case 3:
            {
                msg = @"您的网络类型为：wifi 网络";
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
