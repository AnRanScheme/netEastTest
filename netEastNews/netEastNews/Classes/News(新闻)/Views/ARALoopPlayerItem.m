//
//  ARALoopPlayerItem.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARALoopPlayerItem.h"
#import "UIImageView+WebCache.h"

@interface ARALoopPlayerItem ()

@property (weak, nonatomic) UIImageView *iconImageView;

@end

@implementation ARALoopPlayerItem

-(void)setModel:(ARALoopPlayerModel *)model{
    _model = model;
    NSURL *url = [NSURL URLWithString:model.imgsrc];
    [_iconImageView sd_setImageWithURL:url];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createChildView];
    }
    return self;
}

-(void)createChildView{
    UIImageView *iconImageView = [[UIImageView alloc] initWithFrame:self.contentView.frame];
    _iconImageView = iconImageView;
    [self.contentView addSubview:iconImageView];
}


@end
