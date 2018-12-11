


//
//  NewsVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC ()
@property(nonatomic,strong)WMZTableView *table;
@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    WMZWeakSelf
    self.table = [[WMZTableView sharePlain] addTableViewWithType:0 withConstraint:^(MASConstraintMaker *make) {
        make.left.top.bottom.right.mas_equalTo(0);
    } withSuperView:self.view withData:[self getData:@{@"count":@(200)}] WithCellShow:^UITableViewCell *(id model, NSIndexPath *indexPath) {

        WMZRouterURL *URL = RouterURL().target(@"getNewCell");
        WMZRouterParam *param = RouterParam().CellTable(weakSelf.table);
        UITableViewCell *cell = [[WMZRouter shareInstance] handleWithURL:URL WithParam:param];
        
        //KVO赋值
        if (model) {
            [cell setValue:model forKey:@"model"];
        }
        return cell;
    }  Handle:^(id anyID) {
        NSString *ID = [anyID valueForKey:@"ID"];
        [[WMZRouter shareInstance] handleWithURL:@"getWebVC" WithParam: RouterParam().enterVCStyle(RouterPushHideTabBackShow).selfParam(@{
                                                                                                                                          @"URL":[NSURL URLWithString:ID],
                                                                                                                                          @"btnShow":@(NO)
                                                                                                                                          })];
       
    }];
 

    
}

- (NSArray*)getData:(NSDictionary*)parm{
    NSNumber *count = parm[@"count"];
    NSMutableArray *modelArr = [NSMutableArray new];
    for (int i = 0; i<count.integerValue; i++) {
        id model =   [[WMZRouter shareInstance] handleWithURL:@"getNewsModel" WithParam:RouterParam().selfParam(@{
                                                                                                                  @"ID":@"http://www.cocoachina.com/ios/20170301/18811.html",
                                                                                                                  @"title":[NSString stringWithFormat:@"路由组件化链接%d",i],
                                                                                                                  @"text":[NSString stringWithFormat:@"路由组件化链接%d内容\n路由组件化链接%d",i,i],
                                                                                                                  @"icon":@"0.jpg",
                                                                                                                  @"time":[NSString stringWithFormat:@"%d分钟前",i+1]
                                                                                                                  })];
        if (model) {
            [modelArr addObject:model];
        }
    }
    
    return [NSArray arrayWithArray:modelArr];
 
}

@end
