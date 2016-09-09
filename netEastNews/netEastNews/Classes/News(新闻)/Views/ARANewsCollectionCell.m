//
//  ARANewsCollectionCell.m
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANewsCollectionCell.h"
#import "ARAHomeViewController.h"

@interface ARANewsCollectionCell ()

@property (strong, nonatomic) ARAHomeViewController *vc;

//@property (strong, nonatomic) UINavigationController *nv;

@end

@implementation ARANewsCollectionCell

-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    
    self.vc.urlString = urlString;
    
}
-(void)awakeFromNib{
    [super awakeFromNib];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.vc = [[ARAHomeViewController alloc] init];
        
        UINavigationController *nv= [[UINavigationController alloc] initWithRootViewController:self.vc];
        
//        _nv = nv;
        
        [self.contentView addSubview:self.vc.view];
    }
    return self;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //指定ARAHomeViewController view frame
    self.vc.view.frame = self.contentView.frame;
}
@end
