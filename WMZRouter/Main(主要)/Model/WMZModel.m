


//
//  WMZModel.m
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZModel.h"

@implementation WMZModel
- (NSString *)description{
    return [NSString stringWithFormat:@"%@ %ld %@",self.name,self.age,self.other];
}
+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
}
@end
