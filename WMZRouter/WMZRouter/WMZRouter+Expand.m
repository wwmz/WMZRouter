//
//  WMZRouter+Expand.m
//  WMZRouter
//
//  Created by wmz on 2018/11/26.
//  Copyright © 2018年 wmz. All rights reserved.
//

//定时清理路由中的实例
static NSString *const time_router_delete = @"time_router_delete";

#import "WMZRouter+Expand.h"

@implementation WMZRouter (Expand)
/*
 * 处理路由的错误
 * @param  request  路由对象
 */
+ (BOOL)expandHandleErrorWithRequest:(WMZRequest*)request{
    __block BOOL block = NO;
    switch (request.errorType) {
        case RouterSuccess:
            return block;
            break;
        case RouterErrorFailURLError:
            NSLog(@"传入URL格式错误");
            break;
        case RouterErrorFailHandle:
            NSLog(@"注册handle失败");
            break;
        case RouterErrorFailAction:
            NSLog(@"找不到调用的方法");
            break;
        case RouterErrorFailInstance:
            NSLog(@"找不到调用的对象或者对象类型不符合要求");
            break;
        case RouterErrorFailPrama:
            NSLog(@"携带参数错误");
            break;
        case RouterErrorFailReturn:
            NSLog(@"调用方法返回值错误");
            break;
        default:
            NSLog(@"未定义错误");
            break;
    }
    
    //有携带错误参数进行相应处理
    NSNumber *errorAction = request.param[@"error"];
    if (errorAction) {
        NSLog(@"错误处理");
        switch (errorAction.integerValue) {
            case RouterPushH5:
            {
                UIViewController *vc = [WMZRouteBase getCurrentVC];
                UINavigationController *na = vc.navigationController;
                
                
                WMZRouterURL *URL = RouterURL().target(@"getH5");
                WMZRouterParam *param = RouterParam().enterVCStyle(na?RouterPushHideTabBackShow:RouterPresent);
                [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
                if (request.block) {
                    block = YES;
                    request.block(request.returnValue, NO);
                }
            }
                
                break;
            case RouterPushFail:
            {
                UINavigationController *na = [WMZRouteBase getCurrentVC].navigationController;
                WMZRouterURL *URL = RouterURL().target(@"getFailVC");
                WMZRouterParam *param = RouterParam().enterVCStyle(na?RouterPushHideTabBackShow:RouterPresent);
                [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
                if (request.block) {
                    block = YES;
                    request.block(request.returnValue, NO);
                }
            }
                break;
            case RouterUpdate:
            {
                __weak WMZRequest *URL = request;
                [[WMZAlert shareInstance] showAlertWithType:AlertTypeNornal headTitle:@"非强制升级提示" textTitle:@"非强制升级内容\n升级内容\n升级内容\n升级内容\n" leftHandle:^(id anyID) {
                    if (URL.block) {
                        URL.block(@"left", NO);
                        block = YES;
                    }
                } rightHandle:^(id anyID) {
                    if (URL.block) {
                        block = YES;
                        URL.block(@"right", YES);
                    }
                }];
            }
                break;
            case RouterUpdateRequire:
            {
                __weak WMZRequest *URL = request;
                [[WMZAlert shareInstance] showAlertWithType:AlertTypeNornal headTitle:@"强制升级提示" textTitle:@"升级内容\n升级内容\n升级内容\n升级内容\n" leftHandle:nil rightHandle:^(id anyID) {
                    if (URL.block) {
                        block = YES;
                        URL.block(@"right", YES);
                    }
                }];
            }
                break;
            case RouterBack:
            {
                
                WMZDealCallBlock errorBlock = request.param[@"errorBlock"];
                if (errorBlock) {
                    errorBlock(@"自己做处理");
                }
                if (request.block) {
                    block = YES;
                    request.block(request.returnValue, NO);
                }
            }
                break;
                
            default:
                if (request.block) {
                    block = YES;
                    request.block(request.returnValue, NO);
                }
                NSLog(@"未识别错误处理");
                break;
        }
    }
    return block;
}

/*
 * 路由扩展VC跳转
 * @param  instance  组件
 * @param  request   路由对象
 */
+ (void)expandHandleActionWithID:(id)instance WithRequest:(WMZRequest*)request{
    id param = request.param;
    if (request.type!=TypeSelfAppAction) {
        return;
    }

    //拓展
    //VC跳转
    if (param[@"enterVCStyle"]) {
        UIViewController *returnVC = instance;
                
        if (!returnVC||![returnVC isKindOfClass:[UIViewController class]]) {
            request.errorType = RouterErrorFailInstance;
            return;
        }
                

        switch ([param[@"enterVCStyle"]intValue]) {
            case RouterPush:
            {
                [[WMZRouteBase getCurrentVC].navigationController pushViewController:returnVC animated:YES];
            }
                break;
            case RouterPushHideTabBackShow:
            {
                UIViewController *nowVC = [WMZRouteBase getCurrentVC];
                nowVC.hidesBottomBarWhenPushed = YES;
                [nowVC.navigationController pushViewController:returnVC animated:YES];
                nowVC.hidesBottomBarWhenPushed=NO;
            }
                break;
            case RouterPushHideTab:
            {
                UIViewController *nowVC = [WMZRouteBase getCurrentVC];
                nowVC.hidesBottomBarWhenPushed = YES;
                [nowVC.navigationController pushViewController:returnVC animated:YES];
            }
                break;
            case RouterPresent:
            {
                [[WMZRouteBase getCurrentVC] presentViewController:returnVC animated:YES completion:nil];
            }
                break;
            case RouterRoot:
            {
                [UIApplication sharedApplication].delegate.window.rootViewController = returnVC;;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            }
            break;
            case RouterRootNa:
            {
                [UIApplication sharedApplication].delegate.window.rootViewController =  [[UINavigationController alloc]initWithRootViewController:returnVC];;
                [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
            }
            break;
            default:
            break;

            }
    }
}


/*
 * 路由扩展打开其他URL
 * @param  request   路由对象
 */
+ (void)expandHandleOpenWithRequest:(WMZRequest*)request{
    if (request.type==TypeSelfAppAction) {
        return ;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:request.handURL] options:@{} completionHandler:^(BOOL success) {
        if (request.block) {
            request.block(@"打开成功", YES);
        }
    }];
}


/*
 * 获取tableviewCell
 * @param  instance  class
 * @param  request   路由对象
 * returm  id        任意类型
 */
+ (id)expandHandleTableViewCell:(Class)instance WithRequest:(WMZRequest*)request{
    if (request.type != TypeSelfAppAction) {
        return [UITableViewCell new];
    }
    id param = request.param;
    //获取tableviewCell
    id CellTable = param[@"CellTable"];
    if (CellTable) {
        id cell = nil;
        if (![CellTable isKindOfClass:[UITableView class]]) {
            request.errorType = RouterErrorFailPrama;
            return cell;
        }
        cell = [CellTable dequeueReusableCellWithIdentifier:NSStringFromClass([instance class])];
        
        if (!cell) {
            cell = [[[instance class] alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([instance class])];
        }
        
        //防止崩溃、
        if (!cell) {
            cell = instance;
        }
        request.returnValue = cell;
        return cell;
    }
    return [UITableViewCell new];
}

/*
 * 调用清理方法
 * @param  action   方法名
 * @param  params   所带参数
 * returm  target   target
 */
+ (void)deleteLongUnUseHandleWithTarget:(WMZRouter*)instance{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //5分钟调用一次清理的方法
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        if (![user objectForKey:time_router_delete]) {
            [user setObject:[NSDate date] forKey:time_router_delete];
            return;
        }else{
            BOOL time_over = [self compareDate:[NSDate new] WithToDate:[user objectForKey:time_router_delete] withSecond:60*5];
            if (!time_over) {
                return;
            }else{
                [user setObject:[NSDate date] forKey:time_router_delete];
            }
        }
        [user synchronize];
        
        
        //开始清理
        NSMutableArray *deleteArr = [NSMutableArray new];
        for (NSString *handleName in instance.handleDic) {
            NSDictionary *propertiesDic = instance.expandDic[handleName];
            NSDate *date = propertiesDic[@"time"];
            if (date) {
                //6分钟没调用的清除handle
                BOOL delete = [self compareDate:[NSDate date] WithToDate:date withSecond:6*60];
                if (delete) {
                    [deleteArr addObject:handleName];
                }else{
                    continue;
                }
            }
        }
        for (NSString *handleName in deleteArr) {
            [instance.handleDic removeObjectForKey:handleName];
            [instance.expandDic removeObjectForKey:handleName];
        }
    });
}

/*
 * 判断两个时间间隔
 * @param  startDate  厨师时间
 * @param  toDate     比较的时间
 * @param  deleteTime 间隔的时间
 * returm  BOOL       结果
 */
+ (BOOL)compareDate:(NSDate*)startDate WithToDate:(NSDate*)toDate withSecond:(NSInteger)deleteTime{
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    
    NSCalendar* chineseClendar = [ [ NSCalendar alloc ] initWithCalendarIdentifier:NSGregorianCalendar];
    NSUInteger unitFlags = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear;
    
    NSDateComponents *cps = [ chineseClendar components:unitFlags fromDate:toDate  toDate:startDate  options:0];
    
    NSInteger diffDay = [cps second];
    if (diffDay>=deleteTime) {
        return YES;
    }
    return NO;
}


@end
