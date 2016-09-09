//
//  ARATabBarController.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARATabBarController.h"
#import "ARANewsViewController.h"
#import "ARALiveViewController.h"
#import "ARATalkViewController.h"
#import "ARAMeViewController.h"
#import "ARAHomeViewController.h"

@interface ARATabBarController ()

@property (strong, nonatomic) NSMutableArray *dataArray;

@end

@implementation ARATabBarController

-(NSMutableArray *)dataArray{
    if (nil == _dataArray) {
        _dataArray =[ NSMutableArray array];
        
    }
    return _dataArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setuptabBar];
    [self createChildView];
}
-(void)createChildView{
    //新闻 设置
    
    ARANewsViewController *newsController = [[ARANewsViewController alloc] init];
    [self setupRootController:newsController normalImage:@"tabbar_icon_news_normal" selectImage:@"tabbar_icon_news_highlight"];
    //直播
    
    ARALiveViewController *liveController = [[ARALiveViewController alloc] init];
    [self setupRootController:liveController normalImage:@"tabbar_icon_media_normal" selectImage:@"tabbar_icon_media_highlight"];
    //会话
    
    ARATalkViewController *talkController = [[ARATalkViewController alloc] init];
    [self setupRootController:talkController normalImage:@"tabbar_icon_bar_normal" selectImage:@"tabbar_icon_bar_highlight"];
    
    //我的
    ARAMeViewController *meController = [[ARAMeViewController alloc] init];
    [self setupRootController:meController normalImage:@"tabbar_icon_me_normal" selectImage:@"tabbar_icon_me_highlight"];
    
    self.viewControllers = self.dataArray ;
}
-(void)setuptabBar{
    
    self.tabBar.backgroundImage = [UIImage imageNamed:@"tabbar_bg"];
    
    
    
    //    ARATabBar *tabBar = [ARATabBar new];
    //
    //    tabBar.items = self.tabBar.items;
    //    [self setValue:tabBar forKeyPath:@"tabBar"];
}

-(void)setupRootController:(UIViewController*)controller normalImage:(NSString *) image selectImage:(NSString *)selectIamge{
    
    controller.view.backgroundColor = [UIColor whiteColor];
    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:controller];
    //正常图片
    UIImage *iconImage = [UIImage imageNamed:image];
    iconImage = [iconImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nv.tabBarItem.image = iconImage;
    //选中图片
    UIImage *iconSelectImage = [UIImage imageNamed:selectIamge];
    iconSelectImage = [iconSelectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    nv.tabBarItem.selectedImage =iconSelectImage;
    nv.tabBarItem.title = @"新闻";
    
    [self.dataArray addObject:nv];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
