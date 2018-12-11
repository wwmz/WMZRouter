
//
//  WebVC.m
//  WMZRouter
//
//  Created by wmz on 2018/11/9.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WebVC.h"

@interface WebVC ()
@property (nonatomic, strong) UIWebView *webView;
@end
@implementation WebVC
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:self.URL]];
//    [WMZUI newButtonTitie:@"点击" TextColor:[UIColor whiteColor] BackColor:[UIColor redColor] WithFont:15 radio:5 SuperView:self.view target:self action:@selector(dissAction) Constraint:^(MASConstraintMaker *make) {
//        make.width.height.mas_equalTo(60);
//        make.top.mas_equalTo(70);
//        make.right.mas_equalTo(-20);
//    }];
   
}

- (void)dissAction{
    if (self.btnShow) {
        self.webView = nil;
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [[WMZRouter shareInstance] handleWithURL:RouterURL().target(@"getBaseVC") WithParam:RouterParam().enterVCStyle(RouterPushHideTab)];
    }
}

- (UIWebView *)webView{
    if (!_webView) {
        _webView = [[UIWebView alloc] init];
        [self.view addSubview:_webView];
        _webView.frame = self.view.bounds;
    }
    return _webView;
}


@end
