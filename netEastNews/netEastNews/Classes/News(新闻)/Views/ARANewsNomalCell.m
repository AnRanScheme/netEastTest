//
//  ARANewsNomalCell.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANewsNomalCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface ARANewsNomalCell ()

@property (weak, nonatomic) UIImageView *iconImageView;

@property (weak, nonatomic) UILabel *titleLabel;

@property (weak, nonatomic) UILabel *sourceLabel;

@property (weak, nonatomic) UILabel *replyCountLabel;

@end

@implementation ARANewsNomalCell

-(void)setModel:(ARANewsModel *)model{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    _titleLabel.text = model.title;
     _sourceLabel.text = model.source;
     _replyCountLabel.text = [NSString stringWithFormat:@"%d跟帖",model.replyCount.intValue];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createChildView];
    }
    return self;
}

-(void)createChildView{
    
    //创建
    UIImageView *iconImageView = [[UIImageView alloc] init];
    _iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
    //约束
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.leading.equalTo(self.contentView).offset(8);
        make.bottom.equalTo(self.contentView).offset(-8);
        make.width.equalTo(@80);
    }];
    
    //创建
    UILabel *titleLabel = [[UILabel alloc] init];
    _titleLabel = titleLabel;
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 2;
    titleLabel.font = [UIFont systemFontOfSize:16];
    [self.contentView addSubview:titleLabel];
     //约束
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).offset(8);
        make.leading.equalTo(_iconImageView.mas_trailing).offset(8);
        make.trailing.equalTo(self.contentView).offset(-8);
    }];
    
    //创建
    UILabel *sourceLabel = [[UILabel alloc] init];
    _sourceLabel = sourceLabel;
    sourceLabel.textColor = [UIColor lightGrayColor];
    sourceLabel.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:sourceLabel];
    //约束
    [_sourceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-8);
        make.leading.equalTo(_iconImageView.mas_trailing).offset(8);
    }];
    
    //创建
    UILabel *replyCountLabel = [[UILabel alloc] init];
    _replyCountLabel = replyCountLabel;
    replyCountLabel.font = [UIFont systemFontOfSize:15];
    replyCountLabel.textColor = [UIColor lightGrayColor];
    [self.contentView addSubview:replyCountLabel];
    //约束
    [_replyCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-8);
        make.trailing.equalTo(self.contentView).offset(-8);
    }];
    
}

@end
