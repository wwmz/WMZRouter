

//
//  WMZSingleVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/14.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZSingleVC.h"

@implementation WMZSingleVC
static WMZSingleVC *_instance;
/*
 * 初始化
 */
+(instancetype)shareInstance{
    return [[self alloc] init];
    
}

+(id)allocWithZone:(struct _NSZone *)zone
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



- (NSString*)shareAction2:(NSDictionary*)paran{
    NSString *name = paran[@"name"];
    [self.arr addObject:name];
    NSLog(@"222%@",self.arr);
    [[WMZAlert shareInstance]showAlertWithType:AlertTypeAuto textTitle:@"单例方法"];
    return @"222";
}

+ (NSString *)routerPath{
    return @"shareVC";
}

- (NSMutableArray *)arr{
    if (!_arr) {
        _arr = [NSMutableArray new];
    }
    return _arr;
}
@end
