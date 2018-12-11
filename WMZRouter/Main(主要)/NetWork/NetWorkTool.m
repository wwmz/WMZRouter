//
//  NetWorkTool.m
//  WMZRouter
//
//  Created by wmz on 2018/11/16.




//  Copyright © 2018年 wmz. All rights reserved.
//

#import "NetWorkTool.h"

@implementation NetWorkTool

+ (void)netWorkSuccessTestWithSuccessWithParm:(NSDictionary*)dic{
    __block WMZRouterCallBlock block = dic[@"block"];
        [self netWorkTestWithSuccessCallBack:^(NSString * _Nonnull resultCode, NSDictionary * _Nonnull post_dic) {
            if (block) {
                block(@"网路请求成功",YES);
            }
        } failCallBack:^(NSString * _Nonnull resultCode, NSString * _Nonnull reslut_describe) {
            if (block) {
                block(@"网路请求失败",NO);
            }
        }];

}

+ (void)netWorkFailTestWithSuccessWithParm:(NSDictionary*)dic{
        WMZRouterCallBlock block = dic[@"block"];
   
        [self netWorkTestFailWithSuccessCallBack:^(NSString * _Nonnull resultCode, NSDictionary * _Nonnull post_dic) {
            if (block) {
                block(@"网路请求成功",YES);
            }
        } failCallBack:^(NSString * _Nonnull resultCode, NSString * _Nonnull reslut_describe) {
            if (block) {
                block(@"网路请求失败",NO);
            }
        }];
}


+ (void)netWorkTestWithSuccessCallBack:(NetWorkResponseBlock)successCallBack
                          failCallBack:(NetWorkResponseErrorBlock)failCallBack{
    //模拟网路条件2秒后再返回
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        successCallBack(@"成功",@{});
    });
}

+ (void)netWorkTestFailWithSuccessCallBack:(NetWorkResponseBlock)successCallBack
                          failCallBack:(NetWorkResponseErrorBlock)failCallBack{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        failCallBack(@"失败",nil);
    });
}


+ (NSString *)routerPath{
    return @"netWorkTest";
}

@end
