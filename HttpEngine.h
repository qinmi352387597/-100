//
//  HttpEngine.h
//  MintHome
//
//  Created by qianfeng on 16/2/24.
//  Copyright © 2016年 刘博. All rights reserved.
//

#import <Foundation/Foundation.h>
//成功的回调blcok
typedef void(^SucessBlcokType)(id response);
//失败的回调的blcok
typedef void(^FailedBlockType)(NSError *error);
@interface HttpEngine : NSObject

+ (instancetype)shareEngine ;

- (void)GET:(NSString*)URLString success:(SucessBlcokType)success failure:(FailedBlockType)failure;

@end
