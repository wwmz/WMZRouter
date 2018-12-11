//
//  WMZRouterAop.m
//  WMZRouter
//
//  Created by wmz on 2018/11/21.
//  Copyright © 2018年 wmz. All rights reserved.
//

/*
 *
 *
 *  要添加自己定制的拦截器 需要去拦截器协议定义一个方法  然后在这里实现方法
 *
 *
 */


//拦截器默认开启或是关闭
#define openAop YES

//路由拦截器可以拦截的路由方法
typedef enum : NSUInteger{
    //Router中对应的方法
    AopTypeDealTarget              = 0,                //处理路由对象方法                           (dealTarget:)
    AopTypeAnalyze                 = 1,                //处理获取到的类                            (analyze:withURL:)
    AopTypePerformSeleectWithClass = 2,                //判断多方法还是单一方法,实例方法或者类方法调用   (performSeleectWithClass:withURL:)
    AopTypeactionStart             = 3,                //执行方法                                 (actionStart:actionName:withURL:)
    AopTypeUse                     = 4                 //使用路由的方法                            (handleWithURL:WithParam: WithHandBlock:)
}RouterAopType;

#import "WMZRouterAop.h"

@implementation WMZRouterAopModel
- (instancetype)initWithOptions:(NSInteger)options Sort:(NSInteger)sort ActionNameType:(NSInteger)actionNameType{
    if (self = [super init]) {
        self.options = options;
        self.sort = sort;
        self.actionNameType = actionNameType;
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"拦截位置:%@  方法名对应type:%ld 优先级:%ld 对应拦截前的方法名%@", self.options==0?@"前拦截器":@"后拦截器",self.actionNameType,self.sort,self.selectorName];
}

@end


@interface WMZRouterAop()

@property(nonatomic,assign)BOOL openURL;

@property(nonatomic,assign)BOOL permissions;

@property(nonatomic,assign)BOOL dataCache;

@property(nonatomic,assign)BOOL specialParameters;

@property(nonatomic,assign)BOOL clean;

@property(nonatomic,assign)BOOL error;

@end
@implementation WMZRouterAop

static WMZRouterAop *_instance;
/*
 * 单例
 */
+(instancetype)shareInstance{
    return [[self alloc] init];
    
}

+(id) allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    
    return _instance;
}

- (instancetype)copyWithZone:(NSZone *)zone
{
    return _instance;
}

- (instancetype)mutableCopyWithZone:(NSZone *)zone
{
    return _instance;
}

/*
 * 添加本类的所有拦截操作
 */
- (void)addAllAop{

    //传入元类 获取所有类方法 并对拦截器进行设置的优先级排序
    unsigned int count_second;
    Class metaClass = object_getClass([self class]);
    Method *Lmethods = class_copyMethodList(metaClass, &count_second);
    //拦截器数组
    NSMutableArray *aopArr = [NSMutableArray new];
    //前拦截器数组
    NSMutableArray *beforeArr = [NSMutableArray new];
    //后拦截器数组
    NSMutableArray *afterArr = [NSMutableArray new];
    for (int i = 0; i < count_second; i++) {
        Method method = Lmethods[i];
        SEL selector = method_getName(method);
        id returnValue =  [WMZRouteBase performIDSelector:selector withObjects:nil Tagert:[self class] withParm:nil];
        if ([returnValue isKindOfClass:[WMZRouterAopModel class]]) {
            WMZRouterAopModel *model = (WMZRouterAopModel*)returnValue;
            model.selectorName = NSStringFromSelector(selector);
            if (model.options == AspectPositionAfter) {
                [afterArr addObject:model];
            }
            if (model.options == AspectPositionBefore) {
                [beforeArr addObject:model];
            }
            
        }
    }
    if ( Lmethods )
    free(Lmethods);
    
    //按规则排序
    NSSortDescriptor *optionsSD=[NSSortDescriptor sortDescriptorWithKey:@"options" ascending:YES];   //ascending:YES 代表升序 如果为NO 代表降序
    NSSortDescriptor *actionNameTypeSD = [NSSortDescriptor sortDescriptorWithKey:@"actionNameType" ascending:NO];
    NSSortDescriptor *sortAscendingSD=[NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:YES];
    NSSortDescriptor *sortUnAscendingSD=[NSSortDescriptor sortDescriptorWithKey:@"sort" ascending:NO];
    [beforeArr sortUsingDescriptors:@[actionNameTypeSD,sortAscendingSD]];
    [afterArr sortUsingDescriptors:@[actionNameTypeSD,sortUnAscendingSD]];
    
    [aopArr addObjectsFromArray:beforeArr];
    [aopArr addObjectsFromArray:afterArr];
    
    [aopArr sortUsingDescriptors:@[optionsSD]];
    //执行添加拦截器方法
    for (WMZRouterAopModel *model in aopArr) {
        NSLog(@"%@",model);
        if (model.selectorName) {
            SEL selector = NSSelectorFromString(model.selectorName);
            [WMZRouterAop performSelector:selector withObject:@(1)];
        }
        
    }

}

/*
 * 拦截非调用本app的操作
 */
+ (WMZRouterAopModel*)dealWithOpenURL:(NSNumber*)shouldReturn{
    
    if (!shouldReturn) {
        return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionBefore Sort:1 ActionNameType:AopTypeDealTarget];
    }
    
    [WMZRouter aspect_hookSelector:@selector(dealTarget:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo)
     {
         if (!_instance.openURL) return;
             NSLog(@"拦截非本app的方法作相应处理开始");
             //拦截非本app的方法作相应处理
             WMZRouter *route = aspectInfo.instance;
             
             if (route.returnURL.type!=TypeSelfAppAction) {
                 [WMZRouter expandHandleActionWithID:@"" WithRequest:route.returnURL];
                 return;
             }
     } error:NULL];
    return nil;
}

/*
 * 权限设置
 */
+ (WMZRouterAopModel*)setPermissions:(NSNumber*)shouldReturn{
   if (!shouldReturn) {
       return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionBefore Sort:2 ActionNameType:AopTypeAnalyze];
    }
    //添加前拦截器在路由方法调用前调用 
    [WMZRouter aspect_hookSelector:@selector(analyze:withURL:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo)
     {
         if (!_instance.permissions) return;
         NSLog(@"权限设置开始");
     } error:NULL];
     return nil;
}

/*
 * 数据缓存
 */
+ (WMZRouterAopModel*)dataCache:(NSNumber*)shouldReturn{
    if (!shouldReturn) {
        return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionBefore Sort:1 ActionNameType:AopTypeAnalyze];
    }
    //添加前拦截器在路由方法调用前调用
    [WMZRouter aspect_hookSelector:@selector(analyze:withURL:) withOptions:AspectPositionBefore usingBlock:^(id<AspectInfo> aspectInfo)
     {
         if (!_instance.dataCache) return;
         NSLog(@"数据缓存开始");
     } error:NULL];
    return nil;
}

/*
 * 处理特殊参数
 */
+ (WMZRouterAopModel*)dealWithspecialParameters:(NSNumber*)shouldReturn{
    if (!shouldReturn) {
        return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionAfter Sort:3 ActionNameType:AopTypeUse];
    }
    //添加后拦截器处理特殊参数操作
    [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo)
     {
         if (!_instance.specialParameters) return;
         WMZRouter *route = aspectInfo.instance;
         NSLog(@"处理特殊参数操作开始");
         if ([WMZRouter containSuperParam:route.returnURL.param]&&!route.returnURL.Expression) {
             route.returnURL.returnValue = [WMZRouter expandHandleActionWithID:route.returnURL.returnValue WithRequest:route.returnURL];
         }
     } error:NULL];
    return nil;
}

/*
 * 清理handle缓存
 */
+ (WMZRouterAopModel*)clean:(NSNumber*)shouldReturn{
    if (!shouldReturn) {
        return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionAfter Sort:5 ActionNameType:AopTypeUse];
    }
    //添加后拦截器定时清理（5分钟清理一次）长时间未使用的handle
    [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo)
     {
         if (!_instance.clean) return;
         NSLog(@"定时清理 5分钟清理一次 开始");
         [WMZRouter deleteLongUnUseHandleWithTarget:aspectInfo.instance];
     } error:NULL];
    return nil;
    
}

/*
 * 错误处理
 */
+ (WMZRouterAopModel*)dealWitherror:(NSNumber*)shouldReturn{
    if (!shouldReturn) {
        return [[WMZRouterAopModel alloc]initWithOptions:AspectPositionAfter Sort:2 ActionNameType:AopTypeUse];
    }
    //添加后拦截器进行错误处理
    [WMZRouter aspect_hookSelector:@selector(handleWithURL:WithParam:WithHandBlock:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> aspectInfo)
     {
        if (!_instance.error) return;
         NSLog(@"错误处理 开始");
         WMZRouter *route = aspectInfo.instance;
         [WMZRouter expandHandleErrorWithRequest:route.returnURL];
     } error:NULL];
    return nil;
}


//实现方法名字需与协议定制的方法一样

/*
 * 拦截非调用本app的操作
 */
+ (BOOL)candealWithOpenURL:(NSNumber*)can{
     //给默认开启拦截器的值 openAop
     return _instance.openURL = [can?:@(openAop) boolValue];
}

/*
 * 权限设置
 */
+ (BOOL)canPermissions:(NSNumber*)can{
    return _instance.permissions = [can?:@(openAop) boolValue];
}

/*
 * 数据缓存
 */
+ (BOOL)candataCache:(NSNumber*)can{
    return _instance.dataCache = [can?:@(openAop) boolValue];
}

/*
 * 处理特殊参数
 */
+ (BOOL)candealWithspecialParameters:(NSNumber*)can{
    return  _instance.specialParameters = [can?:@(openAop) boolValue];
}

/*
 * 清理handle缓存
 */
+ (BOOL)canclean:(NSNumber*)can{
    return _instance.clean = [can?:@(openAop) boolValue];
}

/*
 * 错误处理
 */
+ (BOOL)candealWitherror:(NSNumber*)can{
    return _instance.error = [can?:@(openAop) boolValue];
}
@end
