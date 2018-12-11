//
//  WMZRouter+Expand.h
//  WMZRouter
//
//  Created by wmz on 2018/11/26.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZRouter.h"

NS_ASSUME_NONNULL_BEGIN
/*
 *路由的拓展工具类
 */
@interface WMZRouter (Expand)
/*
 * 处理路由的错误
 * @param  request  路由对象
 * returm  Bool     有无block返回
 */
+ (BOOL)expandHandleErrorWithRequest:(WMZRequest*)request;

/*
 * 路由扩展VC跳转
 * @param  instance  组件
 * @param  request   路由对象
 */
+ (void)expandHandleActionWithID:(id)instance WithRequest:(WMZRequest*)request;


/*
 * 路由扩展打开其他URL
 * @param  request   路由对象
 */
+ (void)expandHandleOpenWithRequest:(WMZRequest*)request;


/*
 * 获取tableviewCell
 * @param  instance  class
 * @param  request   路由对象
 * returm  id        任意类型
 */
+ (id)expandHandleTableViewCell:(Class)instance WithRequest:(WMZRequest*)request;

/*
 * 调用方法
 * @param  action   方法名
 * @param  params   所带参数
 * returm  target   target
 */
+ (void)deleteLongUnUseHandleWithTarget:(id)instance;


/*
 * 判断两个时间间隔
 * @param  startDate  厨师时间
 * @param  toDate     比较的时间
 * @param  deleteTime 间隔的时间
 * returm  BOOL       结果
 */
+ (BOOL)compareDate:(NSDate*)startDate WithToDate:(NSDate*)toDate withSecond:(NSInteger)deleteTime;


@end

NS_ASSUME_NONNULL_END
