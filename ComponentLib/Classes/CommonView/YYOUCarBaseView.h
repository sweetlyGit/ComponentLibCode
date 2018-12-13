//
//  YYOUCarBaseView.h
//  YYOUCarOwnerAPP
//
//  Created by yonyou on 2018/9/4.
//  Copyright © 2018年 YonYou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD+YYOUCarMBProgress.h"
#import "YYOUCommonHeader.h"
#import "UIView+Toast.h"

@protocol JumpToLoginViewDelegate <NSObject>

@optional
//跳转到登录页面
-(void)jumpToLoginView;
@end

@interface YYOUCarBaseView : UIView
//跳转到登录页面代理
@property(nonatomic,weak) id<JumpToLoginViewDelegate>loginDelegate;

@property(nonatomic,strong)UITableView *listTable;
@property(nonatomic,assign)int listPage;
@property(nonatomic,copy)NSMutableArray *dataArray;
@property(nonatomic,copy) void(^requestSuccessBolck)(NSDictionary *result);
@property(nonatomic,copy) void(^requestFailBolck)(NSError *resultError);

/**
 *  集成上拉刷新控件
 */
- (void)setupLoadMoreDataRefresh;

/**
 *  集成下拉刷新控件
 */
- (void)setupNewDataRefresh;

/**
 *  加载下拉刷新数据
 */
- (void)loadNewRequestData;

/**
 *  加载上拉加载更多数据
 */
-(void)loadMoreRequestData;

/*
 tableView代理方法;
 */
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section;

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section;

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section;

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button;
/**
 背景图片设置
 */
- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView;

/**
 背景文字描述
 */
- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView;

/**
 背景按钮文字
 */
- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;

/**
 设置按钮背景图片
 */
- (UIImage *)buttonImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state;
/**
 get请求
 @param url 请求地址
 @param parameters 请求参数
 */
- (void)getDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters;

/**
 post请求
 @param url 请求地址
 @param parameters 请求参数
 */
- (void)postDataRequestUrl:(NSString *)url parameters:(NSMutableDictionary *)parameters requestType:(NSString *)requestType;

/**
 返回错误码时设置请求页码

 @param errMsg 错误信息
 */
-(void)setUPListPageWhenErrMsg:(NSString *)errMsg;

/**
 设置请求时的页码

 @param page 请求时的页码
 @param data 请求获得的数据源
 */
-(void)setRequestPage:(int)page resultArray:(NSArray *)data;
@end
