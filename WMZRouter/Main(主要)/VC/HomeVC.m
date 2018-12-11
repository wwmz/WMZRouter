



//
//  HomeVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "HomeVC.h"
@interface HomeVC ()
@property(nonatomic,strong)WMZTableView *table;
@end

@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
   WMZWeakSelf
    
   self.table = [[WMZTableView sharePlain] addTableViewWithType:0 withConstraint:^(MASConstraintMaker *make) {
       make.top.left.right.bottom.mas_equalTo(0);
    } withSuperView:self.view withData:@[@"跳转外部网页",@"跳转内部网页",@"网络请求测试成功(等待请求完回调)",@"网络请求测试失败",@"获取headView",@"获取Model",@"跳转其他APP",@"带block",@"获取类的实例方法和类方法",@"获取单例方法",@"错误处理跳转h5",@"错误处理自己处理",@"打电话",@"打开邮箱"]  WithCellShow:^UITableViewCell *(id model, NSIndexPath *indexPath) {
        

        WMZRouterURL *URL = RouterURL().target(@"getNornalCell");
        WMZRouterParam *param = RouterParam().CellTable(weakSelf.table).log(@"日志");
        UITableViewCell *cell = [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
        if (model) {
            [cell setValue:model forKey:@"model"];
        }
        return cell;
    }  Handle:^(id anyID) {
        [weakSelf doClick:anyID];
    }];
    
}


- (void)doClick:(NSString*)name{
    WMZRouter *route = [WMZRouter shareInstance];
    if ([name isEqualToString:@"跳转外部网页"]) {
        WMZRouterURL *URL =  RouterURL().openURL(@"http://www.cocoachina.com/ios/20170301/18811.html");
        [route handleWithURL:URL WithParam: RouterParam().openURL()];
        
    }else if ([name isEqualToString:@"跳转内部网页"]) {
        
        id URL = RouterURL().target(@"getWebVC");
        id param =  RouterParam().selfParam(@{
                                      @"URL":[NSURL URLWithString:@"http://www.cocoachina.com/ios/20170301/18811.html"],
                                      @"btnShow":@(YES)
                                      }).enterVCStyle(RouterPushHideTabBackShow);
        [route handleWithURL:URL WithParam:param];
        
    }else if ([name isEqualToString:@"打电话"]) {
        WMZRouterURL *URL =  RouterURL().openURL(@"tel://131232312323");
        [route handleWithURL:URL WithParam:RouterParam().openURL()];
    }else if ([name isEqualToString:@"打开邮箱"]) {
        id URL =  RouterURL().openURL(@"mailto://admin@hzlzh.com");
        [route handleWithURL:URL WithParam:RouterParam().openURL()];
        
    }else if ([name isEqualToString:@"获取headView"]) {
        
        //通过方法获取View
        NSString *keyName = [NSString stringWithFormat:@"%@_%@",UserName,WMZObjectGet(UserPhone)];
        NSString *keyMarry = [NSString stringWithFormat:@"%@_%@",UserMarry,WMZObjectGet(UserPhone)];
        
        id URL = RouterURL().target(@"getView").actions(@"getHeadViewWithParma");
        id param =  RouterParam().permissions(PermissionTypePhoto, ^(id anyID, BOOL success) {
            NSLog(@"权限");
        }).log(@"日志").selfParam(@{
                                              @"name":WMZObjectGet(keyName),
                                              @"detail":WMZObjectGet(keyMarry)
                                              });
        
        UIView *headView =  [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
        NSLog(@"%@",headView);
        [self.table setTableHeaderView:headView];
    }else if ([name isEqualToString:@"获取Model"]) {
        
        id URL = RouterURL().target(@"getWMZModel");
        id param =  RouterParam().selfParam(@{
                                              @"name":@"WMZ",
                                              @"age":@(20),
                                              @"other":@"其他"
                                              });
        
        id model = [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        ;
        
        
        
        [[WMZAlert shareInstance] showAlertWithType:AlertTypeNornal textTitle:[NSString stringWithFormat:@"%@",[model valueForKey:@"name"]]];
    }else if ([name isEqualToString:@"跳转其他APP"]) {
        
        //要跳转的app需要先注册
        id URL = RouterURL().target(@"com.WMZAlert://");
        [route handleWithURL:URL WithParam:RouterParam().openURL()];
        
    }else if ([name isEqualToString:@"获取类的实例方法和类方法"]) {
        
        id URL = RouterURL().target(@"checkTool");
        id param =  RouterParam().selfParam(@{
                                              @"phone":@"1111",
                                              @"passWord":@"22222"
                                              });
        
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];

    }else if ([name isEqualToString:@"带block"]) {
        
        id URL = RouterURL().target(@"getNornalCell11");
        id param =  RouterParam().error(RouterUpdate).enterVCStyle(RouterRoot);
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param WithHandBlock:^(id anyID, BOOL success) {
                                                                                      NSLog(@"block值 确定 %@",anyID);
                                                                                    }];
    }else if([name isEqualToString:@"获取单例方法"]){
        
        id URL = RouterURL().Singletarget_Actions(@"shareVC",@"shareInstance",@"shareAction2");
        id param =  RouterParam().selfParam(@{
                                            @"key":@"2222",
                                            @"name":@"wmz3"
                                            });
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
    }else if([name isEqualToString:@"错误处理跳转h5"]){
        
        id URL = RouterURL().target(@"shareVC").action(@"错误方法");
        id param = RouterParam().error(RouterPushH5);
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
    }else if ([name isEqualToString:@"网络请求测试成功(等待请求完回调)"]) {
        //netWork 传值不能为空
        
        id URL = RouterURL().target(@"netWorkTest").actions(@"netWorkSuccessTestWithSuccessWithParm");
        id param =  RouterParam().netWork(@"");
        
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param WithHandBlock:^(id anyID, BOOL success) {
            [[WMZAlert shareInstance] showAlertWithType:AlertTypeNornal textTitle:anyID];
        }];
    }
    else if ([name isEqualToString:@"网络请求测试失败"]) {
        //netWork 传值不能为空
        
        id URL = RouterURL().target(@"netWorkTest").actions(@"netWorkFailTestWithSuccessWithParm");
        id param =  RouterParam().netWork(@"");
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param WithHandBlock:^(id anyID, BOOL success) {
            [[WMZAlert shareInstance] showAlertWithType:AlertTypeNornal textTitle:anyID];
        }];
    }else if([name isEqualToString:@"错误处理自己处理"]){
        
        id URL = RouterURL().target(@"shareVC").action(@"错误方法");
        id param =  RouterParam().dealSelfError(^(id anyID) {
            NSLog(@"获取到的 ：%@",anyID);
        });
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
    }
}


@end
