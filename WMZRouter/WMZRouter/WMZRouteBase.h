//
//  WMZRouteBase.h
//  WMZRouter
//
//  Created by wmz on 2018/11/16.
//  Copyright © 2018年 wmz. All rights reserved.
//
#import <objc/runtime.h>
#import <objc/message.h>
#import <UIKit/UIKit.h>
#import "WMZRequest.h"
#import "WMZRouterParam.h"
#import "WMZRouterProtocol.h"
#import "Aspects.h"
#import "WMZBaseAop.h"


@interface WMZRouteBase : NSObject

/*
 * 初始化
 */
+ (instancetype)shareInstance;



/*
 * 调用方法修改返回值
 * @param  action   方法名
 * @param  URL      路由对象
 * @param  target   target
 * @param  dic      所带参数
 * returm  id       返回值
 */
+ (id)performIDSelector:(SEL)action withObjects:(WMZRequest*)URL Tagert:(id)target withParm:(id)dic;

/*
 * 获取当前VC
 */
+ (UIViewController *)getCurrentVC;


/*
 * 处理路由对象 (不做外部调用/添加拦截器时使用)
 * @param  myURL   路由对象
 */
- (void)dealTarget:(WMZRequest*)myURL;


/*
 * 处理获取到的类 (不做外部调用/添加拦截器时使用)
 * @param  className   类
 * @param  myURL       路由对象
 */
- (void)analyze:(Class)className withURL:(WMZRequest*)myURL;


/*
 * 判断多方法还是单一方法,实例方法或者类方法调用(不做外部调用/添加拦截器时使用)
 * @param  className   类
 * @param  myURL       路由对象
 */
- (void)performSeleectWithClass:(Class)className withURL:(WMZRequest*)myURL;


/*
 * 执行方法(不做外部调用/添加拦截器时使用)
 * @param  className   类名
 * @param  actionName  方法名
 * @param  myURL       路由对象
 */
- (void)actionStart:(Class)className actionName:(NSString*)actionName withURL:(WMZRequest*)myURL;



@end


