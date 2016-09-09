//
//  ARAWebViewNavigationController.m
//  netEastNews
//
//  Created by 安然 on 16/9/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAWebViewNavigationController.h"

@interface ARAWebViewNavigationController ()

@end

@implementation ARAWebViewNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置导航栏的背景图片
//    [self.navigationBar setBackgroundImage:[] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    
    
    // 设置导航栏文字颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 修改渲染颜色
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
}


#pragma mark
#pragma mark - 重写这个方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    viewController.hidesBottomBarWhenPushed = YES;
    
    [super pushViewController:viewController animated:animated];
}
@end
