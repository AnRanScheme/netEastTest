//
//  ARAThreePictureCell.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAThreePictureCell.h"
#import <UIImageView+WebCache.h>
#import <Masonry.h>

@interface ARAThreePictureCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *sourceLabel;

@property (weak, nonatomic) IBOutlet UILabel *replyCountLabel;

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *iconImageViewCollection;
@end

@implementation ARAThreePictureCell

-(void)setModel:(ARANewsModel *)model{
    _model = model;
    [_iconImageView sd_setImageWithURL:[NSURL URLWithString:model.imgsrc]];
    _titleLabel.text = model.title;
    _sourceLabel.text = model.source;
    _replyCountLabel.text = [NSString stringWithFormat:@"%d跟帖",model.replyCount.intValue];
    
    if (model.imgextra) {
        [model.imgextra enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            NSString *imgSrc = obj[@"imgsrc"];
            //对应的imageview
            UIImageView *iv =  self.iconImageViewCollection[idx];
            //sdwebimage
            NSURL *url = [NSURL URLWithString:imgSrc];
            [iv sd_setImageWithURL:url];
        }];
    }
}
@end
