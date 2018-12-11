//
//  ReginerVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "ReginerVC.h"

@interface ReginerVC ()
@property(nonatomic,strong)UITextField *moble;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UIButton *loginBtn;
@end

@implementation ReginerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [WMZUI newViewWithBackColor:[UIColor clearColor] WithSubView:self.view target:self action:@selector(emptyAction) Constraint:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.moble = [WMZUI newTextFieldTextColor:nil Font:0 TextAlignment:0 Placeholder:@"请输入至少5位的手机号" KeyWord:UIKeyboardTypePhonePad WithSubView:self.view Constraint:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.mas_equalTo(50);
    }];
    self.moble.layer.borderColor = [UIColor redColor].CGColor;
    self.moble.layer.borderWidth = 0.5;
    
    
    self.password = [WMZUI newTextFieldTextColor:nil Font:0 TextAlignment:0 Placeholder:@"请输入至少3位的密码" KeyWord:0 WithSubView:self.view Constraint:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.moble.mas_bottom).offset(20);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.mas_equalTo(50);
    }];
    self.password.layer.borderColor = [UIColor redColor].CGColor;
    self.password.layer.borderWidth = 0.5;
    
    self.loginBtn =  [WMZUI newButtonTitie:@"注册" TextColor:[UIColor orangeColor] SuperView:self.view target:self action:@selector(reginAction) Constraint:^(MASConstraintMaker *make) {
        make.right.equalTo(self.password.mas_right);
        make.left.equalTo(self.password.mas_left);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.password.mas_bottom).offset(20);
    }];
    
    self.moble.text = @"13178864836";
    self.password.text= @"123456";
}

- (void)emptyAction{
    [self.moble resignFirstResponder];
    [self.password resignFirstResponder];
}

- (void)reginAction{
    [self emptyAction];
    WMZRouter *router = [WMZRouter shareInstance];
    
    
    
    id URL =  RouterURL().target(@"checkTool").actions(@"checkReginPhoneAndPassWordWithParam");
    id param = RouterParam().selfParam(@{
                              @"phone":self.moble.text,
                              @"passWord":self.password.text,
                              
                              });
    //判断输入
    NSNumber *check =  [router handleWithURL:URL WithParam:param];
    
    if (check&&check.boolValue) {
        
        id checkURL =  RouterURL().target(@"checkTool").actions(@"checkInfomation");
        NSNumber *pushVC =  [router handleWithURL:checkURL WithParam:nil];
         //跳转VC
        if (pushVC.boolValue) {
            [router handleWithURL:RouterURL().target(@"getBaseTabVC") WithParam:RouterParam().enterVCStyle(RouterRoot)];
        }else{
            [router handleWithURL:RouterURL().target(@"getPersonVC") WithParam:RouterParam().enterVCStyle(RouterPush)];
            
        }
       
      
    }
    
}



@end
