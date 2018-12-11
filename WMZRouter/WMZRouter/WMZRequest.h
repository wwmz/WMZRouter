//
//  WMZRequest.h
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

//处理URL格式
typedef enum : NSUInteger{
    TypeSelfAppAction,          //调用本app的方法
    TypeOtherApp,               //打开其他app
    TypeTell,                   //打电话
    TypeMailto,                 //打开邮箱
    TypeWeb,                    //打开外部浏览器网页
}RouterHandleType;

//handle URL或者传参 错误
typedef enum : NSUInteger{
    RouterSuccess,                   //正常
    RouterErrorFailURLError,         //传入URL格式错误
    RouterErrorFailHandle,           //注册handle失败
    RouterErrorFailAction,           //找不到调用的方法
    RouterErrorFailInstance,         //找不到调用的对象或者对象类型不符合要求
    RouterErrorFailPrama,            //携带参数错误
    RouterErrorFailReturn            //调用方法返回值错误
}RouterError;

//错误相对应处理
typedef enum : NSUInteger{
    RouterPushH5,                    //降级跳转h5
    RouterPushFail,                  //跳转到失败界面
    RouterUpdateRequire,             //强制升级
    RouterUpdate,                    //不强制升级
    RouterBack                       //错误返回由使用者操作
    /*
     *。。。。。。。。。。。。。。。。。。。//自定义
     */
}RouterErrorAction;


//VC跳转
typedef enum : NSUInteger{
    RouterPush,                      //push
    RouterPushHideTabBackShow,       //push跳转过去先隐藏tabbar返回时显示tabbar
    RouterPushHideTab,               //push跳转过去隐藏tabbar
    RouterPresent,                   //模态跳转
    RouterRoot,                      //设为当前window的根控制器
    RouterRootNa       =6            //设为当前window的根控制器带导航栏
}RouterVCPush;


//权限类型
typedef enum : NSUInteger{
    PermissionTypeCamera,           //相机权限
    PermissionTypeMic,              //麦克风权限
    PermissionTypePhoto,            //相册权限
    PermissionTypeLocationAll,      //获取地理位置Always
    PermissionTypeLocationWhen,     //获取地理位置When
    PermissionTypeCalendar,         //日历
    PermissionTypeReminder,         //Reminder
    PermissionTypeContacts          //联系人
}PermissionType;


/*
 * 数据回调
 */
typedef void (^WMZRouterCallBlock)(id anyID,BOOL success);

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

/*
 * 便捷式拼装URL 外部调用
 */
@interface WMZRouterURL :NSObject

/*
 * 初始化
 */
WMZRouterURL * RouterURL(void);



/*
 * 调用打开其他URL
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^openURL)(NSString* scheme);


/*
 * 只调用对象
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^target)(NSString* _target);

/*
 * 调用方法不带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^action)(NSString* _action);

/*
 * 调用方法带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^actions)(NSString* _action);

/*
 * 调用对象方法不带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^target_Action)(NSString* _target,NSString* _action);


/*
 * 调用单例方法不带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^SingleTarget_Action)(NSString* _target,NSString* _shareInstance,NSString* _action);


/*
 * 调用单例方法带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^Singletarget_Actions)(NSString* _target,NSString* _shareInstance,NSString* _action);

/*
 * 调用对象方法不带参数
 */
@property(nonatomic,copy,readonly) WMZRouterURL *(^target_Actions)(NSString* _target,NSString* _action);

@property(nonatomic,copy)NSString *scheme;

@property(nonatomic,copy)NSString *mTarget;

@property(nonatomic,copy)NSString *mAction;

@property(nonatomic,copy)NSString *shareInstance;

@end


                //==================================================================================//
                //==================================================================================//
                //==================================================================================//

/*
 * 此类为路由的对象
 */
@interface WMZRequest : NSObject
/*
 * scheme
 */
@property(nonatomic,copy)NSString *scheme;

/*
 * target 对象
 */
@property(nonatomic,copy)NSString *target;

/*
 * 方法
 */
@property(nonatomic,copy)NSString *Expression;

/*
 * 整个URL
 */
@property(nonatomic,copy)NSString *handURL;

/*
 * 返回的值
 */
@property(nonatomic,strong)id returnValue;

/*
 * handle type
 */
@property(nonatomic,assign)RouterHandleType type;

/*
 * handle error type
 */
@property(nonatomic,assign)RouterError errorType;

/*
 * block
 */
@property(nonatomic,copy)WMZRouterCallBlock block;

/*
 * 参数
 */
@property(nonatomic,strong) NSDictionary* param;

/*
 * 创建路由对象
 * @param  URL  传入的URL
 * @param  param 参数
 * @param  block 回调
 * returm  WMZRequest对象
 */
+ (WMZRequest*)handldWithURL:(id)URL withParm:(id)parm withBlock:(WMZRouterCallBlock)block;



@end




NS_ASSUME_NONNULL_END
