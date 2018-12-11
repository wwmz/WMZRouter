//
//  WMZAlert.h
//  WMZAlert
//
//  Created by wmz on 2018/10/9.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NavClickBlock)(id anyID);

typedef enum : NSUInteger{
    AlertTypeNornal,               //默认弹窗
    AlertTypeAuto,                 //默认弹窗自动消失
    AlertTypeSystemPush,           //系统弹窗
    AlertTypeSystemSheet,          //系统底部弹窗
    AlertTypePay,                  //支付密码框
    AlertTypeToast,                //顶部显示弹窗
    AlertTypeWrite,                //带编辑框的弹窗
    AlertTypeTime,                 //带倒计时的弹窗
    AlertTypeSelect,               //带选择的弹窗
    AlertTypeShare                 //带分享的弹窗
}AlertType;

@interface WMZAlert : UIViewController

/*
 * 初始化
 */
+ (instancetype)shareInstance;

/*
 * 简单化弹窗没有回调
 *
 * @param  AlertType 弹窗类型
 * @param  text      显示内容
 *
 */
- (void)showAlertWithType:(AlertType)type
                textTitle:(id)text;

/*
 * 简单化弹窗带回调
 *
 * @param  AlertType  弹窗类型
 * @param  title      标题内容
 * @param  text       显示内容
 * @param  leftBlock  取消按钮点击回调
 * @param  rightBlock 确定按钮点击回调
 *
 */
- (void)showAlertWithType:(AlertType)type
                headTitle:(NSString*)title
                textTitle:(id)text
               leftHandle:(NavClickBlock)leftBlock
              rightHandle:(NavClickBlock)rightBlock;

/*
 * 最全面弹窗可以设置按钮颜色等
 *
 * @param  AlertType    弹窗类型
 * @param  VC           显示的VC
 * @param  leftText     取消按钮文字内容
 * @param  rightText    确定按钮文字内容
 * @param  title        标题内容
 * @param  text         显示内容
 * @param  titleColor   标题内容颜色
 * @param  textColor    显示内容颜色
 * @param  backColor    背景颜色
 * @param  okColor      确定按钮文字颜色
 * @param  cancelColor  取消按钮文字颜色
 * @param  leftBlock    取消按钮点击回调
 * @param  rightBlock   确定按钮点击回调
 *
 */
-  (void)showAlertWithType:(AlertType)type
                   sueprVC:(UIViewController*)VC
                 leftTitle:(NSString*)leftText
                rightTitle:(NSString*)rightText
                 headTitle:(NSString*)title
                 textTitle:(id)text
            headTitleColor:(UIColor*)titleColor
            textTitleColor:(UIColor*)textColor
                 backColor:(UIColor*)backColor
                okBtnColor:(UIColor*)okColor
            cancelBtnColor:(UIColor*)cancelColor
                leftHandle:(NavClickBlock)leftBlock
               rightHandle:(NavClickBlock)rightBlock;
@end

