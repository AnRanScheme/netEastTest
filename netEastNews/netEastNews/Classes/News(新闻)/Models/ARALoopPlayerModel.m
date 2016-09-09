//
//  ARALoopPlayerModel.m
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import "ARALoopPlayerModel.h"
#import "ARANetworkingTools.h"

@implementation ARALoopPlayerModel

+(instancetype)loopPlayerModelWithDict:(NSDictionary *)dict{
    
    ARALoopPlayerModel* model = [[self alloc] init];
    
    [model setValuesForKeysWithDictionary:dict];
    
    return model;
}

+(void)loopPlayerModelWithSuccessBlock:(void(^)(NSArray* array))successBlock errorBlock:(void(^)())errorBlock{
    
    ARANetworkingTools *manager = [ARANetworkingTools sharedNetworkingTools];
         //http://c.m.163.com/nc/ad/headline/0-4.html
    [manager GET:@"ad/headline/0-4.html" parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary*  _Nullable responseObject) {
        
        NSMutableArray *nmArray = [NSMutableArray array];
        //属性是什么意思
        NSString *dictRootKey = responseObject.keyEnumerator.nextObject;
        
        NSArray *array = responseObject[dictRootKey];
        
        [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ARALoopPlayerModel *model = [ARALoopPlayerModel loopPlayerModelWithDict:obj];
            
            [nmArray addObject:model];
        }];
        
        if (successBlock) {
            successBlock(nmArray);
        }

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if (errorBlock) {
            errorBlock();
        }
    }];
}

-(NSString *)description{
    return [NSString stringWithFormat:@"%@\r\n{\r\ntitle =%@,\r\nimgsrc=%@\r\n}",[super description] ,_title,_imgsrc];
}

#pragma mark
#pragma mark - 不要忘了 不然会报错 就是对于没有的属性进行处理
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}


@end
