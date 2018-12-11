//
//  NetWorkTool.h
//  WMZRouter
//
//  Created by wmz on 2018/11/16.
//  Copyright © 2018年 wmz. All rights reserved.
//
#define NetWorkResponseBlock void (^)(NSString * resultCode,NSDictionary *post_dic)
#define NetWorkResponseErrorBlock void (^)(NSString * resultCode, NSString *reslut_describe)
#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface NetWorkTool : BaseObject

+ (void)netWorkSuccessTestWithSuccessWithParm:(NSDictionary*)dic;


+ (void)netWorkFailTestWithSuccessWithParm:(NSDictionary*)dic;

@end

NS_ASSUME_NONNULL_END
