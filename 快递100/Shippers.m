//
//  Shippers.m
//  快递100
//
//  Created by admin on 2016/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "Shippers.h"

@implementation Shippers
+(NSMutableArray *)arrayFromJsonData:(NSDictionary *)key{
    NSMutableArray *dataSource=[NSMutableArray new];
    for (NSDictionary *dic in key[@"Shippers"]) {
        Shippers *ship=[[Shippers alloc]init];
        ship.ShipperCode=dic[@"ShipperCode"];
        ship.ShipperName=dic[@"ShipperName"];
        [dataSource addObject:ship];
    }
    return dataSource;

}
@end
