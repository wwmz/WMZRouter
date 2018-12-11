//
//  WMZBaseAop.h
//  WMZRouter
//
//  Created by wmz on 2018/11/26.
//  Copyright © 2018年 wmz. All rights reserved.
//

//拦截器方法
typedef enum : NSUInteger{
    AopTypePermissions,                //权限设置
    AopTypeCache,                      //数据缓存
    AopTypeLog,                        //日志打印
    AopTypeOpenURL,                    //打开URL
    AopTypespecialParameters,          //VC跳转
    AopTypeClean,                      //清理handle
    AopTypeError,                      //错误处理
    AopTypeCell                        //错tableviewCell
}AopActionType;


#import <Foundation/Foundation.h>

@interface WMZBaseAop : NSObject<AspectToken>

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 添加拦截器
 */
- (void)addAopWithType:(AopActionType)type;


@end
