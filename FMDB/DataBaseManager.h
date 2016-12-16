//
//  DataBaseManager.h
//  FMFB_单例
//
//  Created by QianFeng on 16/1/26.
//  Copyright © 2016年 秦密. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shippers.h"
@interface DataBaseManager : NSObject
+(instancetype)sharedManager;
/**
 *  获得数据库单例 
 */
//增
-(void)insertShippers:(Shippers *)sender;
//删
-(BOOL)deleteStudentByID:(NSString *)sender;
//改
-(void)updateStudent:(Shippers *)sender andWithid:(NSString *)ShipperCode;
//查
-(NSMutableArray *)search;

@end
