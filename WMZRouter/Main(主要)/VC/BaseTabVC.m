
//
//  BaseTabVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "BaseTabVC.h"

@interface BaseTabVC ()

@end

@implementation BaseTabVC

- (void)viewDidLoad {
    [super viewDidLoad];

    NSArray *VCArr = @[
                       @{
                           @"VCName":@"getHomeVC",
                           @"fonName":@"HeiTi SC",
                           @"font":@(13.0f),
                           @"name":@"HomeVC",
                           @"selectColor": [UIColor redColor],
                           @"unselectColor": [UIColor blackColor]
                       },
                       @{
                           @"VCName":@"getNewsVC",
                           @"fonName":@"HeiTi SC",
                           @"font":@(130.f),
                           @"name":@"NewsVC",
                           @"selectColor": [UIColor redColor],
                           @"unselectColor": [UIColor blackColor]
                           },
                       @{
                           @"VCName":@"getMineVC",
                           @"fonName":@"HeiTi SC",
                           @"font":@(13.0f),
                           @"name":@"MineVC",
                           @"selectColor": [UIColor redColor],
                           @"unselectColor": [UIColor blackColor]
                           }
                       ];
    
    // Do any additional setup after loading the view.
    NSMutableArray *naArr = [NSMutableArray new];
    for (NSDictionary *dic  in VCArr) {
        //获取VC
        UIViewController *VC = [[WMZRouter shareInstance] handleWithURL:dic[@"VCName"] WithParam:@{}];
        UINavigationController *naVC = [[UINavigationController alloc]initWithRootViewController:VC];
        
        [self setTabBarItem:naVC.tabBarItem
                      title:dic[@"name"]
                  titleSize:[dic[@"font"] floatValue]
              titleFontName:dic[@"fonName"]
              selectedImage:nil
         selectedTitleColor:dic[@"selectColor"]
                normalImage:nil
           normalTitleColor:dic[@"unselectColor"]];
        [naArr addObject:naVC];
    }

    
    self.viewControllers = [NSArray arrayWithArray:naArr];
}

- (void)setTabBarItem:(UITabBarItem *)tabbarItem
                title:(NSString *)title
            titleSize:(CGFloat)size
        titleFontName:(NSString *)fontName
        selectedImage:(NSString *)selectedImage
   selectedTitleColor:(UIColor *)selectColor
          normalImage:(NSString *)unselectedImage
     normalTitleColor:(UIColor *)unselectColor
{
    tabbarItem.title = title;
    tabbarItem.image = [[UIImage imageNamed:unselectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabbarItem.selectedImage = [[UIImage imageNamed:selectedImage]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // S未选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:unselectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateNormal];

    // 选中字体颜色
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:selectColor,NSFontAttributeName:[UIFont fontWithName:fontName size:size]} forState:UIControlStateSelected];
}

+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
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
