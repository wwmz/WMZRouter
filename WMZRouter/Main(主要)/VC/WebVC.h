//
//  WebVC.h
//  WMZRouter
//
//  Created by wmz on 2018/11/9.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseVC.h"

NS_ASSUME_NONNULL_BEGIN

@interface WebVC : BaseVC
@property (nonatomic, strong) NSURL *URL;

@property (nonatomic, assign) BOOL btnShow;
@end

NS_ASSUME_NONNULL_END
