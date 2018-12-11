//
//  WMZCheckNumTool.m
//  WMZRouter
//
//  Created by wmz on 2018/11/9.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "WMZCheckNumTool.h"

@implementation WMZCheckNumTool
- (BOOL)checkReginPhoneAndPassWordWithParam:(NSDictionary*)parma{
    NSString *phone = parma[@"phone"];
    NSString *passWord = parma[@"passWord"];
    BOOL result = NO;
    NSString *errorStr = nil;
    if (phone&&phone.length>=5&&passWord&&passWord.length>=3) {
        NSDictionary *dic = WMZObjectGetNull(UserAccounts);
        
        result = YES;
        if (dic) {
            
            if (dic[phone]) {
                errorStr = @"该手机已经注册过了";
                result = NO;
            }else{
                dic = [NSMutableDictionary dictionaryWithDictionary:dic];
                WMZDic(dic, passWord, phone);
                WMZObjectSave(dic, UserAccounts);
                WMZObjectSave(phone, UserPhone);
            }
        }else{
            NSMutableDictionary *mdic = [NSMutableDictionary new];
            WMZDic(mdic, passWord, phone);
            WMZObjectSave(mdic, UserAccounts);
            WMZObjectSave(phone, UserPhone);
            
        }
        
    }else{
        errorStr = @"账号或密码不符合规范";
    }
    if (errorStr) {
        [[WMZAlert shareInstance] showAlertWithType:AlertTypeAuto textTitle:errorStr];
    }
    return result;
    
}

- (BOOL)checkLoginPhoneAndPassWordWithParam:(NSDictionary*)parma{
    
    NSString *phone = parma[@"phone"];
    NSString *passWord = parma[@"passWord"];
    BOOL result = NO;
    NSString *errorStr = nil;
    if (phone&&phone.length>=5&&passWord&&passWord.length>=3) {
        NSDictionary *dic = WMZObjectGetNull(UserAccounts);
        if (dic) {
            if (dic[phone]) {
                result = YES;
                WMZObjectSave(phone, UserPhone);
            }else{
                errorStr = @"该账号尚未注册";
            }
        }else{
            errorStr = @"该账号尚未注册";
        }
    }else{
        errorStr = @"账号或密码不符合规范";
    }
    if (errorStr) {
         [[WMZAlert shareInstance] showAlertWithType:AlertTypeAuto textTitle:errorStr];
    }
    return result;
}

- (BOOL)checkInfomation{
    NSString *keyName = [NSString stringWithFormat:@"%@_%@",UserName,WMZObjectGet(UserPhone)];
    NSString *keyAge = [NSString stringWithFormat:@"%@_%@",UserAge,WMZObjectGet(UserPhone)];
    NSString *keyMarry = [NSString stringWithFormat:@"%@_%@",UserMarry,WMZObjectGet(UserPhone)];
    if (WMZObjectGetNull(keyName)&&WMZObjectGetNull(keyAge)&&WMZObjectGetNull(keyMarry)) {
        return YES;
    }else{
        return NO;
    }
}

+ (NSString *)routerPath{
    return @"checkTool";
}

//测试类方法
+ (NSString*)leiAction:(NSDictionary*)parma{
    NSLog(@"类方法%@",parma);
    return @"111";
}

@end
