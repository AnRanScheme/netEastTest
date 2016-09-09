//
//  ARANewsModel.h
//  netEastNews
//
//  Created by 安然 on 16/9/5.
//  Copyright © 2016年 MacBook. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ARANewsModel : NSObject

//回复
@property(nonatomic,copy) NSNumber *replyCount;
//主标题
@property(nonatomic,copy) NSString *title;
//副标题
@property(nonatomic,copy) NSString *digest;
//图片
@property(nonatomic,copy) NSString *imgsrc;
//时间
@property(nonatomic,copy) NSString *ptime;
//新闻来源
@property(nonatomic,copy) NSString *source;
//大图的标示
@property(nonatomic,assign) BOOL imgType;
//3张图的标示
@property(nonatomic,copy) NSArray *imgextra;

@property (copy, nonatomic) NSString *url;

+(instancetype)newsModelWithDict:(NSDictionary *)dict;

//网络获取数据,需要得到自定义模型的数组


+(void)newsModelWithUrlString:(NSString*)urlString Success:(void(^)(NSArray<ARANewsModel *> * array))successBlock Error:(void(^)())errorBlock;

@end
