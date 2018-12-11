




//
//  NewCell.m
//  WMZRouter
//
//  Created by wmz on 2018/11/13.
//  Copyright © 2018年 wmz. All rights reserved.
//

#import "NewCell.h"
@interface NewCell()
@property(nonatomic,strong)UILabel *title;

@property(nonatomic,strong)UILabel *myLabel;

@property(nonatomic,strong)UIImageView *icon;

@property(nonatomic,strong)UILabel *time;


@end
@implementation NewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self.contentView addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(20);
            make.width.height.mas_equalTo(80);
        }];
        
        [self.contentView addSubview:self.title];
        [self.title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(20);
            make.top.equalTo(self.icon.mas_top).offset(5);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        
        [self.contentView addSubview:self.myLabel];
        [self.myLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.icon.mas_right).offset(20);
            make.top.equalTo(self.title.mas_bottom).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-20);
        }];
        
        [self.contentView addSubview:self.time];
        [self.time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.icon.mas_bottom).offset(20);
            make.bottom.equalTo(self.contentView).offset(-20);
        }];
        
        [WMZUI newViewWithBackColor:[UIColor lightGrayColor] WithSubView:self.contentView Constraint:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(0);
            make.height.mas_equalTo(0.5);
        }];
    
    }
    return self;
}

- (UILabel *)myLabel{
    if (!_myLabel) {
        _myLabel = [UILabel new];
        _myLabel.numberOfLines = 2;
        _myLabel.textColor = [UIColor redColor];
        
    }
    return _myLabel;
}

- (UILabel *)title{
    if (!_title) {
        _title = [UILabel new];
        _title.numberOfLines = 0;
        
    }
    return _title;
}

- (UILabel *)time{
    if (!_time) {
        _time = [UILabel new];
        _time.numberOfLines = 0;
        
    }
    return _time;
}

- (UIImageView *)icon{
    if (!_icon) {
        _icon = [UIImageView new];
        _icon.image = [UIImage imageNamed:@"6.jpg"];
    }
    return _icon;
}

- (void)setModel:(id)model{
    _model = model;
    self.title.text = [model valueForKey:@"title"];
    self.myLabel.text = [model valueForKey:@"text"];
    self.icon.image = [UIImage imageNamed:[model valueForKey:@"icon"]];
    self.time.text = [model valueForKey:@"time"];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (NSString *)routerPath{
    return [NSString stringWithFormat:@"get%@",NSStringFromClass([self class])];
}

@end
