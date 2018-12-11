//
//  PersonVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "PersonVC.h"

@interface PersonVC ()
{
    
}
@property(nonatomic,strong)UIView *nameView;
@property(nonatomic,strong)UIView *ageView;
@property(nonatomic,strong)UIView *marryView ;
@end

@implementation PersonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [WMZUI newLabelText:@"填写资料" TextColor:[UIColor blueColor] SuperView:self.view Constraint:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(100);
        make.centerX.equalTo(self.view);
    }];
    
    
    //同过路由获取View
    NSString *keyName = [NSString stringWithFormat:@"%@_%@",UserName,WMZObjectGet(UserPhone)];
    id URL1 = RouterURL().target(@"getView").actions(@"getInformationViewWithParma");
    id param1 = RouterParam().selfParam(@{
                                          @"name":@"昵称",
                                          @"detail":WMZObjectGet(keyName),
                                          @"tag":@(111),
                                          @"superView":self.view});
    self.nameView =  [[WMZRouter shareInstance] handleWithURL:URL1 WithParam:param1];
    
    [self.nameView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-100);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.mas_equalTo(50);
    }];

    
     NSString *keyAge = [NSString stringWithFormat:@"%@_%@",UserAge,WMZObjectGet(UserPhone)];
    id URL2 = RouterURL().target(@"getView").actions(@"getInformationViewWithParma");
    id param2 = RouterParam().selfParam(@{
                                          @"name":@"年龄",
                                          @"detail":WMZObjectGet(keyAge),
                                          @"tag":@(112),
                                          @"superView":self.view
                                          });
    self.ageView =  [[WMZRouter shareInstance] handleWithURL:URL2 WithParam:param2];
    [self.ageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.nameView.mas_bottom).offset(30);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.mas_equalTo(50);
    }];

     NSString *keyMarry = [NSString stringWithFormat:@"%@_%@",UserMarry,WMZObjectGet(UserPhone)];
    id URL3 = RouterURL().target(@"getView").actions(@"getInformationViewWithParma");
    id param3 = RouterParam().selfParam(@{
                                          @"name":@"婚否",
                                          @"detail":WMZObjectGet(keyMarry),
                                          @"tag":@(113),
                                          @"superView":self.view
                                          });
    self.marryView =  [[WMZRouter shareInstance] handleWithURL:URL3 WithParam:param3];
    [self.marryView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.ageView.mas_bottom).offset(30);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.mas_equalTo(50);
    }];

    
    
    [WMZUI newButtonTitie:@"保存" TextColor:[UIColor whiteColor] BackColor:[UIColor orangeColor] WithFont:15 radio:10 SuperView:self.view target:self action:@selector(saveAction) Constraint:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.marryView.mas_bottom).offset(30);
        make.width.equalTo(self.view).multipliedBy(0.7);
        make.height.mas_equalTo(50);
    }];
    
}

- (void)saveAction{
    //kvo
    UILabel *la1 = [self.nameView valueForKey:@"label"];
    UILabel *la2 = [self.ageView valueForKey:@"label"];
    UILabel *la3 = [self.marryView valueForKey:@"label"];
    if (la1.text.length==0||la2.text.length== 0 || la3.text.length==0) {
        [[WMZAlert shareInstance]showAlertWithType:AlertTypeAuto textTitle:@"不能为空"];
        return;
    }
    NSString *keyName = [NSString stringWithFormat:@"%@_%@",UserName,WMZObjectGet(UserPhone)];
    NSString *keyAge = [NSString stringWithFormat:@"%@_%@",UserAge,WMZObjectGet(UserPhone)];
    NSString *keyMarry = [NSString stringWithFormat:@"%@_%@",UserMarry,WMZObjectGet(UserPhone)];
    WMZObjectSave(la1.text,keyName);
    WMZObjectSave(la2.text,keyAge);
    WMZObjectSave(la3.text,keyMarry);
    
    id URL = RouterURL().target(@"getBaseTabVC");
    id param = RouterParam().enterVCStyle(RouterRoot);
    [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
}


@end
