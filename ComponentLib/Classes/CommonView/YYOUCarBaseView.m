//
//  YYOUCarBaseView.m
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import "YYOUCarBaseView.h"
#import <BANetManager/BANetManager.h>
#import <BANetManager/BADataEntity.h>
#import <Toast/Toast.h>
#import "MBProgressHUD+YYOUCarMBProgress.h"
//#import <DZNEmptyDataSet/UIScrollView+EmptyDataSet.h>
#import "UIColor+YYOUHexString.h"
#import "NSString+YYOUCarString.h"
#import <Reachability/Reachability.h>
#import "YYOUCarBaseTableViewCell.h"
#import <MJRefresh/MJRefresh.h>
#import "YYOUCarUIUtils.h"
#import "UIImage+YYOUCarImage.h"
//@interface YYOUCarBaseView()<UITableViewDelegate,UITableViewDataSource,DZNEmptyDataSetSource,DZNEmptyDataSetDelegate>
@interface YYOUCarBaseView()<UITableViewDelegate,UITableViewDataSource>
@end
@implementation YYOUCarBaseView
-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self ba_netType];
        self.backgroundColor = GRAYCOLOR;
    }
    return self;
}
-(UITableView *)listTable{
    if (!_listTable) {
        _listTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width,self.frame.size.height) style:UITableViewStylePlain];
        _listTable.dataSource = self;
        _listTable.delegate = self;
//        _listTable.emptyDataSetSource = self;
//        _listTable.emptyDataSetDelegate = self;
        _listTable.separatorStyle = UITableViewCellSelectionStyleNone;
        _listTable.showsVerticalScrollIndicator = NO;
        _listTable.estimatedRowHeight = 100;
        _listTable.estimatedSectionHeaderHeight = 300;//要大于0 ，否则无效
        if (@available(iOS 11.0, *)){
            _listTable.estimatedSectionHeaderHeight = 0.01;//要大于0 ，否则无效
            _listTable.estimatedSectionFooterHeight = 0;
        }
    }
    return _listTable;
}
/**
 *  集成上拉刷新控件
 */
- (void)setupLoadMoreDataRefresh
{
    self.listTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreRequestData)];
}
/**
 *  集成下拉刷新控件
 */
- (void)setupNewDataRefresh
{
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
    self.listTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewRequestData)];
    // 马上进入刷新状态
    [self.listTable.mj_header beginRefreshing];
}
/**
 *  加载下拉刷新数据
 */
- (void)loadNewRequestData
{
    self.listPage = 1;//默认加载第一页
    [self.dataArray removeAllObjects];//移除所有的数据
}

/**
 *  加载上拉刷新数据
 */
-(void)loadMoreRequestData
{
    //1.设置页数
    self.listPage ++;//默认加载第一页
}
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"initCell"];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 20;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,0.01)];
    view.backgroundColor = [UIColor greenColor];
    return view;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,0.01)];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 0.01;
//}
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView{
    Reachability  *ren  = [Reachability reachabilityWithHostName:@"www.baidu.com"];
  
    if (self.dataArray.count<=0 && [ren isReachable]) {
        //有网没有数据
        return [UIImage imgWithName:@"pic_no message" bundleName:@"CZCommonLibBundle"];
//        [UIImage imageNamed:@"pic_no message"];
    }else{
        return [UIImage imgWithName:@"no_network" bundleName:@"CZCommonLibBundle"];
//        [UIImage imageNamed:@"no_network"];
    }
}
- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView{
    
    return [UIColor whiteColor];
}
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
{
    Reachability  *ren  = [Reachability reachabilityWithHostName:@"www.baidu.com"];

    NSString *text;
    if (self.dataArray.count<= 0 && [ren isReachable]) {
        text = @"空空如也";
    }else{
        text = @"网络开小差了";
    }
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont fontWithName:@"PingFangTC-Regular" size:15.0f],
                                 NSForegroundColorAttributeName: [UIColor colorWithHexString:@"#BBBBBB"],
                                 NSParagraphStyleAttributeName: paragraph};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    // 设置按钮标题
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:15.0f],NSForegroundColorAttributeName:RGB(79, 79, 79)};
    Reachability  *ren  = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (self.dataArray.count<= 0 && [ren isReachable]) {
        return nil;
    }else{
        return [[NSAttributedString alloc] initWithString:@"点击重试" attributes:attributes];
    }
    
}
#pragma mark ----DZNEmptyDataSetDelegate

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
{
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
{
    return YES;
}
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state{
    Reachability  *ren  = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    if (self.dataArray.count<= 0 && [ren isReachable]) {
        return nil;
    }else{
        return [UIImage imgWithName:@"network_retrytext" bundleName:@"CZCommonLibBundle"];
//        [UIImage imageNamed:@"network_retrytext"];
    }
}
#pragma mark - 网络类型判断
- (void)ba_netType
{
    
    //    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 1:
            {
                msg = @"没有网络";
                //                在没有网络时做提示 如有需要再检测其他网络
                [self makeToast:msg duration:0.2 position:CSToastPositionCenter];
            }
                break;
                
            default:
                break;
        }
    }];
}

- (void)postDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters requestType:(NSString *)requestType{
    WEAK_SELF;
    // 自定义超时设置
    BANetManagerShare.timeoutInterval = 15;
    
    
    NSString *randomString = [NSString nullToString:[YYOUCarUIUtils getRandomString]];
    NSString *currentTime = [NSString nullToString:[YYOUCarUIUtils getCurrentTime]];
    NSDictionary *randDict = [NSDictionary dictionaryWithObjectsAndKeys:randomString,@"nonce",currentTime,@"occurtime", nil];
    NSDictionary *Finallyparam = nil;
    NSString *postUrlString = nil;
    
    // 自定义添加请求头
    if ([requestType isEqualToString:@"1"]) {
        //        content-type: application/json
        //随机参数拼接排序
        BANetManagerShare.requestSerializer = BAHttpRequestSerializerJSON;
        //json格式默认请求类型为：application-json  http请求类型为：application/x-www-form-urlencoded
        // 自定义更改 responseSerializer
        BANetManagerShare.responseSerializer = BAHttpResponseSerializerJSON;
        NSString *headerSortString = [YYOUCarUIUtils sortHeaderDict:randDict];
        //参数转json
//        NSString *jsonString = [parameters JSONString];
        
    NSError *parseError = nil; NSData *jsonData = [NSJSONSerialization dataWithJSONObject:parameters options:NSJSONWritingPrettyPrinted error:&parseError];
        
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
        //传给body的参数
        Finallyparam = [NSDictionary dictionaryWithDictionary:parameters];
        //原参数拼上随机数 用于sign加密
        [parameters addEntriesFromDictionary:randDict];
        
        [BANetManager ba_setValue:[NSString nullToString:[YYOUCarUIUtils sortDictionary:parameters]] forHTTPHeaderKey:@"sign"];
        
         postUrlString = [NSString stringWithFormat:@"%@?nonce=%@&occurtime=%@",url,randomString,currentTime];
    }
    [BANetManager ba_setValue:@"001" forHTTPHeaderKey:@"x-client-id"];
    [BANetManager ba_setValue:[YYOUCarUIUtils getUserDefaultForKey:@"token"] forHTTPHeaderKey:@"token"];
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = postUrlString;
    entity.parameters = Finallyparam;
    entity.needCache = NO;
    [BANetManager ba_request_POSTWithEntity:entity successBlock:^(id response) {
        NSDictionary *dict =nil;
        if ([response isKindOfClass:[NSDictionary class]]) {
            dict  =[NSDictionary dictionaryWithDictionary:response];
        }else{
            NSError *error = nil;
           dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        }
        
        NSInteger resultCode = [[NSString nullToString:[dict objectForKey:@"resultCode"]] integerValue];
        if (resultCode == 900) {
            //后台不能捕获的错误
            [weakSelf makeToast:@"系统错误" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40104){
            //用户未登录
            [weakSelf makeToast:@"您目前还未登录,请先去登录" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40105){
            //登录信息已过期
            [weakSelf makeToast:@"登录信息已过期,请重新登录" duration:0.2 position:CSToastPositionCenter];
        }else{
            if (weakSelf.requestSuccessBolck) {
                weakSelf.requestSuccessBolck(dict);
            }
        }
        
       /* NSInteger resultCode = [[dict objectForKey:@"resultCode"] integerValue];
        NSString *errMsg = [NSString nullToString:[dict objectForKey:@"errMsg"]];
        if (resultCode == 200) {*/
       /* }else{
            if (weakSelf.listPage == 1) {
                [weakSelf.listTable.mj_header endRefreshing];
            }else{
                weakSelf.listPage--;
                [weakSelf.listTable.mj_footer endRefreshing];
            }
            [weakSelf makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }*/

    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self];
        [weakSelf makeToast:@"数据错误，请稍后重试" duration:0.3 position:CSToastPositionCenter];
        if (weakSelf.listPage == 1) {
            [weakSelf.listTable.mj_header endRefreshing];
        }else{
            weakSelf.listPage--;
            [weakSelf.listTable.mj_footer endRefreshing];
        }
        if (weakSelf.requestFailBolck) {
            weakSelf.requestFailBolck(error);
        }
        if (weakSelf.requestFailBolck) {
            weakSelf.requestFailBolck(error);
        }
        
    } progressBlock:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        NSLog(@"蜗牛似的");
    }];
}
-(void)setUPListPageWhenerrMsg:(NSString *)errMsg{
    WEAK_SELF;
    if (weakSelf.listPage == 1) {
        [weakSelf.listTable.mj_header endRefreshing];
    }else{
        weakSelf.listPage--;
        [weakSelf.listTable.mj_footer endRefreshing];
    }
    [weakSelf makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
}
#pragma mark***get请求
- (void)getDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters{
    WEAK_SELF
    NSString *randomString = [NSString nullToString:[YYOUCarUIUtils getRandomString]];
    NSString *currentTime = [NSString nullToString:[YYOUCarUIUtils getCurrentTime]];
    NSDictionary *randDict = [NSDictionary dictionaryWithObjectsAndKeys:randomString,@"nonce",currentTime,@"occurtime", nil];
    //参数后拼接随机数和当前时间  与原来相比无论是参数还是加密，都在原字典中加入了当前时间和随机数
    [parameters addEntriesFromDictionary:randDict];
    
    
    BADataEntity *entity = [BADataEntity new];
    entity.urlString = url;
    entity.needCache = NO;
    entity.parameters = parameters;
    
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
            [MBProgressHUD hideHUDForView:self];
            [weakSelf makeToast:@"系统错误" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40104){
            //用户未登录
            [MBProgressHUD hideHUDForView:self];
            [weakSelf makeToast:@"您目前还未登录,请先去登录" duration:0.2 position:CSToastPositionCenter];
        }else if (resultCode == 40105){
            //登录信息已过期
            [MBProgressHUD hideHUDForView:self];
            [weakSelf makeToast:@"登录信息已过期,请重新登录" duration:0.2 position:CSToastPositionCenter];
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
            if (weakSelf.listPage == 1) {
                [weakSelf.listTable.mj_header endRefreshing];
            }else{
                weakSelf.listPage--;
                [weakSelf.listTable.mj_footer endRefreshing];
            }
            [weakSelf makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
        }*/
    } failureBlock:^(NSError *error) {
        [MBProgressHUD hideHUDForView:self];
        [weakSelf makeToast:@"数据错误，请稍后重试" duration:0.3 position:CSToastPositionCenter];
        if (weakSelf.listPage == 1) {
            [weakSelf.listTable.mj_header endRefreshing];
        }else{
            weakSelf.listPage--;
            [weakSelf.listTable.mj_footer endRefreshing];
        }
        if (weakSelf.requestFailBolck) {
            weakSelf.requestFailBolck(error);
        }
    } progressBlock:nil];
}
-(void)setUPListPageWhenErrMsg:(NSString *)errMsg{
    if (self.listPage == 1) {
        [self.listTable.mj_header endRefreshing];
    }else{
        self.listPage--;
        [self.listTable.mj_footer endRefreshing];
    }
    [self makeToast:errMsg duration:0.2 position:CSToastPositionCenter];
}
-(void)setRequestPage:(int)page resultArray:(NSArray *)data{
    if (page != 1) {
        if (data.count == 0) {
            self.listPage--;
        }
        [self.listTable.mj_footer endRefreshing];
    }else{
        self.listPage =1;
        [self.listTable.mj_header endRefreshing];
    }
}
@end
