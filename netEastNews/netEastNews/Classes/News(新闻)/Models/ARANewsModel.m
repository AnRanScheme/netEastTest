//
//  ARANewsModel.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARANewsModel.h"
#import "ARANetworkingTools.h"

@implementation ARANewsModel

+(instancetype)newsModelWithDict:(NSDictionary *)dict{
    
    ARANewsModel *model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}


//网络获取数据,需要得到自定义模型的数组
+(void)newsModelWithUrlString:(NSString*)urlString Success:(void(^)(NSArray<ARANewsModel *> * array))successBlock Error:(void(^)())errorBlock{
    
    ARANetworkingTools *manager = [ARANetworkingTools sharedNetworkingTools];
    //http://c.m.163.com/nc/article/headline/T1348647853363/0-140.html
    //新闻@"article/list/T1348648517839/0-20.html"
    //娱乐@"article/headline/T1348647853363/0-140.html"
    [manager GET:urlString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSString *dictKey = responseObject.keyEnumerator.nextObject;
   
        NSArray *array = responseObject[dictKey];
        
        NSMutableArray *nmArray = [NSMutableArray array];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ARANewsModel *model = [ARANewsModel newsModelWithDict:obj];
            
            [nmArray addObject:model];
        }];
        
        if (successBlock) {
            successBlock(nmArray.copy);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (errorBlock) {
            errorBlock();
        }
    }];
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@{replyCount = %d,title = %@,digest = %@,imgsrc = %@,ptime = %@,source = %@,url = %@}",[super description],self.replyCount.intValue,self.title,self.digest,self.imgsrc,self.ptime,self.source,self.url];
}

@end
