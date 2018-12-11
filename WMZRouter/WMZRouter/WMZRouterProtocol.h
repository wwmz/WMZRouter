//
//  WMZRouterProtocol.h
//  WMZRouter
//
//  Created by wmz on 2018/11/20.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 * 协议  （要成为handle必须实现该协议和协议的方法）
 */
@protocol WMZRouterProtocol <NSObject>

@required
/*
 * 协议  （调用时的target要与此实现方法的返回值相同）
 */
+ (NSString*)routerPath;

@end


///*
// * 协议  （拦截器协议）
// */
//@protocol WMZRouterAopProtocol <NSObject>
//
//@optional
//
///*
// * 是否开启系统拦截方法（实例类调用无效 路由的扩展框架调用）
// */
//+ (BOOL)openSystemAop;
//
///*
// * 系统拦截器数组 （实例类调用无效 路由的扩展框架调用）
// */
//+ (NSArray<NSNumber*>*)systemAopArr;
//
//
///*
// * 前拦截器数组 （实例类调用）
// */
//+ (NSArray<NSNumber*>*)beforeAopArr;
//
//
///*
// * 后拦截器数组  （实例类调用）
// */
//+ (NSArray<NSNumber*>*)afterAopArr;
//
//@end
