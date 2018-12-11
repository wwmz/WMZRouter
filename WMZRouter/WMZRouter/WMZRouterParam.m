//
//  WMZRouterParam.m
//  WMZRouter
//
//  Created by wmz on 2018/11/27.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZRouterParam.h"

@interface WMZRouterParam ()
@property(nonatomic,strong)WMZBaseAop *aop;
@end
@implementation WMZRouterParam

+ (instancetype)Instance{
    return [[self alloc]init];
}

/*
 * 初始化
 */
WMZRouterParam *RouterParam(void){
    return [WMZRouterParam Instance];
}

/*
 * 传递的参数
 */
- (WMZRouterParam *(^)(NSDictionary *))selfParam{
    return ^WMZRouterParam*(NSDictionary* selfParam){
        [selfParam enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (obj) {
                [self.routerDic setObject:obj forKey:key];
            }
        }];
        return self;
    };
}


/*
 * 权限设置
 */
- (WMZRouterParam *(^)(PermissionType, WMZRouterCallBlock))permissions{
    return ^WMZRouterParam*(PermissionType type,WMZRouterCallBlock block){
        [self.aop addAopWithType:AopTypePermissions];
        return self;
    };
}

/*
 * 数据缓存
 */
- (WMZRouterParam *(^)(WMZRouterCallBlock))cache{
    return ^WMZRouterParam*(WMZRouterCallBlock cacheBlock){
     [self.aop addAopWithType:AopTypeCache];
     if (cacheBlock) {
        cacheBlock(@"缓存数据",YES);
     }
      return self;
    };
}

/*
 * 数据缓存时间
 */
- (WMZRouterParam *(^)(NSInteger))cacheTime{
    return ^WMZRouterParam*(NSInteger cacheTime){
        //
        return self;
    };
}


/*
 * 日志记录
 */
- (WMZRouterParam *(^)(id))log{
    return ^WMZRouterParam*(id log){
        [self.aop addAopWithType:AopTypeLog];
        return self;
    };
}



/*
 * 跳转方式
 */
- (WMZRouterParam *(^)(RouterVCPush))enterVCStyle{
    return ^WMZRouterParam*(RouterVCPush type){
        [self.aop addAopWithType:AopTypespecialParameters];
        [self.routerDic setObject:@(type) forKey:@"enterVCStyle"];
        return self;
    };
}

/*
 * 打开URL
 */
- (WMZRouterParam *(^)(void))openURL{
    return ^WMZRouterParam*(){
        [self.aop addAopWithType:AopTypeOpenURL];
        return self;
    };
}

/*
 * 错误系统处理
 */
- (WMZRouterParam *(^)(RouterErrorAction))error{
    return ^WMZRouterParam*(RouterErrorAction type){
        [self.aop addAopWithType:AopTypeError];
        [self.routerDic setObject:@(type) forKey:@"error"];
        return self;
    };
}


/*
 * 错误自己处理
 */
- (WMZRouterParam *(^)(WMZDealCallBlock))dealSelfError{
    return ^WMZRouterParam*(WMZDealCallBlock block){
        [self.aop addAopWithType:AopTypeError];
        [self.routerDic setObject:@(RouterBack) forKey:@"error"];
        if (block) {
             [self.routerDic setObject:block forKey:@"errorBlock"];
        }
        return self;
    };
}

/*
 * tableViewCell
 */
- (WMZRouterParam *(^)(UITableView *))CellTable{
    return ^WMZRouterParam*(UITableView* CellTable){
        [self.aop addAopWithType:AopTypeCell];
        [self.routerDic setObject:CellTable forKey:@"CellTable"];
        return self;
    };
}

/*
 * 网络请求
 */
- (WMZRouterParam *(^)(id))netWork{
    return ^WMZRouterParam*(id netWork){
        [self.routerDic setObject:netWork forKey:@"netWork"];
        return self;
    };
}

- (NSMutableDictionary *)routerDic{
    if (!_routerDic) {
        _routerDic = [NSMutableDictionary new];
    }
    return _routerDic;
}

- (WMZBaseAop *)aop{
    if (!_aop) {
        _aop = [WMZBaseAop shareInstance];
    }
    return _aop;
}

@end
