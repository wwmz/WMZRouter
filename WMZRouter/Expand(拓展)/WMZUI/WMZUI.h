//
//  WMZUI.h
//  WMZ娱乐
//
//  Created by wumingzhou on 2016/12/7.
//  Copyright © 2016年 广州涌智信息科技有限公司. All rights reserved.
//
#import <UIKit/UIKit.h>

#define WMZCheckStrNill(str)   str&&(![str isKindOfClass:[NSNull class]])?str:@" "
#define WMZBoolNill(anyObject) [WMZUI checkNil:anyObject]
#define WMZColor(color)        [WMZUI stringTOColor:color]

//数据本地存取
#define WMZObjectSave(A,B)    [WMZUI userSaveObject:A forKey:B];
#define WMZBoolSave(A,B)      [WMZUI userSaveBool:A forKey:B];
#define WMZIntegerSave(A,B)   [WMZUI userSaveInteger:A forKey:B];
#define WMZFloatSave(A,B)     [WMZUI userSaveFloat:A forKey:B];
#define WMZDoubleSave(A,B)    [WMZUI userSaveDoublue:A forKey:B];

#define WMZObjectGet(A)       [WMZUI userGetObjectForKey:A]
#define WMZObjectGetNull(A)   [WMZUI userGetNullObjectForKey:A]
#define WMZBoolGet(A)         [WMZUI userGetBoolForKey:A]
#define WMZIntegerGet(A)      [WMZUI userGetIntegerForKey:A]
#define WMZFloatGet(A)        [WMZUI userGetFloatForKey:A]
#define WMZDoubleGet(A)       [WMZUI userGetDoublueForKey:A]

//插入数组数据
#define WMZArr(A,B)           [WMZUI InsertArr:A withObject:B];
//插入字典数据
#define WMZDic(A,B,C)         [WMZUI InsertDic:A withObject:B withKey:C];

#define WMZWeakSelf            __weak typeof(self) weakSelf = self;

typedef void (^WMZClickBlock) (id tapID);
typedef void (^WMZConstraint) (MASConstraintMaker *make);
@interface WMZUI : NSObject

+ (instancetype)shareInstance;

#pragma -mark UILabel
#pragma -mark UILabel常用全部属性
+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
            WithNumOfLine:(NSInteger)numline
            WithBackColor:(UIColor*)backColor
        WithTextAlignment:(NSTextAlignment)TextAlignment
                 WithFont:(CGFloat)Font;

#pragma -mark new UILabel常用全部属性
+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
                    Line:(NSInteger)numline
               BackColor:(UIColor*)backColor
               Alignment:(NSTextAlignment)textAlignment
                    Font:(CGFloat)font
               SuperView:(id)view
              Constraint:(WMZConstraint)make;

#pragma -mark 文本内容跟文本颜色
+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor;

+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
               SuperView:(id)view
              Constraint:(WMZConstraint)make;

#pragma -mark UILabel文本内容跟背景色
+ (UILabel*)labelWithText:(NSString*)text
            WithBackColor:(UIColor*)backColor;

#pragma -mark UILabel文本内容跟文本颜色和字体大小
+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
                 WithFont:(CGFloat)Font;

+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
                    Font:(CGFloat)font
               SuperView:(id)view
              Constraint:(WMZConstraint)make;




#pragma -mark UIButton
+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*)color
               WithBackColor:(UIColor*)backColor
               WithBackImage:(UIImage*)backImage
                   WithImage:(UIImage*)Image
                    WithFont:(CGFloat)font
                  WithTarget:(id)target
                  WithAction:(NSString*)action;


#pragma -mark UIButton
+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*)color
               WithBackColor:(UIColor*)backColor
                    WithFont:(CGFloat)font;

+ (UIButton*)newButtonTitie:(NSString*)title
                  TextColor:(UIColor*)color
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make;

+ (UIButton*)newButtonTitie:(NSString*)title
                NornalImage:(NSString*)nornalImage
                SelectImage:(NSString*)selectImage
                      radio:(CGFloat)radio
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make;

+ (UIButton*)newButtonTitie:(NSString*)title
                  TextColor:(UIColor*)color
                  BackColor:(UIColor*)backColor
                   WithFont:(CGFloat)font
                      radio:(CGFloat)radio
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make;

#pragma -mark UIButton addtagat
+(void)ButtonWithButton:(UIButton*)btn
               Selector:(NSString *)selector
              andTraget:(id)traget;


#pragma -mark UIimagView
+ (UIImageView*)imageViewWithModel:(NSString*)imageModel
                         WithImage:(UIImage*)image
                           WithUrl:(BOOL)url;

+ (UIImageView*)imageViewWithName:(NSString*)imageModel
                      WithSubView:(id)view;

+ (UIImageView*)newImageViewWithName:(NSString*)name
                        WithSubView:(id)view
                              target:(id)target
                              action:(SEL)action
                         Constraint:(WMZConstraint)make
                               Fill:(BOOL)fill;

+ (UIImageView*)newImageViewWithName:(NSString*)name
                         WithSubView:(id)view
                          Constraint:(WMZConstraint)make;

#pragma -mark UIView
+ (UIView*)newViewWithBackColor:(UIColor*)color
                    WithSubView:(id)view
                     Constraint:(WMZConstraint)make;


+ (UIView*)newViewWithBackColor:(UIColor*)color
                    WithSubView:(id)view
                         target:(id)target
                         action:(SEL)action
                     Constraint:(WMZConstraint)make;

+ (void)newViewAddTargetWithView:(UIView*)view
                          target:(id)target
                          action:(SEL)action;


#pragma -mark UIView
+ (UIView*)viewWithBackColor:(UIColor*)color;


#pragma -mark UITextField
+ (UITextField*)textFieldWithtext:(NSString*)text
                    WithTextColor:(UIColor*)textColor
                         WithFont:(CGFloat)font
                WithTextAlignment:(NSTextAlignment)textAlignment
                  WithPlaceholder:(NSString*)placeholder
                      WithKeyWord:(UIKeyboardType)keyboardType
                     WithDelegate:(id)delegate;

+ (UITextField*)newTextFieldTextColor:(UIColor*)textColor
                                 Font:(CGFloat)font
                        TextAlignment:(NSTextAlignment)textAlignment
                          Placeholder:(NSString*)placeholder
                              KeyWord:(UIKeyboardType)keyboardType
                          WithSubView:(id)view
                           Constraint:(WMZConstraint)make;

#pragma -mark UITextView
+ (UITextView*)textViewWithtext:(NSString *)text
                  WithTextColor:(UIColor *)textColor
                  WithBackColor:(UIColor *)backColor
                       WithFont:(CGFloat)font
              WithTextAlignment:(NSTextAlignment)textAlignment
                    WithKeyWord:(UIKeyboardType)keyboardType
                    WithCanEdit:(BOOL)edit
                   WithDelegate:(id)delegate;

+ (UITextView*)newTextViewTextColor:(UIColor *)textColor
                           WithFont:(CGFloat)font
                      TextAlignment:(NSTextAlignment)textAlignment
                            KeyWord:(UIKeyboardType)keyboardType
                            SubView:(id)view
                         Constraint:(WMZConstraint)make;



#pragma -mark UIScrollView
+ (UIScrollView*)ScrollViewWithBackColor:(UIColor *)backColor
             scrollViewWithContentOffset:(CGPoint)point
                         WithContentSize:(CGSize)size
                        CanPagingEnabled:(BOOL)page
                        CanScrollEnabled:(BOOL)scroll
          showsHorizontalScrollIndicator:(BOOL)Horizontal
            showsVerticalScrollIndicator:(BOOL)Vertical
                            WithDelegate:(id)delegate;

+ (UIScrollView*)ScrollViewWithBackColor:(UIColor *)backColor
                         WithContentSize:(CGSize)size
                        CanPagingEnabled:(BOOL)page
          showsHorizontalScrollIndicator:(BOOL)Horizontal
            showsVerticalScrollIndicator:(BOOL)Vertical
                             WithSubView:(id)view
                              Constraint:(WMZConstraint)make;



//返回文本的size 根据文本的width
+ (CGSize)returnSizeWithLabel:(UILabel*)label;

//返回按钮的size
+ (CGSize)returnSizeWithBtn:(UIButton*)btn;

//获取当前VC
+ (UIViewController *)getCurrentVC;

//字符串null情况
+(NSString*)nullStr:(NSString*)str;

//金钱处理 保留两位不四舍五入
+ (NSString*)changeWithMoney:(NSString*)money withMultiple:(NSInteger)multiple;

//虚线绘制
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView;

//拨打电话
+ (void)callAction:(UIViewController*)vc withTellArr:(NSArray*)tellArr;

//根据时间戳判断离现在多久
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime;

//处理字典数值为空崩溃情况
+(NSString*)setDicWithValue:(NSString*)value;

//设置右边按钮
+(UIButton*)setRightViewWithTextField:(UITextField *)textField idView:(UIView*)view imageName:(NSString *)imageName;

//颜色
+ (UIColor *)stringTOColor:(NSString *)str;

//检测是否为空
+ (BOOL)checkNil:(id)data;

//本地存储
+ (void)userSaveObject:(id)data forKey:(NSString*)key;

+ (void)userSaveBool:(BOOL)value forKey:(NSString*)key;

+ (void)userSaveInteger:(NSInteger)value forKey:(NSString*)key;

+ (void)userSaveFloat:(float)value forKey:(NSString*)key;

+ (void)userSaveDoublue:(double)value forKey:(NSString*)key;

+ (id)userGetObjectForKey:(NSString*)key;

+ (id)userGetNullObjectForKey:(NSString*)key;

+ (BOOL)userGetBoolForKey:(NSString*)key;

+ (NSInteger)userGetIntegerForKey:(NSString*)key;

+ (CGFloat)userGetFloatForKey:(NSString*)key;

+ (double)userGetDoublueForKey:(NSString*)key;

//添加数组数据
+ (BOOL)InsertArr:(id)arr withObject:(id)object;

//添加数组数据
+ (BOOL)InsertDic:(id)dic withObject:(id)object withKey:(NSString*)key;

@end
