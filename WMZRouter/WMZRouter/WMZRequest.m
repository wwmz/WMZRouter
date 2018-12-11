//
//  WMZRequest.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZRequest.h"

@implementation WMZRouterURL

+ (instancetype)Instance{
    return [[self alloc] init];
}

- (WMZRouterURL *(^)(NSString*))openURL{
    return ^WMZRouterURL*(NSString* scheme){
        self.scheme = scheme;
        return self;
    };
}

- (WMZRouterURL *(^)(NSString*))target{
    return ^WMZRouterURL*(NSString* _target){
        self.mTarget = _target;
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull))action{
    return ^WMZRouterURL*(NSString* _action){
        self.mAction = _action;
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull))actions{
    return ^WMZRouterURL*(NSString* _action){
        self.mAction = [NSString stringWithFormat:@"%@:",_action];
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))target_Action{
    return ^WMZRouterURL*(NSString* _target,NSString* _action){
        self.mTarget = _target;
        self.mAction = _action;
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull))target_Actions{
    return ^WMZRouterURL*(NSString* _target,NSString* _action){
        self.mTarget = _target;
        self.mAction = [NSString stringWithFormat:@"%@:",_action];
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))SingleTarget_Action{
    return ^WMZRouterURL*(NSString* _target,NSString* _shareInstance,NSString* _action){
        self.mTarget = _target;
        self.shareInstance = _shareInstance;
        self.mAction = [NSString stringWithFormat:@"%@",_action];
        return self;
    };
}

- (WMZRouterURL * _Nonnull (^)(NSString * _Nonnull, NSString * _Nonnull, NSString * _Nonnull))Singletarget_Actions{
    return ^WMZRouterURL*(NSString* _target,NSString* _shareInstance,NSString* _action){
        self.mTarget = _target;
        self.shareInstance = _shareInstance;
        self.mAction = [NSString stringWithFormat:@"%@:",_action];
        return self;
    };
}

WMZRouterURL * RouterURL(void){
    return [WMZRouterURL Instance];
}

@end


                           //==================================================================================//
                           //==================================================================================//
                           //==================================================================================//



@implementation WMZRequest

/*
 * 创建路由对象
 * @param  URL  传入的URL
 * @param  param 参数
 * @param  block 回调
 * returm  WMZRequest对象
 */
+ (WMZRequest*)handldWithURL:(id)URL withParm:(id)parm withBlock:(WMZRouterCallBlock)block{
    WMZRequest *request = [WMZRequest new];
    //只能传字符串类型和WMZRouterURL类型
    if (!URL||(![URL isKindOfClass:[NSString class]]&&![URL isKindOfClass:[WMZRouterURL class]])) {
        return request;
    }
    request.block = block;
    if ([parm isKindOfClass:[WMZRouterParam class]]) {
        WMZRouterParam *tempParam = (WMZRouterParam*)parm;
        request.param = [NSDictionary dictionaryWithDictionary:tempParam.routerDic];
    }else if([parm isKindOfClass:[NSDictionary class]]||[parm isKindOfClass:[NSMutableDictionary class]]){
       request.param = [NSDictionary dictionaryWithDictionary:parm];
    }else{
        request.param = parm;
    }

    
    if (block&&request.param[@"netWork"]) {
        NSMutableDictionary *mdic = [NSMutableDictionary dictionaryWithDictionary:request.param];
        [mdic setObject:request.block forKey:@"block"];
        request.param = [NSDictionary dictionaryWithDictionary:mdic];
        
    }
    
    if ([URL isKindOfClass:[NSString class]]) {
        NSRange range = [URL rangeOfString:@"://"];
        NSString *tagetAndExpression = URL;
        if (range.location != NSNotFound) {
            request.scheme = [URL substringWithRange:NSMakeRange(0,range.location)];
            tagetAndExpression = [URL substringFromIndex:range.length+range.location];
        }
        
        if ([tagetAndExpression containsString:@"/"]) {
            NSArray *arr = [tagetAndExpression componentsSeparatedByString:@"/"];
            
            if (arr.count>0) {
                if (WMZBoolNill(arr[0])) {
                    request.target = arr[0];
                }
                NSString *string  = nil;
                if (arr.count==2) {
                    string = arr[1];
                }else {
                    NSMutableString *mString = [NSMutableString new];
                    for (int i = 1; i<arr.count; i++) {
                        if (i==1) {
                            [mString appendString:arr[i]?[NSString stringWithFormat:@"%@",arr[i]]:@""];
                        }else{
                            [mString appendString:arr[i]?[NSString stringWithFormat:@"&%@",arr[i]]:@""];
                        }
                    }
                    string = [NSString stringWithFormat:@"%@",mString];
                }
                if (WMZBoolNill(string)) {
                    request.Expression = string;
                }
            }
        }else{
            if (WMZBoolNill(tagetAndExpression)) {
                request.target = tagetAndExpression;
            }
        }
        
        
        if (!WMZBoolNill(request.scheme)) {
            request.scheme = [[NSBundle mainBundle]bundleIdentifier];
            request.handURL = [NSString stringWithFormat:@"%@://%@",request.scheme,URL];
        }else{
            request.handURL = URL;
        }
    }
   
    if ([URL isKindOfClass:[WMZRouterURL class]]) {
        WMZRouterURL *routerURL = (WMZRouterURL*)URL;
        if (routerURL.scheme) {
            request.handURL = routerURL.scheme;
 
        }else{
            request.target = routerURL.mTarget;
            request.Expression = routerURL.mAction;
            request.scheme = [[NSBundle mainBundle]bundleIdentifier];
            if (routerURL.shareInstance) {
                request.handURL = [NSString stringWithFormat:@"%@://%@/%@/%@",request.scheme,request.target,routerURL.shareInstance,request.Expression];
                request.Expression = [NSString stringWithFormat:@"%@&%@",routerURL.shareInstance,routerURL.mAction];
            }else{
                request.handURL = [NSString stringWithFormat:@"%@://%@/%@",request.scheme,request.target,request.Expression];
            }
        }
    }
    
   

    if ([request.scheme isEqualToString:@"tel"]) {
        request.type = TypeTell;
    }else if ([request.scheme isEqualToString:@"http"]||[request.scheme isEqualToString:@"https"]){
        request.type = TypeWeb;
    }
    else if ([request.scheme isEqualToString:@"mailto"]){
        request.type = TypeMailto;
    }else if ([[[NSBundle mainBundle]bundleIdentifier] isEqualToString:request.scheme]){
           request.type = TypeSelfAppAction;
    }else{
           request.type = TypeOtherApp;
    }
    
    
    return request;
    
}


@end
