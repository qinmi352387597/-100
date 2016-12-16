//
//  HttpEngine.m
//  LimitApp
//
//  Created by jameswatt on 16/2/17.
//  Copyright © 2016年 xuzhixiang1. All rights reserved.
//

#import "HttpEngine.h"
#import <HYBNetworking.h>
#import "MD5.h"

#define eBusinessID @"1272248"
#define appKey @"e5771c91-9a14-4d95-b20c-442ab8b3859e"
@interface HttpEngine ()

@end

@implementation HttpEngine
//声明一个单例
+ (instancetype)shareEngine  {
    static HttpEngine *engine = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSLog(@"只执行一次");
        engine = [[HttpEngine alloc]init];
    }) ;
    return engine;
}

-(NSString *)base64StringFromText:(NSString *)text {
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String = [data base64EncodedStringWithOptions:0];
    
    return base64String;
}
- (void)post:(NSString*)URLString shipperCode:(NSString *)shipperCode LogisticCode:(NSString*)logisticCode  success:(SucessBlcokType)success failure:(FailedBlockType)failure{
    
    NSString* requestData = [NSString stringWithFormat:@"{\"OrderCode\":\"\",\"ShipperCode\":\"%@\",\"LogisticCode\":\"%@\"}",
                             shipperCode,logisticCode];
    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    NSString* dataSignTmp = [[NSString alloc]initWithFormat:@"%@%@",requestData,appKey];
    
    NSString* dataSign = [MD5 md5String:dataSignTmp];
    NSString* dataSign1=[self base64StringFromText:dataSign];
    
    [params setObject:[requestData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"RequestData"];
    
    
    [params setObject:eBusinessID forKey:@"EBusinessID"];
    [params setObject:@"1002" forKey:@"RequestType"];
    [params setObject:[dataSign1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"DataSign"];
    
    [params setObject:@"2" forKey:@"DataType"];
    //2.上传参数并获得返回值
    
    [HYBNetworking postWithUrl:URLString refreshCache:NO params:params success:^(id response) {
        if (success) {
            success(response);
        }

    } fail:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }
     ];

}
-(void)post:(NSString *)URLString LogisticCode:(NSString *)logisticCode success:(SucessBlcokType)success failure:(FailedBlockType)failure{
    NSString* requestData = [NSString stringWithFormat:@"{\"LogisticCode\":\"%@\"}",
                            logisticCode];

    NSMutableDictionary* params = [[NSMutableDictionary alloc]init];
    NSString* dataSignTmp = [[NSString alloc]initWithFormat:@"%@%@",requestData,appKey];
    
    NSString* dataSign = [MD5 md5String:dataSignTmp];
    NSString* dataSign1=[self base64StringFromText:dataSign];
    
    [params setObject:[requestData stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"RequestData"];
    
    [params setObject:eBusinessID forKey:@"EBusinessID"];
    [params setObject:@"2002" forKey:@"RequestType"];
    [params setObject:[dataSign1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] forKey:@"DataSign"];
    
    [params setObject:@"2" forKey:@"DataType"];
    //2.上传参数并获得返回值
    
    
    [HYBNetworking postWithUrl:URLString refreshCache:NO params:params success:^(id response) {
        if (success) {
            success(response);
        }
        
    } fail:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }
     ];



}

@end
