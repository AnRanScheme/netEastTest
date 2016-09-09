//
//  ARANetworkingTools.h
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//
/**
 *  网络管理
 *
 *  @param instancetype 单例模式
 *
 *  @return <#return value description#>
 */
#import <AFNetworking/AFNetworking.h>

@interface ARANetworkingTools : AFHTTPSessionManager
+(instancetype)sharedNetworkingTools;

@end
