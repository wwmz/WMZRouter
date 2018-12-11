//
//  WMZBaseAop.m
//  WMZRouter
//
//  Created by wmz on 2018/11/26.
//  Copyright © 2018年 wmz. All rights reserved.
//
#import "WMZBaseAop.h"

@implementation WMZBaseAop


+(instancetype)shareInstance{
    return [[self alloc]init];
}


/*
 * 添加拦截器
 */
- (void)addAopWithType:(AopActionType)type{
    switch (type) {
        case AopTypePermissions:{
            [WMZRouter aspect_hookSelector:@selector(dealTarget:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 NSLog(@"权限设置开始");
             } error:NULL];
        }
            break;
        case AopTypeCache:{
            [WMZRouter aspect_hookSelector:@selector(dealTarget:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 NSLog(@"数据缓存开始");
             } error:NULL];
            break;
        }
        case AopTypeLog:{
            [WMZRouter aspect_hookSelector:@selector(dealTarget:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                  NSLog(@"日志缓存开始");
             } error:NULL];
            break;
        }
        case AopTypeOpenURL:{
            [WMZRouter aspect_hookSelector:@selector(dealTarget:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 NSLog(@"拦截非本app的方法作相应处理开始");
                 WMZRouter *route = aspectInfo.instance;
                 [WMZRouter expandHandleOpenWithRequest:route.returnURL];
             } error:NULL];
            break;
        }
        case AopTypeCell:{
            [WMZRouter aspect_hookSelector:@selector(analyze:withURL:) withOptions:AspectPositionBefore|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                NSLog(@"处理cell开始");
                 WMZRouter *route = aspectInfo.instance;
                 [WMZRouter expandHandleTableViewCell:NSClassFromString(route.returnURL.target) WithRequest:route.returnURL];
             } error:NULL];
            break;
        }
        case AopTypespecialParameters:{
            [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 WMZRouter *route = aspectInfo.instance;
                 NSLog(@"跳转开始");
                  [WMZRouter expandHandleActionWithID:route.returnURL.returnValue WithRequest:route.returnURL];
             } error:NULL];
            break;
        }
        case AopTypeClean:{
            [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 NSLog(@"定时清理 5分钟清理一次 开始");
                 [WMZRouter deleteLongUnUseHandleWithTarget:aspectInfo.instance];
             } error:NULL];
            break;
        }
        case AopTypeError:{
            [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter|AspectOptionAutomaticRemoval usingBlock:^(id<AspectInfo> aspectInfo)
             {
                 NSLog(@"错误处理 开始");
                 WMZRouter *route = aspectInfo.instance;
                 [WMZRouter expandHandleErrorWithRequest:route.returnURL];
             } error:NULL];
            break;
        }
        default:
            break;
    }
}

- (BOOL)remove{
    return YES;
}

@end
