//
//  ARALoopPlayerViewController.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARALoopPlayerView.h"
#import "ARALoopPlayerItem.h"
#import "ARALoopPlayerModel.h"

@interface ARALoopPlayerView ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) UICollectionView *collectionView;

@property (weak, nonatomic) UIPageControl *pageControl;

@property (weak, nonatomic) UILabel *titleLabel;

@property (weak, nonatomic) UIView *backGroundView;

@property (strong, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSArray *loopPlayerModel;

@end

@implementation ARALoopPlayerView

static NSString *indetifier = @"Cell";

-(void)setLoopPlayerModel:(NSArray *)loopPlayerModel{
    _loopPlayerModel = loopPlayerModel;
    //为什么要放在这里呢   因为加不上pagecontrol  是因为数据self.loopPlayerModel.count
    [self createChildView];
    
    [_collectionView reloadData];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupData];
    }
    return self;
}

-(void)setupData{
    
    [ARALoopPlayerModel loopPlayerModelWithSuccessBlock:^(NSArray *array) {
                NSLog(@"success");
        
                self.loopPlayerModel = array;
        
            } errorBlock:^{
                NSLog(@"error");
            }];
}

-(void)createChildView{
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    flowLayout.itemSize =self.frame.size;
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.frame collectionViewLayout:flowLayout];
    collectionView.bounces = NO;
    collectionView.pagingEnabled = YES;
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor redColor];
    _collectionView = collectionView;
    [self.collectionView registerClass:[ARALoopPlayerItem class] forCellWithReuseIdentifier:indetifier];
    [self addSubview:collectionView];
    
    UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 40, self.frame.size.width, 40)];
    backGroundView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.7];
    [self addSubview:backGroundView];
    
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 60, self.frame.size.height - 40, 60, 40)];
    pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    pageControl.numberOfPages = self.loopPlayerModel.count;
    _pageControl = pageControl;
    [self addSubview:pageControl];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,self.frame.size.height - 40,self.frame.size.width - self.pageControl.frame.size.width,40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
}
#pragma mark
#pragma mark - UICollectionView

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.loopPlayerModel.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ARALoopPlayerItem *cell = [collectionView dequeueReusableCellWithReuseIdentifier:indetifier forIndexPath:indexPath];
    
    ARALoopPlayerModel *model = self.loopPlayerModel[indexPath.item];
    
    _titleLabel.text = model.title;
    
    _pageControl.currentPage = indexPath.item;
    
    cell.model = model;
    
    return cell;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    //滚动结束之后,调回到中间section对应的item位置

    int pageIndex =  scrollView.contentOffset.x / self.collectionView.frame.size.width;
    
    //秋雨运算
    pageIndex = pageIndex % self.loopPlayerModel.count;

    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:pageIndex inSection:1];
    
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
@end
