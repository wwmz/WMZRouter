//
//  NewsModel.h
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsModel : BaseObject

@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *text;

@property (nonatomic, copy) NSString *icon;

@property (nonatomic, copy) NSString *time;

@property (nonatomic, copy) NSString *ID;

@end

NS_ASSUME_NONNULL_END
