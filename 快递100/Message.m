//
//  Message.m
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "Message.h"

@implementation Message
+(NSMutableArray *)arrayFromJsonData:(NSDictionary *)jsonData{

    NSMutableArray *dataSource=[NSMutableArray new];
    for (NSDictionary *dic in jsonData[@"Traces"]) {
        Message *ship=[[Message alloc]init];
        ship.messgae=dic[@"AcceptStation"];
        ship.time=dic[@"AcceptTime"];
        [dataSource addObject:ship];
    }
    return dataSource;

}
@end
