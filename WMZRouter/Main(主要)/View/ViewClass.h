//
//  ViewClass.h
//  WMZRouter
//
//  Created by wmz on 2018/11/12.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseView.h"

NS_ASSUME_NONNULL_BEGIN

@interface ViewClass : BaseView

- (UIView*)getInformationViewWithParma:(NSDictionary*)parma;

- (UIView*)getHeadViewWithParma:(NSDictionary*)parma;

@end

NS_ASSUME_NONNULL_END
