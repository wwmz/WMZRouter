//
//  WMZUI.m
//  WMZ娱乐
//
//  Created by wumingzhou on 2016/12/7.
//  Copyright © 2016年 广州涌智信息科技有限公司. All rights reserved.
//

#import "WMZUI.h"
@interface WMZUI()<UITextViewDelegate,UITextFieldDelegate,UIScrollViewDelegate>
@property (nonatomic, copy)  WMZClickBlock ButtonClickHandle;
@end
@implementation WMZUI

+ (instancetype)shareInstance{
    return [[self alloc]init];
}

+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
            WithNumOfLine:(NSInteger)numline
            WithBackColor:(UIColor*)backColor
        WithTextAlignment:(NSTextAlignment)TextAlignment
                 WithFont:(CGFloat)Font
{
    UILabel *WMZLabel = [UILabel new];
    if (text) {
        WMZLabel.text = text;
    }
    if (numline!=1) {
        WMZLabel.numberOfLines = numline;
    }
    if (Font!=0) {
        WMZLabel.font = [UIFont systemFontOfSize:Font];
    }
    if (textColor) {
        WMZLabel.textColor = textColor;
    }
    if (backColor) {
        WMZLabel.backgroundColor = backColor;
    }
    WMZLabel.textAlignment = TextAlignment;
    return WMZLabel;
}


+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
                    Line:(NSInteger)numline
               BackColor:(UIColor*)backColor
               Alignment:(NSTextAlignment)textAlignment
                    Font:(CGFloat)font
               SuperView:(id)view
              Constraint:(WMZConstraint)make{
    UILabel *WMZLabel = [UILabel new];
    if (view) {
        [view addSubview:WMZLabel];
        if (make) {
            [WMZLabel mas_makeConstraints:make];
        }
    }
    if (text) {
        WMZLabel.text = text;
    }
    if (numline!=1) {
        WMZLabel.numberOfLines = numline;
    }
    if (font!=0) {
        WMZLabel.font = [UIFont systemFontOfSize:font];
    }
    if (textColor) {
        WMZLabel.textColor = textColor;
    }
    if (backColor) {
        WMZLabel.backgroundColor = backColor;
    }
    WMZLabel.textAlignment = textAlignment;
    return WMZLabel;
}

+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
{
    return [self labelWithText:text WithTextColor:textColor WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:0];
}

+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
               SuperView:(id)view
              Constraint:(WMZConstraint)make{
    return [self newLabelText:text TextColor:textColor Line:1 BackColor:nil Alignment:NSTextAlignmentLeft Font:0 SuperView:view Constraint:make];
}

+ (UILabel*)labelWithText:(NSString*)text
            WithBackColor:(UIColor*)backColor
{
    return [self labelWithText:text WithTextColor:nil WithNumOfLine:1 WithBackColor:backColor WithTextAlignment:NSTextAlignmentLeft WithFont:0];
}


+ (UILabel*)labelWithText:(NSString*)text
            WithTextColor:(UIColor*)textColor
                 WithFont:(CGFloat)Font
{
    return [self labelWithText:text WithTextColor:textColor WithNumOfLine:1 WithBackColor:nil WithTextAlignment:NSTextAlignmentLeft WithFont:Font];
}

+ (UILabel*)newLabelText:(NSString*)text
               TextColor:(UIColor*)textColor
                    Font:(CGFloat)font
               SuperView:(id)view
              Constraint:(WMZConstraint)make{
     return [self newLabelText:text TextColor:textColor Line:1 BackColor:nil Alignment:NSTextAlignmentLeft Font:font SuperView:view Constraint:make];
}

+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*)color
               WithBackColor:(UIColor*)backColor
                    WithFont:(CGFloat)font{
    return [self buttonWithTitie:title WithtextColor:color WithBackColor:backColor WithBackImage:nil WithImage:nil WithFont:font WithTarget:nil WithAction:nil];
}

+ (UIButton*)buttonWithTitie:(NSString*)title
               WithtextColor:(UIColor*)color
               WithBackColor:(UIColor*)backColor
               WithBackImage:(UIImage*)backImage
                   WithImage:(UIImage*)Image
                    WithFont:(CGFloat)font
                  WithTarget:(id)target
                  WithAction:(NSString*)action
{
    UIButton* WMZBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (title) {
        [WMZBtn setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [WMZBtn setTitleColor:color forState:UIControlStateNormal];
    }
    if (Image) {
        [WMZBtn setImage:Image forState:UIControlStateNormal];
    }
    if (backColor) {
        WMZBtn.backgroundColor = backColor;
    }
    if (backImage) {
        [WMZBtn setBackgroundImage:backImage forState:UIControlStateNormal];
    }
    if (font!=0) {
        WMZBtn.titleLabel.font=[UIFont systemFontOfSize:font];
    }
    if (target&&action) {
        [WMZUI ButtonWithButton:WMZBtn Selector:action andTraget:target];
    }
    
    return WMZBtn;
    
}


+ (UIButton*)newButtonTitie:(NSString*)title
                  TextColor:(UIColor*)color
                  BackColor:(UIColor*)backColor
                   WithFont:(CGFloat)font
                      radio:(CGFloat)radio
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make{
    UIButton* WMZBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    if (view) {
        [view addSubview:WMZBtn];
        if (make) {
            [WMZBtn mas_makeConstraints:make];
        }
    }
    if (target&&action) {
        [WMZBtn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    if (title) {
        [WMZBtn setTitle:title forState:UIControlStateNormal];
    }
    if (color) {
        [WMZBtn setTitleColor:color forState:UIControlStateNormal];
    }

    if (backColor) {
        WMZBtn.backgroundColor = backColor;
    }
    if (font!=0) {
        WMZBtn.titleLabel.font=[UIFont systemFontOfSize:font];
    }
    if (radio!=0) {
        WMZBtn.layer.cornerRadius = radio;
        WMZBtn.layer.masksToBounds = YES;
    }
    
    return WMZBtn;
}

+ (UIButton*)newButtonTitie:(NSString*)title
                  TextColor:(UIColor*)color
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make{
    return  [WMZUI newButtonTitie:title TextColor:color BackColor:nil WithFont:0 radio:0 SuperView:view target:target action:action Constraint:make];
}

+ (UIButton*)newButtonTitie:(NSString*)title
                NornalImage:(NSString*)nornalImage
                SelectImage:(NSString*)selectImage
                      radio:(CGFloat)radio
                  SuperView:(id)view
                     target:(id)target
                     action:(SEL)action
                 Constraint:(WMZConstraint)make{
    UIButton *btn = [WMZUI newButtonTitie:title TextColor:nil BackColor:nil WithFont:0 radio:radio SuperView:view  target:target action:action Constraint:make];
    if (nornalImage) {
        [btn setImage:[UIImage imageNamed:nornalImage] forState:UIControlStateNormal];
    }
    if (selectImage) {
        [btn setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    }
    return btn;
}


+ (UIImageView*)imageViewWithName:(NSString*)imageModel
                      WithSubView:(id)view
{
    UIImageView *WMZImageView = [UIImageView new];
    WMZImageView.image = [UIImage imageNamed:imageModel];
    if (view) {
        [view addSubview:WMZImageView];
    }

    return WMZImageView;
}

+ (UIImageView*)imageViewWithModel:(NSString*)imageModel
                         WithImage:(UIImage*)image
                           WithUrl:(BOOL)url
{
    UIImageView *WMZImageView = [UIImageView new];
    if (image) {
        WMZImageView.image = image;
        return WMZImageView;
    }
    if (url) {
    }
    else
    {
        WMZImageView.image = [UIImage imageNamed:imageModel];
    }
    return WMZImageView;
}


+ (UIImageView*)newImageViewWithName:(NSString*)name
                         WithSubView:(id)view
                              target:(id)target
                              action:(SEL)action
                          Constraint:(WMZConstraint)make
                                Fill:(BOOL)fill{
    UIImageView *WMZImageView = [UIImageView new];
    if (name) {
        WMZImageView.image = [UIImage imageNamed:name];
    }
    if (target&&action) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        WMZImageView.userInteractionEnabled = YES;
        [WMZImageView addGestureRecognizer:tap];
    }
    if (view) {
        [view addSubview:WMZImageView];
        if (make) {
            [WMZImageView mas_makeConstraints:make];
        }
    }
    if (fill) {
        WMZImageView.contentMode = UIViewContentModeScaleAspectFill;
        WMZImageView.clipsToBounds = YES;
    }
    return WMZImageView;
}



+ (UIImageView*)newImageViewWithName:(NSString*)name
                         WithSubView:(id)view
                          Constraint:(WMZConstraint)make{
    UIImageView *WMZImageView = [UIImageView new];
    if (name) {
        WMZImageView.image = [UIImage imageNamed:name];
    }
    if (view) {
        [view addSubview:WMZImageView];
        if (make) {
            [WMZImageView mas_makeConstraints:make];
        }
    }
    return WMZImageView;
}




+ (UIView*)viewWithBackColor:(UIColor*)color
{
    UIView *WMZView = [UIView new];
    if (color) {
         WMZView.backgroundColor = color;
    }
    return WMZView;
}

+ (UIView*)newViewWithBackColor:(UIColor*)color
                    WithSubView:(id)view
                     Constraint:(WMZConstraint)make{
    UIView *WMZView = [UIView new];
    if (color) {
        WMZView.backgroundColor = color;
    }
    if (view) {
        [view addSubview:WMZView];
        if (make) {
            [WMZView mas_makeConstraints:make];
        }
    }
    return WMZView;
    
}

+ (UIView*)newViewWithBackColor:(UIColor*)color
                    WithSubView:(id)view
                         target:(id)target
                         action:(SEL)action
                     Constraint:(WMZConstraint)make{
    UIView *WMZView = [UIView new];
    if (target&&action) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        WMZView.userInteractionEnabled = YES;
        [WMZView addGestureRecognizer:tap];
    }
    if (color) {
        WMZView.backgroundColor = color;
    }
    if (view) {
        [view addSubview:WMZView];
        if (make) {
            [WMZView mas_makeConstraints:make];
        }
    }
    return WMZView;
}

+ (void)newViewAddTargetWithView:(UIView*)view
                          target:(id)target
                          action:(SEL)action{
    if (target&&action) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
        view.userInteractionEnabled = YES;
        [view addGestureRecognizer:tap];
    }
}

+(void)ButtonWithButton:(UIButton*)btn
               Selector:(NSString *)selector
              andTraget:(id)traget{
    const char *selector_c = [selector UTF8String];
    SEL registerSelector = sel_registerName(selector_c);
    [btn addTarget:traget action:registerSelector forControlEvents:UIControlEventTouchUpInside];
}


+ (UITextField*)textFieldWithtext:(NSString*)text
                    WithTextColor:(UIColor*)textColor
                         WithFont:(CGFloat)font
                WithTextAlignment:(NSTextAlignment)textAlignment
                  WithPlaceholder:(NSString*)placeholder
                      WithKeyWord:(UIKeyboardType)keyboardType
                     WithDelegate:(id)delegate
{
    UITextField *WMZtextField = [UITextField new];
    if (delegate) {
        WMZtextField.delegate = delegate;
    }
    if (text) {
        WMZtextField.text = text;
    }
    if (textColor) {
        WMZtextField.textColor = textColor;
    }
    if (font!=0) {
        WMZtextField.font = [UIFont systemFontOfSize:font];
    }
    if (textAlignment!=NSTextAlignmentLeft) {
        WMZtextField.textAlignment = textAlignment;
    }
    if (placeholder) {
        WMZtextField.placeholder = placeholder;
    }
    if (keyboardType!=0) {
        WMZtextField.keyboardType = keyboardType;
    }
    return WMZtextField;
    
}

+ (UITextField*)newTextFieldTextColor:(UIColor*)textColor
                                 Font:(CGFloat)font
                        TextAlignment:(NSTextAlignment)textAlignment
                          Placeholder:(NSString*)placeholder
                              KeyWord:(UIKeyboardType)keyboardType
                          WithSubView:(id)view
                           Constraint:(WMZConstraint)make{
    UITextField *WMZtextField = [WMZUI textFieldWithtext:nil WithTextColor:textColor WithFont:font WithTextAlignment:textAlignment WithPlaceholder:placeholder WithKeyWord:keyboardType WithDelegate:nil];
    if (view) {
        [view addSubview:WMZtextField];
        if (make) {
            [WMZtextField mas_makeConstraints:make];
        }
    }
    return WMZtextField;
}


+ (UITextView*)textViewWithtext:(NSString *)text
                  WithTextColor:(UIColor *)textColor
                  WithBackColor:(UIColor *)backColor
                       WithFont:(CGFloat)font
              WithTextAlignment:(NSTextAlignment)textAlignment
                    WithKeyWord:(UIKeyboardType)keyboardType
                    WithCanEdit:(BOOL)edit
                   WithDelegate:(id)delegate
{
    UITextView *WMZtextView = [UITextView new];
    if (delegate) {
        WMZtextView.delegate = delegate;
    }
    if (text) {
        WMZtextView.text = text;
    }
    if (textColor) {
        WMZtextView.textColor = textColor;
    }
    if (backColor) {
        WMZtextView.backgroundColor = backColor;
    }
    if (font!=0) {
        WMZtextView.font = [UIFont systemFontOfSize:font];
    }
    if (textAlignment!=NSTextAlignmentLeft) {
        WMZtextView.textAlignment = textAlignment;
    }
    if (keyboardType!=0) {
        WMZtextView.keyboardType = keyboardType;
    }
    if (!edit) {
        WMZtextView.editable = edit;
    }
    return WMZtextView;
    
}

+ (UITextView*)newTextViewTextColor:(UIColor *)textColor
                           WithFont:(CGFloat)font
                      TextAlignment:(NSTextAlignment)textAlignment
                            KeyWord:(UIKeyboardType)keyboardType
                            SubView:(id)view
                         Constraint:(WMZConstraint)make{
    UITextView *WMZtextView = [WMZUI textViewWithtext:nil WithTextColor:textColor WithBackColor:nil WithFont:font WithTextAlignment:textAlignment WithKeyWord:keyboardType WithCanEdit:YES WithDelegate:nil];
    if (view) {
        [view addSubview:WMZtextView];
        if (make) {
            [WMZtextView mas_makeConstraints:make];
        }
    }
    return WMZtextView;
}


+ (UIScrollView*)ScrollViewWithBackColor:(UIColor *)backColor
             scrollViewWithContentOffset:(CGPoint)point
                         WithContentSize:(CGSize)size
                        CanPagingEnabled:(BOOL)page
                        CanScrollEnabled:(BOOL)scroll
          showsHorizontalScrollIndicator:(BOOL)Horizontal
            showsVerticalScrollIndicator:(BOOL)Vertical
                            WithDelegate:(id)delegate
{
    UIScrollView *WMZScrollerView = [UIScrollView new];
    if (backColor) {
        WMZScrollerView.backgroundColor = backColor;
    }
    
    if (point.x!=0||point.y!=0) {
        WMZScrollerView.contentOffset = point;
    }
    if (size.width!=0||size.height!=0) {
        WMZScrollerView.contentSize = size;
    }
    if (delegate) {
        WMZScrollerView.delegate = delegate;
    }
    if (page) {
        WMZScrollerView.pagingEnabled = page;
    }
    if (!scroll) {
        WMZScrollerView.scrollEnabled = scroll;
    }
    if (!Vertical) {
        WMZScrollerView.showsVerticalScrollIndicator = Vertical;
    }
    if (!Horizontal) {
        
        WMZScrollerView.showsHorizontalScrollIndicator = Horizontal;
    }
    return WMZScrollerView;
}


+ (UIScrollView*)ScrollViewWithBackColor:(UIColor *)backColor
                         WithContentSize:(CGSize)size
                        CanPagingEnabled:(BOOL)page
          showsHorizontalScrollIndicator:(BOOL)Horizontal
            showsVerticalScrollIndicator:(BOOL)Vertical
                             WithSubView:(id)view
                              Constraint:(WMZConstraint)make{
    UIScrollView *WMZScrollerView = [WMZUI ScrollViewWithBackColor:backColor scrollViewWithContentOffset:CGPointMake(0, 0) WithContentSize:size CanPagingEnabled:page CanScrollEnabled:YES showsHorizontalScrollIndicator:Horizontal showsVerticalScrollIndicator:Vertical WithDelegate:nil];
    if (view) {
        [view addSubview:WMZScrollerView];
        if (make) {
            [WMZScrollerView mas_makeConstraints:make];
        }
    }
    return WMZScrollerView;
}

//返回文本的size
+ (CGSize)returnSizeWithID:(UILabel*)label{
    CGSize titleSize = [label.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return titleSize;
    
}

//返回文本的size 根据文本的width
+ (CGSize)returnSizeWithLabel:(UILabel*)label{
    CGSize titleSize = [label.text boundingRectWithSize:CGSizeMake(label.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil].size;
    return titleSize;
    
}


//返回按钮的size
+ (CGSize)returnSizeWithBtn:(UIButton*)btn{
    CGSize titleSize = [btn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, btn.frame.size.height) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName: btn.titleLabel.font} context:nil].size;
    return titleSize;
    
}

//获取当前VC
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    
    return currentVC;
}

+ (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC
{
    UIViewController *currentVC;
    
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        
        rootVC = [rootVC presentedViewController];
    }
    
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
        
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
        
    } else {
        // 根视图为非导航类
        
        currentVC = rootVC;
    }
    
    return currentVC;
}



//字符串null情况
+(NSString*)nullStr:(NSString*)str{
    //防止非NSString情况
    str = [NSString stringWithFormat:@"%@",str];
    return  [str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
}

//金钱处理 保留两位不四舍五入
+ (NSString*)changeWithMoney:(NSString*)money withMultiple:(NSInteger)multiple{
    
    double num = [money doubleValue]/multiple;
    NSString *x = [NSString stringWithFormat:@"¥%.3f",num];
    NSInteger loca = [x rangeOfString:@"."].location;
    if (loca+3<x.length&&loca>0) {
        return [x substringToIndex:loca+3];
    }
    return [NSString stringWithFormat:@"¥%.2f",num];
}

//虚线绘制
+(UIImage *)imageWithLineWithImageView:(UIImageView *)imageView{
    CGFloat width = imageView.frame.size.width;
    CGFloat height = imageView.frame.size.height;
    UIGraphicsBeginImageContext(imageView.frame.size);
    [imageView.image drawInRect:CGRectMake(0, 0, width, height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGFloat lengths[] = {5,5};
    CGContextRef line = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(line, [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0].CGColor);
    CGContextSetLineDash(line, 0, lengths, 1);
    CGContextMoveToPoint(line, 0, 1);
    CGContextAddLineToPoint(line, width-5, 1);
    CGContextStrokePath(line);
    return  UIGraphicsGetImageFromCurrentImageContext();
}

//拨打电话
+ (void)callAction:(UIViewController*)vc withTellArr:(NSArray*)tellArr{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"是否拨打联系电话？" message:nil preferredStyle: UIAlertControllerStyleActionSheet];
    
    for (int i = 0; i<tellArr.count; i++) {
        UIAlertAction *action = [UIAlertAction actionWithTitle:[NSString stringWithFormat:@"%@",tellArr[i]] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",tellArr[i]]]];
            
        }];
        [alert addAction:action];
    }
    
    
    
    UIAlertAction *actioncanel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
    }];
    
    [alert addAction:actioncanel];
    
    [vc presentViewController:alert animated:YES completion:nil];
}

//根据时间戳判断离现在多久
+ (NSString *)distanceTimeWithBeforeTime:(double)beTime
{
    if ([NSString stringWithFormat:@"%@", @(beTime)].length == 13) {
        
        beTime /= 1000.0f;
    }
    NSTimeInterval now = [[NSDate date]timeIntervalSince1970];
    
    double distanceTime = now - beTime;
    NSString * distanceStr;
    
    NSDate * beDate = [NSDate dateWithTimeIntervalSince1970:beTime];
    
    NSDateFormatter * df = [[NSDateFormatter alloc]init];
    [df setDateFormat:@"HH:mm"];
    NSString * timeStr = [df stringFromDate:beDate];
    
    [df setDateFormat:@"dd"];
    NSString * nowDay = [df stringFromDate:[NSDate date]];
    NSString * lastDay = [df stringFromDate:beDate];
    
    if (distanceTime < 60) {//小于一分钟
        distanceStr = @"刚刚";
    }
    else if (distanceTime <60*60) {//时间小于一个小时
        distanceStr = [NSString stringWithFormat:@"%ld分钟前",(long)distanceTime/60];
    }
    else if(distanceTime <24*60*60 && [nowDay integerValue] == [lastDay integerValue]){//时间小于一天
        distanceStr = [NSString stringWithFormat:@"%ld小时前",(long)distanceTime/3600];
    }
    else if(distanceTime<24*60*60*2 && [nowDay integerValue] != [lastDay integerValue]){
        
        if ([nowDay integerValue] - [lastDay integerValue] ==1 || ([lastDay integerValue] - [nowDay integerValue] > 10 && [nowDay integerValue] == 1)) {
            distanceStr = [NSString stringWithFormat:@"昨天 %@",timeStr];
        }
        else{
            [df setDateFormat:@"MM-dd HH:mm"];
            distanceStr = [df stringFromDate:beDate];
        }
        
    }
    else if(distanceTime <24*60*60*365){
        [df setDateFormat:@"MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    else{
        [df setDateFormat:@"yyyy-MM-dd HH:mm"];
        distanceStr = [df stringFromDate:beDate];
    }
    return distanceStr;
    
}

//处理字典数值为空崩溃情况
+(NSString*)setDicWithValue:(NSString*)value {
    if (value) {
        return value;
    }
    return @" ";
}

//设置右边按钮 查看密码
+(UIButton*)setRightViewWithTextField:(UITextField *)textField idView:(UIView*)view imageName:(NSString *)imageName{
    
    UIButton *rightView = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightView setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    [view addSubview:rightView];
    [rightView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@(30));
        make.left.equalTo(textField.mas_right);
        make.centerY.equalTo(textField);
    }];
    return rightView;
    
}

//16进制颜色
+ (UIColor *)stringTOColor:(NSString *)str
{
    if (!str || [str isEqualToString:@""]) {
        return nil;
    }
    if (![str hasPrefix:@"#"]) {
        str = [NSString stringWithFormat:@"#%@",str];
    }
    
    NSString *cString = [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

//检测是否为空
+ (BOOL)checkNil:(id)data{
    BOOL had = NO;
    if (data) {
        had = YES;
    }
    if ([data isKindOfClass:[NSArray class]]) {
        if ([data count] == 0) {
            had = NO;
        }
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        if ([[data allKeys] count] == 0) {
            had = NO;
        }
    }else if ([data isKindOfClass:[NSMutableArray class]]) {
        if ([data count] == 0) {
            had = NO;
        }
    }else if ([data isKindOfClass:[NSMutableDictionary class]]) {
        if ([[data allKeys] count] == 0) {
            had = NO;
        }
    }else if ([data isKindOfClass:[NSNull class]]) {
        had = NO;
    }else if ([data isKindOfClass:[NSString class]]) {
        if ([data length]==0) {
           had = NO;
        }
    }
    return had;
}

//数据本地存取
+ (void)userSaveObject:(id)data forKey:(NSString*)key{
    
    if ((!data)||(!WMZBoolNill(key))||(![key isKindOfClass:[NSString class]])) {
        NSLog(@"储存失败");
        return;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    if ([data isKindOfClass:[NSNumber class]]) {
        [user setObject:data forKey:key];
    }else if ([data isKindOfClass:[NSString class]]) {
        [user setObject:data forKey:key];
        
    }else if ([data isKindOfClass:[NSArray class]]) {
        [user setObject:data forKey:key];
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        [user setObject:data forKey:key];
    }else if ([data isKindOfClass:[NSMutableArray class]]) {
        [user setObject:[NSArray arrayWithArray:data] forKey:key];
    }else if ([data isKindOfClass:[NSMutableDictionary class]]) {
        [user setObject:[NSDictionary dictionaryWithDictionary:data] forKey:key];
    }
    [user synchronize];
}

+ (void)userSaveBool:(BOOL)value forKey:(NSString*)key{
    if ((WMZBoolNill(key)&&[key isKindOfClass:[NSString class]])) {
        NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
        [user setBool:value forKey:key];
        [user synchronize];
    }else{
        NSLog(@"储存失败");
    }
}

+ (void)userSaveInteger:(NSInteger)value forKey:(NSString*)key{
    if ((WMZBoolNill(key)&&[key isKindOfClass:[NSString class]])) {
        NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
        [user setInteger:value forKey:key];
        [user synchronize];
    }else{
        NSLog(@"储存失败");
    }
}

+ (void)userSaveFloat:(float)value forKey:(NSString*)key{
    if ((WMZBoolNill(key)&&[key isKindOfClass:[NSString class]])) {
        NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
        [user setFloat:value forKey:key];
        [user synchronize];
    }else{
        NSLog(@"储存失败");
    }
}

+ (void)userSaveDoublue:(double)value forKey:(NSString*)key{
    if ((WMZBoolNill(key)&&[key isKindOfClass:[NSString class]])) {
        NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
        [user setDouble:value forKey:key];
        [user synchronize];
    }else{
        NSLog(@"储存失败");
    }
}

+ (id)userGetObjectForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return @"";
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    id data = [user objectForKey:key];
    if (!data) {
         return @"";
    }
    return data;
}

+ (id)userGetNullObjectForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return nil;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    id data = [user objectForKey:key];
    return data;
}

+ (BOOL)userGetBoolForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return NO;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    BOOL data = [user boolForKey:key];
    return data;
}

+ (NSInteger)userGetIntegerForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return 0;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    NSInteger data = [user integerForKey:key];
    return data;
}

+ (CGFloat)userGetFloatForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return 0.0;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    CGFloat data = [user floatForKey:key];
    return data;
}

+ (double)userGetDoublueForKey:(NSString*)key{
    if (!WMZBoolNill(key)||![key isKindOfClass:[NSString class]]) {
        NSLog(@"获取失败");
        return 0.00;
    }
    NSUserDefaults *user = [NSUserDefaults  standardUserDefaults];
    double data = [user doubleForKey:key];
    return data;
}

//添加数组数据
+ (BOOL)InsertArr:(id)arr withObject:(id)object{
    BOOL result = NO;
    if (!arr) {
        arr = [NSMutableArray new];
    }
    if ([arr isKindOfClass:[NSMutableArray class]]) {

          if (object) {
              if ([object isKindOfClass:[NSArray class]]||[object isKindOfClass:[NSMutableArray class]]) {
                  [arr addObjectsFromArray:object];
              }else{
                  [arr addObject:object];
              }
              result = YES;
              NSLog(@"插入成功 %@",arr);
          }
      }
    if (!result) {
        NSLog(@"插入失败");
    }
    
    return result;
}

//添加数组数据
+ (BOOL)InsertDic:(id)dic withObject:(id)object withKey:(NSString*)key{
    BOOL result = NO;
    if (!dic) {
        dic = [NSMutableDictionary new];
    }
    if ([dic isKindOfClass:[NSMutableDictionary class]]) {
        if (object&&(WMZBoolNill(key))&&[key isKindOfClass:[NSString class]]) {
            [dic setObject:object forKey:key];
            result = YES;
            NSLog(@"插入成功 %@",dic);
        }
    }
    if (!result) {
        NSLog(@"插入失败");
    }
    
    return result;
}

@end
