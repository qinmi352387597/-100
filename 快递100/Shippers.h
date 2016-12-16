//
//  Shippers.h
//  快递100
//
//  Created by admin on 2016/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Shippers : NSObject
@property(nonatomic,copy)NSString *ShipperCode;
@property(nonatomic,copy)NSString *ShipperName;
@property(nonatomic,copy)NSString *ShipperBill;


+(NSMutableArray *)arrayFromJsonData:(NSDictionary *)key;

@end
