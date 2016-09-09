//
//  ARAChannelLabel.m
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAChannelLabel.h"

@implementation ARAChannelLabel

+(instancetype)labelWithName:(NSString *)name{
    ARAChannelLabel *label = [[ARAChannelLabel alloc] init];
    label.userInteractionEnabled = YES;
    [label setTextColor:[UIColor blackColor]];
    [label setFont:[UIFont systemFontOfSize:16]];
    [label setText:name];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label sizeToFit];
//    [label setFont:[UIFont systemFontOfSize:16]];
    return label;
}

-(void)setScale:(CGFloat)scale{
    _scale = scale;
    
    CGFloat max = 0.2;
    
    self.textColor = [UIColor colorWithRed:scale green:0 blue:0 alpha:1];
    
    self.transform = CGAffineTransformMakeScale(max * scale + 1, max * scale + 1);
    
    
}

@end
