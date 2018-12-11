//
//  WMZRouterParam.h
//  WMZRouter
//
//  Created by wmz on 2018/11/27.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 处理
 */
typedef void (^WMZDealCallBlock)(id anyID);


@interface WMZRouterParam : NSObject

/*
 * 初始化
 */
+ (instancetype)Instance;

/*
 * 初始化
 */
WMZRouterParam * RouterParam(void);

/*
 * 拼接起来的字典（外部无需调用）
 */
@property(nonatomic,strong)NSMutableDictionary *routerDic;

// =========================================要传递过去的参数==============================================

/*
 * 传递的参数
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^selfParam)(NSDictionary *selfParam);


// =========================================系统参数=====================================================

/*
 * 权限设置
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^permissions)(PermissionType type,WMZRouterCallBlock callBack);

/*
 * 数据缓存
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^cache)(WMZRouterCallBlock callBack);

/*
 * 数据缓存时间
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^cacheTime)(NSInteger time);

/*
 * 日志记录
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^log)(id log);


// =========================================特殊参数参数=====================================================

/*
 * 跳转方式
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^enterVCStyle)(RouterVCPush type);


/*
 * 打开URL
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^openURL)(void);


/*
 * 错误系统处理
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^error)(RouterErrorAction type);

/*
 * 错误自己处理
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^dealSelfError)(WMZDealCallBlock block);


/*
 * tableViewCell
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^CellTable)(UITableView *CellTable);

/*
 * 网络请求
 */
@property(nonatomic,copy,readonly) WMZRouterParam *(^netWork)(id netWork);


@end


