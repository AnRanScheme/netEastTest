//
//  ARAWebviewController.m
//  netEastNews
//
//  Created by 安然 on 16/9/8.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAWebviewController.h"

@interface ARAWebviewController ()<UIWebViewDelegate>

@property (weak, nonatomic) UIButton *backButton;

@end

@implementation ARAWebviewController

- (void)loadView {
    
    self.view = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIWebView *webView = (UIWebView *)self.view;
    
    
    NSURL *url = [NSURL URLWithString:self.model.url];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    webView.delegate = self;
    
    [webView loadRequest:request];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(150, 10, 60, 44)];
    
    [back setTitle:@"返回" forState:UIControlStateNormal];
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:back];
}

-(void)back{
    
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    
}

-(void)setModel:(ARANewsModel *)model{
    _model = model;
}

@end
