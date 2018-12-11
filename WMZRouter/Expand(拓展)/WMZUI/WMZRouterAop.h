//
//  WMZRouterAop.h
//  WMZRouter
//
//  Created by wmz on 2018/11/21.
//  Copyright © 2018年 wmz. All rights reserved.
//
#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN


@interface WMZRouterAopModel:NSObject

//  拦截器类型 前还是后
@property(nonatomic,assign) NSInteger options;

//  顺序（同个方法的优先级）  前拦截 数字小的优先级大   后拦截 数字大的优先级大 
@property(nonatomic,assign) NSInteger sort;

//  方法名编码  相同方法名对应的要相同
@property(nonatomic,assign) NSInteger actionNameType;

//  拦截器方法名
@property(nonatomic,copy) NSString* selectorName;

- (instancetype)initWithOptions:(NSInteger)options Sort:(NSInteger)sort ActionNameType:(NSInteger)actionNameType;

@end


@interface WMZRouterAop : NSObject

/*
 * 初始化
 */
+ (instancetype)shareInstance;




/*
 * 添加本类的所有拦截操作
 */
- (void)addAllAop;

/*
 * 拦截非调用本app的操作
 */
+ (WMZRouterAopModel*)dealWithOpenURL:(NSNumber*)shouldReturn;

/*
 * 权限设置
 */
+ (WMZRouterAopModel*)setPermissions:(NSNumber*)shouldReturn;

/*
 * 数据缓存
 */
+ (WMZRouterAopModel*)dataCache:(NSNumber*)shouldReturn;

/*
 * 处理特殊参数
 */
+ (WMZRouterAopModel*)dealWithspecialParameters:(NSNumber*)shouldReturn;

/*
 * 清理handle缓存
 */
+ (WMZRouterAopModel*)clean:(NSNumber*)shouldReturn;

/*
 * 错误处理
 */
+ (WMZRouterAopModel*)dealWitherror:(NSNumber*)shouldReturn;


//实现方法名字需与协议定制的方法一样

/*
 * 拦截非调用本app的操作
 */
+ (BOOL)candealWithOpenURL:(NSNumber*)can;

/*
 * 权限设置
 */
+ (BOOL)canPermissions:(NSNumber*)can;
/*
 * 数据缓存
 */
+ (BOOL)candataCache:(NSNumber*)can;

/*
 * 处理特殊参数
 */
+ (BOOL)candealWithspecialParameters:(NSNumber*)can;
/*
 * 清理handle缓存
 */
+ (BOOL)canclean:(NSNumber*)can;
/*
 * 错误处理
 */
+ (BOOL)candealWitherror:(NSNumber*)can;

@end

NS_ASSUME_NONNULL_END
