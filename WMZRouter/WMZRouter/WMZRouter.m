//
//  WMZRouter.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//
#import "WMZRouter.h"
@implementation WMZRouter

/*
 * 路由调用方法
 * @param  URLString   URL
 * @param  param       参数
 * returm  id          任意类型
 */
- (id)handleWithURL:(id)URLString WithParam:(id)param{
   return [self handleWithURL:URLString WithParam:param WithHandBlock:nil];
}

/*
 * 路由调用方法有回调
 * @param  URLString   URL
 * @param  param       参数
 * @param  dataBlock   回调
 * returm  id          任意类型
 */
- (id)handleWithURL:(id)URLString WithParam:(id)param WithHandBlock:(WMZRouterCallBlock)dataBlock{
    //获取路由对象
    WMZRequest *myURL  = [WMZRequest handldWithURL:URLString withParm:param withBlock:dataBlock];
    
    self.returnURL = myURL;
    
    //处理路由对象 调用的是类或者方法
    [self dealTarget:myURL];
    
    return myURL.returnValue;
   
}



/*
 * 处理路由对象
 * @param  myURL   路由对象
 */
- (void)dealTarget:(WMZRequest*)myURL{
    //处理传进来的URL 还未注册
    if (!self.handleDic[myURL.target]) {
        
           //加入handle
            unsigned int cls_count = 0;
            NSString *app_img = [NSBundle mainBundle].executablePath;
            //获取类库下的所有类
            const char **classes = objc_copyClassNamesForImage([app_img UTF8String], &cls_count);
        
            Protocol *p_handler = @protocol(WMZRouterProtocol);
            for ( unsigned int i = 0 ; i < cls_count ; ++ i ) {
                const char *cls_name = classes[i];
                
                NSString *cls_str = [NSString stringWithUTF8String:cls_name];
                Class cls = NSClassFromString(cls_str);
                
                //判断是否实现了协议
                if (![cls conformsToProtocol:p_handler] ) continue;
                //判断是否实现了协议的routerPath方法
                if (![(id)cls respondsToSelector:@selector(routerPath)] ) continue;
            
                NSString *target =  [(id<WMZRouterProtocol>)cls routerPath];
                //存handle
                [self.handleDic setObject:cls forKey:target];
                //判断时间是否有值 防止被覆盖 
                if (self.expandDic[target]) continue;
                //存handle的其他属性(拓展)
                [self.expandDic setObject:@{@"time":[NSDate date]} forKey:target];
            }
        
            if ( classes )
            free(classes);
        }
    
    //注册完处理
    if (self.handleDic[myURL.target]) {
        Class cls = (Class)self.handleDic[myURL.target];
        
        //判断taget与定义的是否相同
        if (![[(id<WMZRouterProtocol>)cls routerPath] isEqualToString:myURL.target]) {
            myURL.errorType =  RouterErrorFailHandle;
            return;
        }
        
        //更新handle使用的时间
        NSDictionary *dic = self.expandDic[myURL.target];
        if (dic) {
            NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:dic];
            [mdic setObject:[NSDate date] forKey:@"time"];
            [self.expandDic setObject:[NSDictionary dictionaryWithDictionary:mdic] forKey:myURL.target];
        }
        
//        //自动化注册拦截器
//        [self autoReginerAop:myURL];

        //处理获取到的类
        [self analyze:cls withURL:myURL];

    }else{
        myURL.errorType =  RouterErrorFailHandle;
    }
    
}

///*
// * 自动化加载aop协议
// * @param  myURL   路由对象
// */
//- (void)autoReginerAop:(WMZRequest*)myURL{
//    if (!self.handleDic[myURL.target]) {
//        return;
//    }
//    Class cls = (Class)self.handleDic[myURL.target];
//    //自动化加载aop协议
//    Protocol *p_Aop = @protocol(WMZRouterAopProtocol);
//    //判断是否实现了协议
//    if ([cls conformsToProtocol:p_Aop]){
//        //获取协议类方法列表
//        unsigned int numberOfMethods = 0;
//        struct objc_method_description *methodDescriptions = protocol_copyMethodDescriptionList(p_Aop, NO , NO, &numberOfMethods);
//        for (unsigned int i = 0; i < numberOfMethods; ++i) {
//            struct objc_method_description methodDescription = methodDescriptions[i];
//            SEL selector = methodDescription.name;
//            if ([cls respondsToSelector:selector]){
//                NSString *actionName = [NSString stringWithFormat:@"%@:",NSStringFromSelector(selector)];
//                id data = [WMZRouteBase performIDSelector:selector withObjects:nil Tagert:[cls class] withParm:nil];
//                WMZBaseAop *aop = [WMZBaseAop shareInstance] ;
//                if ([aop respondsToSelector:NSSelectorFromString(actionName)]) {
//                    [WMZRouteBase performIDSelector:NSSelectorFromString(actionName) withObjects:nil Tagert:aop withParm:data];
//                }else{
//                    [WMZRouteBase performIDSelector:NSSelectorFromString(actionName) withObjects:nil Tagert:aop withParm:@[]];
//                }
//            }
//      }
//    }else{
//        [[WMZBaseAop shareInstance] emptyArr];
//    }
//}

/*
 * 处理获取到的类
 * @param  className   类名
 * @param  myURL       路由对象
 */
- (void)analyze:(Class)className withURL:(WMZRequest*)myURL {
    
    if (myURL.returnValue) {
        return;
    }
    
    //调用的是实例方法或者类方法
    if (WMZBoolNill(myURL.Expression)&&WMZBoolNill(myURL.target)) {
        [self performSeleectWithClass:className withURL:myURL];
        return;
    }
    
    //只调用对象
    if (WMZBoolNill(myURL.target)) {
        
        myURL.returnValue = [self getClass:myURL WithClass:className];
        
    }
}

/*
 * 判断多方法还是单一方法,实例方法或者类方法调用
 * @param  className   类名
 * @param  myURL       路由对象
 */
- (void)performSeleectWithClass:(Class)className withURL:(WMZRequest*)myURL {
    
    //调用类的方法
    if (WMZBoolNill(myURL.Expression)) {
        //调用多个方法 暂时只支持单例
        if ([myURL.Expression containsString:@"&"])
        {
            NSArray *arr = [myURL.Expression componentsSeparatedByString:@"&"];
            
            NSString *instance = arr[0];
            [self actionStart:className actionName:instance withURL:myURL];
            if (myURL.returnValue) {
                NSString *action = arr[1];
                [self actionStart:className actionName:action withURL:myURL];
                
            }
        }else{//调用类的一个方法
            [self actionStart:className actionName:myURL.Expression withURL:myURL];
        }
    }
    
}

/*
 * 执行方法
 * @param  className   类名
 * @param  actionName  方法名
 * @param  myURL       路由对象
 */
- (void)actionStart:(Class)className actionName:(NSString*)actionName withURL:(WMZRequest*)myURL{
    
    SEL selector = NSSelectorFromString(actionName);
    //实例方法
    myURL.returnValue = [WMZRouteBase performIDSelector:selector withObjects:myURL Tagert:[className new] withParm:myURL.param];
    if (myURL.errorType==RouterErrorFailAction) {
        //类方法
        myURL.returnValue = [WMZRouteBase performIDSelector:selector withObjects:myURL Tagert:className withParm:myURL.param];
    }
    
}


/*
 * 返回属性有值的对象
 * @param  myClassName   类名
 * @param  myURL         路由对象
 * @return id            属性有值的对象
 */
- (id)getClass:(WMZRequest*)myURL WithClass:(Class)myClassName{
    
    NSDictionary *propertys = myURL.param;

    if (!myClassName) {
        return nil;
    }

    // 创建对象
    id instance = [[myClassName alloc] init];
    
    if (propertys) {
        
        unsigned int outCount, i;
        NSMutableArray *propertyArr = [NSMutableArray new];
        objc_property_t * properties = class_copyPropertyList([instance class], &outCount);
        //获取所有属性
        for (i = 0; i < outCount; i++) {
            objc_property_t property =properties[i];
            NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
            if (propertyName) {
                [propertyArr addObject:propertyName];
            }
            }
        if (properties)
        free(properties);
       
        [propertys enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            //存在该属性赋值
            for (NSString *name in propertyArr) {
                if ([name isEqualToString:key]) {
                    [instance setValue:obj forKey:key];
                }
            }
        }];
        
    }
    
    return instance;
}

- (NSMutableDictionary *)handleDic{
    if (!_handleDic) {
        _handleDic = [NSMutableDictionary new];
    }
    return _handleDic;
}
- (NSMutableDictionary *)expandDic{
    if (!_expandDic) {
        _expandDic = [NSMutableDictionary new];
    }
    return _expandDic;
}

@end
