//
//  ARANewsCollectionView.m
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANewsCollectionView.h"

@implementation ARANewsCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:flowLayout];
    if (self) {
        
        self.showsHorizontalScrollIndicator = YES;
        flowLayout.itemSize = self.frame.size;
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        self.bounces = NO;
        self.pagingEnabled = YES;
        
    }
    return self;
}

@end
