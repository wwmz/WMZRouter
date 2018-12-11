//
//  BaseVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/8.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseVC.h"

@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setTitle:NSStringFromClass([self class])];
     self.view.backgroundColor = [UIColor whiteColor];
}


+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
}


- (void)dealloc{
    
}

@end
