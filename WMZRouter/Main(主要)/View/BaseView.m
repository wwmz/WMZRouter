//
//  BaseView.m
//  WMZRouter
//
//  Created by wmz on 2018/11/20.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseView.h"

@implementation BaseView

+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
}

@end
