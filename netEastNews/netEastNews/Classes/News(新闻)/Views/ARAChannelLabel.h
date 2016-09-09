//
//  ARAChannelLabel.h
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ARAChannelLabel : UILabel

@property (assign, nonatomic) CGFloat scale;

+(instancetype)labelWithName:(NSString *)name;

@end
