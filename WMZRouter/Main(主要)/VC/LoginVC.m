//
//  LoginVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "LoginVC.h"

@interface LoginVC ()
@property(nonatomic,strong)UITextField *moble;
@property(nonatomic,strong)UITextField *password;
@property(nonatomic,strong)UIButton *loginBtn;
@property(nonatomic,strong)UIButton *reginBtn;
@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    [WMZUI newViewWithBackColor:[UIColor clearColor] WithSubView:self.view target:self action:@selector(emptyAction) Constraint:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(0);
    }];
    
    self.moble = [WMZUI newTextFieldTextColor:nil Font:0 TextAlignment:0 Placeholder:@"请输入至少5位的手机号" KeyWord:UIKeyboardTypePhonePad WithSubView:self.view Constraint:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.mas_equalTo(50);
    }];
    self.moble.layer.borderColor = [UIColor cyanColor].CGColor;
    self.moble.layer.borderWidth = 0.5;
    
    
    self.password = [WMZUI newTextFieldTextColor:nil Font:0 TextAlignment:0 Placeholder:@"请输入至少3位的密码" KeyWord:0 WithSubView:self.view Constraint:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.moble.mas_bottom).offset(20);
        make.width.equalTo(self.view).multipliedBy(0.6);
        make.height.mas_equalTo(50);
    }];
    self.password.layer.borderColor = [UIColor cyanColor].CGColor;
    self.password.layer.borderWidth = 0.5;
    
    self.loginBtn =  [WMZUI newButtonTitie:@"登录" TextColor:[UIColor orangeColor] SuperView:self.view target:self action:@selector(loginAction) Constraint:^(MASConstraintMaker *make) {
        make.left.equalTo(self.password.mas_left);
        make.width.equalTo(self.view).multipliedBy(0.25);
        make.height.mas_equalTo(40);
        make.top.equalTo(self.password.mas_bottom).offset(20);
    }];
    
    
    self.reginBtn =  [WMZUI newButtonTitie:@"(没账号)注册" TextColor:[UIColor orangeColor] SuperView:self.view target:self action:@selector(reginEnterAction) Constraint:^(MASConstraintMaker *make) {
        make.right.equalTo(self.password.mas_right);
        make.width.equalTo(self.view).multipliedBy(0.35);
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

//登录方法
- (void)loginAction{
    [self emptyAction];
    
    WMZRouter *router = [WMZRouter shareInstance];

    id checkURL =  RouterURL().target_Actions(@"checkTool", @"checkLoginPhoneAndPassWordWithParam");
    id checkParam =  RouterParam().selfParam(@{
                              @"phone":self.moble.text,
                              @"passWord":self.password.text,
                              });
    NSNumber *check =  [router handleWithURL:checkURL WithParam:checkParam];

    if (check&&check.boolValue) {
        //跳转VC
        id checkURL = RouterURL().target(@"getBaseTabVC");
        id param = RouterParam().enterVCStyle(RouterRoot);
        //tabbar 需要自己跳转 
        id VC =  [router handleWithURL:checkURL WithParam:param];
        [UIApplication sharedApplication].delegate.window.rootViewController = VC;;
        [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
        
    }
    


}

//注册方法
- (void)reginEnterAction{
    
    id URL = RouterURL().target(@"getReginerVC");
    id param =  RouterParam().permissions(PermissionTypePhoto, ^(id anyID, BOOL success) {
        NSLog(@"%@",anyID);
    }).enterVCStyle(RouterPush).log(@"日志").cache(^(id anyID, BOOL success) {
        NSLog(@"缓存");
    }).cacheTime(10).error(RouterPushFail).selfParam(@{});
    [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
    
}


@end
