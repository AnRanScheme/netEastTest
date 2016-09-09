//
//  ARANetworkingTools.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANetworkingTools.h"

@implementation ARANetworkingTools

+(instancetype)sharedNetworkingTools{
    static id instance;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //http://c.m.163.com/nc/ad/headline/0-4.html
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        config.timeoutIntervalForRequest = 15;
        /**
         BaseURL -- 公共地址
         */
        instance = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://c.m.163.com/nc/" ]sessionConfiguration:config];
    });
    
    return instance;
}

@end
