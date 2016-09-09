//
//  ARALoopPlayerModel.h
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//
/**
 *  无限轮播数据模型
 *
 */

#import <Foundation/Foundation.h>

@interface ARALoopPlayerModel : NSObject

@property (copy, nonatomic) NSString *title;

@property (copy, nonatomic) NSString *imgsrc;

+(void)loopPlayerModelWithSuccessBlock:(void(^)(NSArray* array))successBlock errorBlock:(void(^)())errorBlock;

+(instancetype)loopPlayerModelWithDict:(NSDictionary *)dict;



@end
