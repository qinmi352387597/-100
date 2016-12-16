//
//  Message.h
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
@property(nonatomic,copy)NSString *time;
@property(nonatomic,copy)NSString *messgae;

+(NSMutableArray *)arrayFromJsonData:(NSDictionary *)jsonData;


@end
