//
//  WMZRouteBase.m
//  WMZRouter
//
//  Created by wmz on 2018/11/16.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZRouteBase.h"
@implementation WMZRouteBase
static WMZRouteBase *_instance;
/*
 * 单例
 */
+(instancetype)shareInstance{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[super allocWithZone:NULL] init];
    }) ;
    return _instance;
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    return [WMZRouteBase shareInstance] ;
}

-(id) copyWithZone:(struct _NSZone *)zone
{
    return [WMZRouteBase shareInstance] ;
}



/*
 * 处理路由对象 (不做外部调用/添加拦截器时使用)
 * @param  myURL   路由对象
 */
- (void)dealTarget:(WMZRequest*)myURL{}

/*
 * 处理获取到的类 (不做外部调用/添加拦截器时使用)
 * @param  className   类名
 * @param  myURL       路由对象
 */
- (void)analyze:(Class)className withURL:(WMZRequest*)myURL{}

/*
 * 判断多方法还是单一方法,实例方法或者类方法调用(不做外部调用/添加拦截器时使用)
 * @param  className   类名
 * @param  myURL       路由对象
 */
- (void)performSeleectWithClass:(Class)className withURL:(WMZRequest*)myUR{}


/*
 * 执行方法(不做外部调用/添加拦截器时使用)
 * @param  className   类名
 * @param  actionName  方法名
 * @param  myURL       路由对象
 */
- (void)actionStart:(Class)className actionName:(NSString*)actionName withURL:(WMZRequest*)myURL{}


/*
 * 调用方法修改返回值
 * @param  action   方法名
 * @param  URL      路由对象
 * @param  target   target
 * @param  dic      所带参数
 * returm  id       返回值
 */
+ (id)performIDSelector:(SEL)action withObjects:(WMZRequest*)URL Tagert:(id)target withParm:(id)dic{
    id params = dic;
    NSMethodSignature *methodSig = [target methodSignatureForSelector:action];
    if(methodSig == nil)
    {
        URL.errorType = RouterErrorFailAction;
        return nil;
    }
    else
    {
        URL.errorType = RouterSuccess;
        const char* retType = [methodSig methodReturnType];
        
        if (strcmp(retType, @encode(void)) == 0) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            if (params) {
                if ([params isKindOfClass:[NSDictionary class]]) {
                    if ([[params allKeys] count]>0) {
                        [invocation setArgument:&params atIndex:2];
                    }
                }else{
                    [invocation setArgument:&params atIndex:2];
                }
            }
            [invocation setSelector:action];
            [invocation setTarget:target];
            [invocation invoke];
            return nil;
        }
        
        if (strcmp(retType, @encode(NSInteger)) == 0) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            if (params) {
                if ([params isKindOfClass:[NSDictionary class]]) {
                    if ([[params allKeys] count]>0) {
                        [invocation setArgument:&params atIndex:2];
                    }
                }else{
                     [invocation setArgument:&params atIndex:2];
                }
            }
            [invocation setSelector:action];
            [invocation setTarget:target];
            [invocation invoke];
            NSInteger result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
        
        if (strcmp(retType, @encode(BOOL)) == 0) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            if (params) {
                if ([params isKindOfClass:[NSDictionary class]]) {
                    if ([[params allKeys] count]>0) {
                        [invocation setArgument:&params atIndex:2];
                    }
                }else{
                    [invocation setArgument:&params atIndex:2];
                }
            }
            [invocation setSelector:action];
            [invocation setTarget:target];
            [invocation invoke];
            BOOL result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
        
        if (strcmp(retType, @encode(CGFloat)) == 0) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            if (params) {
                if ([params isKindOfClass:[NSDictionary class]]) {
                    if ([[params allKeys] count]>0) {
                        [invocation setArgument:&params atIndex:2];
                    }
                }else{
                    [invocation setArgument:&params atIndex:2];
                }
            }
            [invocation setSelector:action];
            [invocation setTarget:target];
            [invocation invoke];
            CGFloat result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
        
        if (strcmp(retType, @encode(double)) == 0) {
            NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSig];
            if (params) {
                if ([params isKindOfClass:[NSDictionary class]]) {
                    if ([[params allKeys] count]>0) {
                        [invocation setArgument:&params atIndex:2];
                    }
                }else{
                    [invocation setArgument:&params atIndex:2];
                }
            }
            [invocation setSelector:action];
            [invocation setTarget:target];
            [invocation invoke];
            NSUInteger result = 0;
            [invocation getReturnValue:&result];
            return @(result);
        }
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    return [target performSelector:action withObject:params];
#pragma clang diagnostic pop
}

/*
 * 获取当前VC
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        currentVC = rootVC;
    }
    return currentVC;
}


@end
