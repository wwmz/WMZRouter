//
//  WMZRouter.h
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZRouteBase.h"
@interface WMZRouter : WMZRouteBase

/*
 *路由存放handle字典
 */
@property(nonatomic,strong) NSMutableDictionary *handleDic;

/*
 *返回对象
 */
@property(nonatomic,strong) WMZRequest *returnURL;

/*
 *路由其他拓展操作字典
 */
@property(nonatomic,strong) NSMutableDictionary *expandDic;

/*
 * 路由调用方法带block
 * @param  URLString URL  URL格式为 (scheme/)target/expressin(/other)
 * @param  param 参数  特殊参数见说明文档
 * @param  dataBlock block (处理网络请求 弹窗等需要操作或者延时的操作使用)
 * returm  任意类型
 */
- (id)handleWithURL:(id)URLString WithParam:(id)param WithHandBlock:(WMZRouterCallBlock)dataBlock;

/*
 * 路由调用方法不带block
 * @param  URLString URL  URL格式为 (scheme/)target/expressin(/other)
 * @param  param 参数  特殊参数见说明文档
 * returm  任意类型
 */
- (id)handleWithURL:(id)URLString WithParam:(id)param;

@end


