//
//  ARAChannelModel.m
//  netEastNews
//
//  Created by 安然 on 16/9/6.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARAChannelModel.h"

@implementation ARAChannelModel
+(instancetype)modelWithDict:(NSDictionary *)dict{
    ARAChannelModel *model = [ARAChannelModel new];
    
    [model setValuesForKeysWithDictionary:dict];
    
    
    return model;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{};

-(NSString *)description{
    return [NSString stringWithFormat:@"%@{tname = %@,tid =%@}",[super description],self.tname,self.tid];
}

+(NSArray<ARAChannelModel *> *)channelModel{
    //读取本地数据
    //1.文件的路径,2.二进制3.json反序列化
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"topic_news.json" ofType:nil];
    
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    
    //取数组
    NSArray<NSDictionary *> *array = dic[@"tList"];
    
    NSMutableArray *nmArray = [NSMutableArray array];
    [array enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        ARAChannelModel *model = [ARAChannelModel modelWithDict:obj];
        [nmArray addObject:model];
    }];
    
    
   return [nmArray sortedArrayUsingComparator:^NSComparisonResult(ARAChannelModel*  _Nonnull obj1, ARAChannelModel*  _Nonnull obj2) {
       
         return [obj1.tid compare:obj2.tid];
       
    }];
}
//http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html
-(NSString*)getChannelModelURl
{
    return [NSString stringWithFormat:@"article/headline/%@/0-140.html",self
            .tid];
}




@end
