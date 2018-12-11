//
//  WMZTableView.h
//  WMZTableView
//
//  Created by wmz on 2018/10/22.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"

@protocol WMZTableViewDelegate <NSObject>

@optional //非必实现的方法

/*
 * 头视图标题 如需调用此方法则tableView的头视图需要设为nil 才能生效
 */
- (NSString*)WMZTableViewTitleForFooterInSection:(NSInteger)section;

/*
 * 尾视图标题 如需调用此方法则tableView的头视图需要设为nil 才能生效
 */
- (NSString*)WMZTableViewTitleForHeaderInSection:(NSInteger)section;

/*
 * 设置删除/添加的样式
 */
-(UITableViewCellEditingStyle)WMZTableViewEditingStyleForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * 设置删除/添加的样式的显示内容
 */
-(NSString *)WMZTableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath;

/*
 * 删除/添加的样式的点击方法
 */
- (void)WMZTableViewCommitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath;

/*
 * cell将显示的方法
 */
- (void)WMZTableViewWillDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath;

@end

//点击回调
typedef void (^ClickBlock)(id anyID);

//布局
typedef void(^WMZConstraint) (MASConstraintMaker *make);

//设置cell回调
typedef UITableViewCell* (^CellShowBlock)(id model,NSIndexPath *indexPath);

//设置cell数量
typedef NSInteger (^CellCount)(NSInteger section);

//设置cellh高度
typedef NSInteger (^CellHeight)(NSIndexPath *indexPath);

//设置头视图高度
typedef NSInteger (^HeadHeight)(NSInteger section);

//设置尾视图高度
typedef NSInteger (^FootHeight)(NSInteger section);

//设置头视图
typedef UIView * (^HeadView)(NSInteger section);

//设置尾视图
typedef UIView * (^FootView)(NSInteger section);

typedef enum : NSUInteger{
    CellTypeNornal,
    CellTypeAuto
}CellType;
@interface WMZTableView : UITableView

@property(nonatomic,weak) id <WMZTableViewDelegate> WMZdelegate;

/*
 * 初始化 Grouped
 */
+ (instancetype)shareGrouped;

/*
 * 初始化 Plain
 */
+ (instancetype)sharePlain;


/*
 * 更新
 *
 * @param  data  数据
 *
 */
- (void)updateWithData:(NSArray*)data;

/*
 * 封装tableview常用属性 基于masonry
 *
 * @param  type  类型
 * @param  make   tableView的布局
 * @param  superView    父视图
 * @param  data  数据源
 * @param  cellNameArr 多种cell的类名 传NSString的集合数组 需要先注册实现复用
 * @param  showBlock 显示的cell
 * @param  countBlock 显示的cell的数量
 * @param  block 点击的回调
 *
 */
- (WMZTableView*)addTableViewWithType:(CellType)type
                       withConstraint:(WMZConstraint)make
                        withSuperView:(UIView*)superView
                             withData:(id)data
                         withCellName:(NSArray*)cellNameArr
                         WithCellShow:(CellShowBlock)showBlock
                        WithCellCount:(CellCount)countBlock
                               Handle:(ClickBlock)block;


/*
 * 封装tableview常用属性 基于masonry
 *
 * @param  type  类型
 * @param  make   tableView的布局
 * @param  superView    父视图
 * @param  data  数据源
 * @param  showBlock 显示的cell
 * @param  block 点击的回调
 *
 */
- (WMZTableView*)addTableViewWithType:(CellType)type
                       withConstraint:(WMZConstraint)make
                        withSuperView:(UIView*)superView
                             withData:(id)data
                         WithCellShow:(CellShowBlock)showBlock
                               Handle:(ClickBlock)block;

/*
 * 封装tableview 基于masonry (可设置头尾视图)
 *
 * @param  type  类型
 * @param  make   tableView的布局
 * @param  superView    父视图
 * @param  data  数据源
 * @param  section  多少列
 * @param  cellNameArr 多种cell的类名 传NSString的集合数组 需要先注册实现复用
 * @param  showBlock 显示的cell
 * @param  countBlock 显示的cell的数量
 * @param  heightBlock cell的高度
 * @param  headHeightBlock 头部视图高度
 * @param  footHeightBlock 尾部视图高度
 * @param  headViewBlock 头部视图
 * @param  footViewBlock 尾部视图
 * @param  block 点击的回调
 *
 */
- (WMZTableView*)addTableViewWithType:(CellType)type
                       withConstraint:(WMZConstraint)make
                        withSuperView:(UIView*)superView
                             withData:(id)data
                          withSection:(NSInteger)section
                         withCellName:(NSArray*)cellNameArr
                         WithCellShow:(CellShowBlock)showBlock
                        WithCellCount:(CellCount)countBlock
                       WithCellHeight:(CellHeight)heightBlock
                       WithHeadHeight:(HeadHeight)headHeightBlock
                       WithFootHeight:(FootHeight)footHeightBlock
                         WithHeadView:(HeadView)headViewBlock
                         WithFootView:(FootView)footViewBlock
                               Handle:(ClickBlock)block;


@end


//自定义cell 可以自己设置
@interface NornalCell : UITableViewCell<WMZRouterProtocol>

@property(nonatomic,strong)UILabel *myLabel;

@property(nonatomic,strong)id model;



@end

@interface NornalCellOne : UITableViewCell

@property(nonatomic,strong)UILabel *myLabel;

@property(nonatomic,strong)UIImageView *icon;

@end

@interface NornalCellSecond : UITableViewCell

@property(nonatomic,strong)UIImageView *icon;

@end
