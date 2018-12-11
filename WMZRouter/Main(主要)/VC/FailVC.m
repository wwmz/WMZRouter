//
//  FailVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/16.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "FailVC.h"

@interface FailVC ()

@end

@implementation FailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [WMZUI newLabelText:@"失败提示页面" TextColor:[UIColor redColor] SuperView:self.view Constraint:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
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
