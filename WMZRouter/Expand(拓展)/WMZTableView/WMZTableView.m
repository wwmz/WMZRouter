

//
//  WMZTableView.m
//  WMZTableView
//
//  Created by wmz on 2018/10/22.
//  Copyright © 2018年 wmz. All rights reserved.
//


#import "WMZTableView.h"
@interface WMZTableView()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, copy)   ClickBlock clickHandle;                //点击回调

@property (nonatomic, copy)   CellShowBlock showBlock;               //cell显示

@property (nonatomic, copy)   CellCount countBlock;                  //cell数量

@property (nonatomic, copy)   CellHeight heightBlock;                //cell高度

@property (nonatomic, copy)   HeadHeight headHeightBlock;            //cell头部高度

@property (nonatomic, copy)   FootHeight footHeightBlock;            //cell底部高度

@property (nonatomic, copy)   HeadView headViewBlock;                //cell头部视图

@property (nonatomic, copy)   FootView footViewBlock;                //cell底部视图

@property (nonatomic, strong) NSArray *dataArr;                      //dataArr

@property (nonatomic, assign) NSInteger section;                     //多少列

@property (nonatomic, assign) CellType type;                         //type
@end
@implementation WMZTableView


//初始化 Grouped
+ (instancetype)shareGrouped{
    return  [[self alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

//初始化 Plain
+ (instancetype)sharePlain{
    return  [[self alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
}

-(void)updateWithData:(NSArray *)data{
    self.dataArr = [NSArray arrayWithArray:data];
    [self reloadData];
}

- (WMZTableView*)addTableViewWithType:(CellType)type
                       withConstraint:(WMZConstraint)make
                        withSuperView:(UIView*)superView
                             withData:(id)data
                         WithCellShow:(CellShowBlock)showBlock
                               Handle:(ClickBlock)block{
     return [self addTableViewWithType:type withConstraint:make withSuperView:superView withData:data withSection:1 withCellName:nil WithCellShow:showBlock WithCellCount:nil WithCellHeight:nil WithHeadHeight:nil WithFootHeight:nil WithHeadView:nil WithFootView:nil Handle:block];
}

- (WMZTableView*)addTableViewWithType:(CellType)type
                       withConstraint:(WMZConstraint)make
                        withSuperView:(UIView*)superView
                             withData:(id)data
                         withCellName:(NSArray*)cellNameArr
                         WithCellShow:(CellShowBlock)showBlock
                        WithCellCount:(CellCount)countBlock
                               Handle:(ClickBlock)block{
   return [self addTableViewWithType:type withConstraint:make withSuperView:superView withData:data withSection:1 withCellName:cellNameArr WithCellShow:showBlock WithCellCount:countBlock WithCellHeight:nil WithHeadHeight:nil WithFootHeight:nil WithHeadView:nil WithFootView:nil Handle:block];
}

- (WMZTableView *)addTableViewWithType:(CellType)type
                        withConstraint:(WMZConstraint)make
                         withSuperView:(UIView *)superView
                              withData:(id )data
                           withSection:(NSInteger)section
                          withCellName:(NSArray *)cellNameArr
                          WithCellShow:(CellShowBlock)showBlock
                         WithCellCount:(CellCount)countBlock
                        WithCellHeight:(CellHeight)heightBlock
                        WithHeadHeight:(HeadHeight)headHeightBlock
                        WithFootHeight:(FootHeight)footHeightBlock
                          WithHeadView:(HeadView)headViewBlock
                          WithFootView:(FootView)footViewBlock
                                Handle:(ClickBlock)block{
    
    self.dataArr = [NSArray arrayWithArray:data];
    
    if (block) {
        self.clickHandle = block;
    }
    if (showBlock) {
        self.showBlock = showBlock;
    }
    if (countBlock) {
        self.countBlock = countBlock;
    }
    if (heightBlock) {
        self.heightBlock = heightBlock;
    }
    if (headHeightBlock) {
        self.headHeightBlock = headHeightBlock;
    }
    if (footHeightBlock) {
        self.footHeightBlock = footHeightBlock;
    }
    if (headViewBlock) {
        self.headViewBlock = headViewBlock;
    }
    if (footViewBlock) {
        self.footViewBlock = footViewBlock;
    }
    
    
    for (NSString *cellName in cellNameArr) {
        if (cellName) {
            Class cellClass = NSClassFromString(cellName);
            [self registerClass:[cellClass class] forCellReuseIdentifier:cellName];
        }
    }
    
    if (superView) {
        [superView addSubview:self];
        if (make) {
            [self mas_makeConstraints:make];
        }
    }
   
    self.section = section;
    self.type = type;
    
    self.delegate = self;
    self.dataSource = self;
    self.estimatedSectionHeaderHeight = 0.01;
    self.estimatedSectionFooterHeight = 0.01;
    self.rowHeight = UITableViewAutomaticDimension;
    self.estimatedRowHeight = 100.0f;
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    return self;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.heightBlock) {
        return self.heightBlock(indexPath);
    }
    return UITableViewAutomaticDimension;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.section>0) {
        return self.section;
    }
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.countBlock) {
       return self.countBlock(section);
    }
    return self.dataArr.count;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (self.footViewBlock) {
        return self.footViewBlock(section);
    }
    return [UIView new];
}


- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.headViewBlock) {
        return self.headViewBlock(section);
    }
    return [UIView new];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    
    if (self.footHeightBlock) {
        return self.footHeightBlock(section);
    }
    return 0.1f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.headHeightBlock) {
        return self.headHeightBlock(section);
    }
    return 0.1f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.showBlock) {
        return self.showBlock(self.dataArr[indexPath.row],indexPath);
    }
    return [UITableViewCell new];
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (self.clickHandle) {
         self.clickHandle(self.dataArr[indexPath.row]);
    }
}


- (NSString*)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewTitleForFooterInSection:)]) {
       return [self.WMZdelegate WMZTableViewTitleForFooterInSection:section];
    }
    return nil;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewTitleForHeaderInSection:)]) {
        return [self.WMZdelegate WMZTableViewTitleForHeaderInSection:section];
    }
    return nil;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewEditingStyleForRowAtIndexPath:)]) {
        return [self.WMZdelegate WMZTableViewEditingStyleForRowAtIndexPath:indexPath];
    }
    return UITableViewCellEditingStyleNone;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:)]) {
        return [self.WMZdelegate WMZTableViewTitleForDeleteConfirmationButtonForRowAtIndexPath:indexPath];
    }
    return nil;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewCommitEditingStyle:forRowAtIndexPath:)]) {
        return [self.WMZdelegate WMZTableViewCommitEditingStyle:editingStyle forRowAtIndexPath:indexPath];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.WMZdelegate && [self.WMZdelegate respondsToSelector:@selector(WMZTableViewWillDisplayCell:forRowAtIndexPath:)]) {
        return [self.WMZdelegate WMZTableViewWillDisplayCell:cell forRowAtIndexPath:indexPath];
    }
}

@end


@implementation NornalCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.myLabel];

        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (UILabel *)myLabel{
    if (!_myLabel) {
        _myLabel = [UILabel new];
        _myLabel.numberOfLines = 0;
        _myLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _myLabel;
}

- (void)setModel:(id)model{
    _model = model;
    self.myLabel.text = model;
}

+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
}

@end

@implementation NornalCellOne

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor cyanColor];
        [self.contentView addSubview:self.myLabel];
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.contentView).offset(10);
        }];
        
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(30);
            make.right.equalTo(self.contentView).offset(-30);
            make.top.equalTo(self.myLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
        }];
    }
    return self;
}

- (UILabel *)myLabel{
    if (!_myLabel) {
        _myLabel = [UILabel new];
        _myLabel.numberOfLines = 0;
        
    }
    return _myLabel;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"6.jpg"];
    }
    return _icon;
}

@end

@implementation NornalCellSecond

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor purpleColor];
        
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(80);
            make.right.equalTo(self.contentView).offset(-80);
            make.top.equalTo(self.contentView).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
    }
    return self;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"6.jpg"];
    }
    return _icon;
}
@end
