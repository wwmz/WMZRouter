


//
//  ViewClass.m
//  WMZRouter
//
//  Created by wmz on 2018/11/12.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "ViewClass.h"
@interface ViewClass()
@property(nonatomic,strong)UILabel *label;
@end
@implementation ViewClass

- (UIView*)getInformationViewWithParma:(NSDictionary*)parma{
    NSString *name = parma[@"name"];
    NSString *detail = parma[@"detail"];
    UIView *superView = parma[@"superView"];
    NSInteger tag = [parma[@"tag"] integerValue];
    if (!superView) {
        return self;
    }
    [superView addSubview:self];
    self.tag = tag;
    UILabel *tip =  [WMZUI newLabelText:name?[NSString stringWithFormat:@"%@ : ",name]:@" : " TextColor:nil SuperView:self Constraint:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.centerY.equalTo(self);
    }];
    
    
    [WMZUI newButtonTitie:@"-->" TextColor:[UIColor blackColor] SuperView:self target:nil action:nil Constraint:^(MASConstraintMaker *make) {
        make.height.equalTo(self);
        make.width.mas_equalTo(40);
        make.centerY.equalTo(self);
        make.right.mas_equalTo(-10);
    }];
    
    self.label =  [WMZUI newLabelText:detail?:@"" TextColor:[UIColor redColor] SuperView:self Constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(tip.mas_right);
        make.centerY.equalTo(self);
        make.width.lessThanOrEqualTo(self).multipliedBy(0.5);
    }];
    
    [WMZUI newViewAddTargetWithView:self target:self action:@selector(tapAction:)];
    
    return self;
}

- (void)tapAction:(UITapGestureRecognizer*)tap{
    UIView *view = tap.view;
    WMZWeakSelf
    if (view.tag==111) {
        [[WMZAlert shareInstance]showAlertWithType:AlertTypeWrite headTitle:@"昵称" textTitle:@"请输入昵称" leftHandle:^(id anyID) {
            
        } rightHandle:^(id anyID) {
            weakSelf.label.text = anyID;
        }];
    }else if (view.tag==112) {
        [[WMZAlert shareInstance]showAlertWithType:AlertTypeWrite headTitle:@"年龄" textTitle:@"请输入年龄" leftHandle:^(id anyID) {
            
        } rightHandle:^(id anyID) {
            weakSelf.label.text = anyID;
        }];
    }else if (view.tag==113) {
        [[WMZAlert shareInstance]showAlertWithType:AlertTypeSelect headTitle:@"婚否" textTitle:@[@"已婚",@"未婚"] leftHandle:^(id anyID) {
            
        } rightHandle:^(id anyID) {
            weakSelf.label.text = anyID;
        }];
    }
}

- (UIView*)getHeadViewWithParma:(NSDictionary*)parma{
    UIView *superView = parma[@"superView"];
    NSString *name = parma[@"name"];
    NSString *detail = parma[@"detail"];
    self.backgroundColor = [UIColor redColor];
    if (superView) {
        [superView addSubview:self];
    }
    UIImageView *image = [WMZUI newImageViewWithName:@"0.png" WithSubView:self Constraint:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(80);
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
    }];
    image.backgroundColor = [UIColor redColor];
    image.layer.masksToBounds = YES;
    image.layer.cornerRadius = 40;
    
    [WMZUI newLabelText:name TextColor:nil SuperView:self Constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(20);
        make.top.equalTo(image.mas_top).offset(5);
    }];
    
    [WMZUI newLabelText:detail TextColor:nil SuperView:self Constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(image.mas_right).offset(20);
        make.bottom.equalTo(image.mas_bottom).offset(-5);
    }];
    [self layoutIfNeeded];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, CGRectGetMaxY(image.frame)+20);
    return self;
}

+ (NSString *)routerPath{
    return @"getView";
}
@end
