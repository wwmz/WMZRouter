//
//  WMZCheckNumTool.h
//  WMZRouter
//
//  Created by wmz on 2018/11/9.
//  Copyright © 2018年 wmz. All rights reserved.
//
#import "BaseObject.h"
@interface WMZCheckNumTool : BaseObject 

//检测登录输入的手机号和密码格式
- (BOOL)checkLoginPhoneAndPassWordWithParam:(NSDictionary*)parma;

//检测注册输入的手机号和密码格式
- (BOOL)checkReginPhoneAndPassWordWithParam:(NSDictionary*)parma;

//检测个人信息
- (BOOL)checkInfomation;

//测试类方法
+ (NSString*)leiAction:(NSDictionary*)parma;

@end

