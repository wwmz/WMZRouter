//
//  WMZSingleVC.h
//  WMZRouter
//
//  Created by wmz on 2018/11/14.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZSingleVC : BaseObject

+ (instancetype)shareInstance;

- (NSString*)shareAction2:(NSDictionary*)paran;

@property(nonatomic,strong)NSMutableArray *arr;

@end

NS_ASSUME_NONNULL_END
