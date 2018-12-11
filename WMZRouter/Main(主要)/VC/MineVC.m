


//
//  MineVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "MineVC.h"

@interface MineVC ()
@property(nonatomic,strong)WMZTableView *table;
@end

@implementation MineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    WMZWeakSelf
    
    UIButton *cancelBtn =  [WMZUI newButtonTitie:@"退出登录" TextColor:[UIColor whiteColor] BackColor:[UIColor orangeColor] WithFont:15 radio:10 SuperView:nil target:self action:@selector(cancelAction) Constraint:nil];
    cancelBtn.frame = CGRectMake(30, 20, [UIScreen mainScreen].bounds.size.width-60, 50);
    
    self.table = [[WMZTableView shareGrouped] addTableViewWithType:CellTypeNornal withConstraint:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    } withSuperView:self.view withData:@[@"修改资料"] withSection:1 withCellName:nil WithCellShow:^UITableViewCell *(id model, NSIndexPath *indexPath) {
        WMZRouterURL *URL = RouterURL().target(@"getNornalCell");
        WMZRouterParam *param = RouterParam().CellTable(weakSelf.table);
        UITableViewCell *cell = [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        //KVO赋值
        [cell setValue:model forKey:@"model"];
        return cell;
    } WithCellCount:nil WithCellHeight:nil WithHeadHeight:^NSInteger(NSInteger section) {
        return 120;
    } WithFootHeight:^NSInteger(NSInteger section) {
        return 90;
    } WithHeadView:^UIView *(NSInteger section) {
        
        
        NSString *keyName = [NSString stringWithFormat:@"%@_%@",UserName,WMZObjectGet(UserPhone)];
        NSString *keyAge = [NSString stringWithFormat:@"%@_%@",UserAge,WMZObjectGet(UserPhone)];
        
        id URL = RouterURL().target(@"getView").actions(@"getHeadViewWithParma");
        id param = RouterParam().permissions(PermissionTypePhoto, ^(id anyID, BOOL success) {
            NSLog(@"权限");
        }).log(@"日志").selfParam(@{@"name":WMZObjectGet(keyName),
                                  @"detail":[NSString stringWithFormat:@"年龄:%@",WMZObjectGet(keyAge)]
                                  });
        
        return  [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
    } WithFootView:^UIView *(NSInteger section) {
        UIView *view = [UIView new];
        view.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 90);
        [view addSubview:cancelBtn];
        return view;
    } Handle:^(id anyID) {
         [weakSelf doClick:anyID];
    }];
    
}

- (void)cancelAction{
    id URL = RouterURL().target(@"getLoginVC");
    id param =  RouterParam().enterVCStyle(RouterRootNa);
    [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
}

- (void)doClick:(NSString*)name{
    if (([name isEqualToString:@"修改资料"])){
        id URL = RouterURL().target(@"getPersonVC");
        id param =  RouterParam().enterVCStyle(RouterPushHideTabBackShow);
        [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
