//
//  ARANewsViewController.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANewsViewController.h"
#import "ARALoopPlayerModel.h"
#import "ARAChannelModel.h"
#import "ARAChannelLabel.h"
#import "ARANewsCollectionCell.h"
#import "ARANewsCollectionView.h"
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height
 

@interface ARANewsViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>

//新闻分类
@property (weak, nonatomic) UIScrollView *channelScroll;
//新闻主体
@property (weak, nonatomic) UICollectionView *newsCollection;
//数据源
@property(nonatomic,strong) NSArray<ARAChannelModel *> *channelModelArray;

@property (weak, nonatomic) UICollectionViewFlowLayout *flowLayout;
//记录当前分类的index
@property (assign, nonatomic) NSInteger currentChannelIndex;
//记录下一次点击的新闻分类index
@property(nonatomic,assign) NSInteger nextChannelIndex;

@property (strong, nonatomic) NSMutableArray *titleLabel;

@property (nonatomic, weak) ARAChannelLabel *selectLabel;

@end

@implementation ARANewsViewController

-(NSArray *)titleLabel{
    if (nil == _titleLabel) {
        _titleLabel = [NSMutableArray array];
    }
    return _titleLabel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.channelModelArray = [ARAChannelModel channelModel];
    [self createChildView];
    [self displayChannel];
  
}

-(void)createChildView{
    
    UIScrollView *channelScroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64 , self.view.bounds.size.width, 40)];
    _channelScroll = channelScroll;
    [self.view addSubview:channelScroll];

    ARANewsCollectionView *newsCollection = [[ARANewsCollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(channelScroll.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(channelScroll.frame))];
    newsCollection.delegate = self;
    newsCollection.dataSource = self;
    self.newsCollection = newsCollection;
    [self.newsCollection registerClass:[ARANewsCollectionCell class] forCellWithReuseIdentifier:@"homecell"];
    [self.view addSubview:newsCollection];
    
}

//显示新闻的类
-(void)displayChannel{
    //UIScrollView在导航条下面的时候,自动的添加上导航条的高度
    self.automaticallyAdjustsScrollViewInsets = NO;
    //label的位置计算
    CGFloat margin = 5;
    __block CGFloat x = margin;
    CGFloat y = 0;

    CGFloat height = self.channelScroll.frame.size.height;
    
    [self.channelModelArray enumerateObjectsUsingBlock:^(ARAChannelModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //创建label
        
        ARAChannelLabel *label = [ARAChannelLabel labelWithName:obj.tname];
        
        CGFloat labelW = label.frame.size.width;
        label.frame = CGRectMake(x, y, labelW, height);
        //累加
        x += labelW +margin;
        //把label加到channelScroll
        [self.channelScroll addSubview:label];
        //添加点击事件
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollToNextNewsCollection:)];
        
        [label addGestureRecognizer:tap];
        
        label.tag = idx ;
        
        [self.titleLabel addObject:label];
    }];
    //使得新闻的分类可以滚动
    [self.channelScroll setContentSize:CGSizeMake(x, height)];
    //使得第一个频道红色 字体大
    ARAChannelLabel *label = self.channelScroll.subviews[0];
    
    label.scale = 1;
}

-(void)scrollToNextNewsCollection:(UITapGestureRecognizer *)tap{
    
    ARAChannelLabel *tapLabel = (ARAChannelLabel *)tap.view;
    
    NSInteger index = tapLabel.tag ;
    //获取
    self.nextChannelIndex = tapLabel.tag;
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:index inSection:0];
    // 字体缩放:形变
    tapLabel.transform = CGAffineTransformMakeScale(1.3, 1.3);
    
    [self.newsCollection scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}



#pragma mark collection datasouce

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.channelModelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    ARANewsCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"homecell" forIndexPath:indexPath];
    
    ARAChannelModel *model = self.channelModelArray[indexPath.item];
    
    cell.urlString = [model getChannelModelURl];

    return cell;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    NSLog(@"current---%ld ,next---%ld",self.currentChannelIndex,self.nextChannelIndex);
    
    //判断点击的新闻分类是否相邻
    if(ABS(self.currentChannelIndex - self.nextChannelIndex) > 1){
        // 不相邻
        return;
    }
    //重复判断   为了 我们要是在下面滚到的时候一旦过快 会出现bug
    self.currentChannelIndex = scrollView.contentOffset.x / self.newsCollection.frame.size.width;
    
    //判断点击的新闻分类是否相邻
    if(ABS(self.currentChannelIndex - self.nextChannelIndex) > 1){
        // 不相邻
        return;
    }
    
    //1.获取到当前新闻分类的Label和下一个受到影响的Label(可能是前一个,也可能是后一个)
    ARAChannelLabel *currentLabel = self.channelScroll.subviews[self.currentChannelIndex];

    //获取到当前界面上正在显示的indexPath 在界面只可能像是两个,其中一个是当前显示的,那么另一个就是要显示的
    ARAChannelLabel *nextLabel = nil ;

    NSArray *array = [self.newsCollection indexPathsForVisibleItems];
    
    for (NSIndexPath *indexpath in array) {
        if (indexpath.item != _currentChannelIndex) {
            nextLabel = self.channelScroll.subviews[indexpath.item];
            break;
        }
    }
    //算出变化率  获取2值的变化率 0~1
    CGFloat nextScale= scrollView.contentOffset.x ;
    
    nextScale = nextScale / _newsCollection.frame.size.width;
    
    nextScale = nextScale - _currentChannelIndex;
    //正负绝对值;
    nextScale = ABS(nextScale);
    
    CGFloat currentScale = 1 - nextScale;
    
    currentLabel.scale = currentScale;
    
    nextLabel.scale = nextScale;
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    
  
    _currentChannelIndex = scrollView.contentOffset.x / self.newsCollection.frame.size.width;
    
    _nextChannelIndex = _currentChannelIndex;
    
    
    
    for (UIView *label in self.channelScroll.subviews) {
        
        if ([label isKindOfClass:[ARAChannelLabel class]]) {
            
            ARAChannelLabel* nowLabel = (ARAChannelLabel *)label;
            
            if (nowLabel.tag  == self.currentChannelIndex ) {
                
                nowLabel.scale = 1;
            }else{
                
                nowLabel.scale = 0;
            }
        }
    }
   

    //完成功能,滚动菜单条
    //1.获取当前label
    ARAChannelLabel *currentLabel = self.channelScroll.subviews[_currentChannelIndex];
    
    CGFloat offset =currentLabel.center.x - self.newsCollection.frame.size.width * 0.5;
    
    CGFloat max = self.channelScroll.contentSize.width - self.newsCollection.frame.size.width;
    
    if (offset < 0) {
        offset = 0;
    } else if(offset > max) {
        offset = max;
    }
    
    [self.channelScroll setContentOffset:CGPointMake(offset, 0) animated:YES];
}
@end
