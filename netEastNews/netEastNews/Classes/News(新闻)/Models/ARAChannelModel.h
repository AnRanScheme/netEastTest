//
//  ARAChannelModel.h
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARAChannelModel : NSObject

@property(nonatomic,copy) NSString *tname;
@property(nonatomic,copy) NSString *tid;

//kvc
+(instancetype)modelWithDict:(NSDictionary *)dict;


//读取本地的数据,返回模型的集合
+(NSArray<ARAChannelModel *> *)channelModel;

-(NSString*)getChannelModelURl;

@end
