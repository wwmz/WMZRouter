//
//  WMZModel.h
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface WMZModel : BaseObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger age;

@property (nonatomic, copy) NSString *other;

@end

NS_ASSUME_NONNULL_END
