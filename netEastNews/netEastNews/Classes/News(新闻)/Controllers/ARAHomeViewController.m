//
//  ARAHomeViewController.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAHomeViewController.h"
#import "ARALoopPlayerModel.h"
#import "ARALoopPlayerView.h"
#import "ARANewsModel.h"
#import "ARANewsNomalCell.h"
#import "ARANewsBigPictureCell.h"
#import "ARAThreePictureCell.h"
#import "ARAWebviewController.h"
#import "ARAWebViewNavigationController.h"

@interface ARAHomeViewController ()

@property (strong, nonatomic) NSArray *modelArray;

@property (weak, nonatomic) ARAWebViewNavigationController *nav;


@end

@implementation ARAHomeViewController
static NSString *identifier = @"news1";
static NSString *identifier1 = @"news2";
static NSString *identifier2 = @"news3";


-(void)setUrlString:(NSString *)urlString{
    _urlString = urlString;
    
    [ARANewsModel newsModelWithUrlString:urlString Success:^(NSArray<ARANewsModel *> *array) {
        self.modelArray = array;
    } Error:^{
        
    }];
}

-(void)setModelArray:(NSArray *)modelArray{
    
    _modelArray = modelArray;
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    
    [self.tableView registerClass:[ARANewsBigPictureCell class] forCellReuseIdentifier:identifier1];
    
    [self.tableView registerClass:[ARANewsNomalCell class] forCellReuseIdentifier:identifier];
    
    UINib *nib = [UINib nibWithNibName:@"ARAThreePictureCell" bundle:nil];
    
    [self.tableView registerNib:nib forCellReuseIdentifier:identifier2];
    
    [super viewDidLoad];
    
    [self createChildView];

}
-(void)createChildView{
    
    self.tableView.estimatedRowHeight = 100;
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    ARALoopPlayerView *headerView = [[ARALoopPlayerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 180)];
    
    self.tableView.tableHeaderView = headerView;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return  1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.modelArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ARANewsModel *model = self.modelArray[indexPath.row];
    
    if (model.imgextra) {
        ARAThreePictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier2];
        cell.model = model;
        return cell;
    }
    
    if (model.imgType) {
        ARANewsBigPictureCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1
                                       ];
        cell.model = model;
        return cell;
    }
        
        ARANewsNomalCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        cell.model = model;
        
        return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ARANewsModel *model = self.modelArray[indexPath.row];
    
        if(model.imgType){
            return 200;
        }
        if(model.imgextra){
            return 140;
        }
        return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ARANewsModel *model = self.modelArray[indexPath.row];
    
    ARAWebviewController *webview = [[ARAWebviewController alloc] init];
    
    ARAWebViewNavigationController *nav = [[ARAWebViewNavigationController alloc] initWithRootViewController:webview];
//    nav.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:NULL];
    
    nav.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(popView)];
    
    
    webview.model = model;
    
    [self presentViewController:nav animated:YES completion:NULL];
    
    NSLog(@"%@",model.url);

}

-(void)popView{
    
    [self.nav popViewControllerAnimated:YES];
    
}

@end
