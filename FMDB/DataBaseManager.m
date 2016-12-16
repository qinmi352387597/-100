//
//  DataBaseManager.m
//  FMFB_单例
//
//  Created by QianFeng on 16/1/26.
//  Copyright © 2016年 秦密. All rights reserved.
//

#import "DataBaseManager.h"
#import "FMDB.h"

@class StudentModel;
@interface DataBaseManager()
//数据库
@property(nonatomic,strong)FMDatabase *dataBase;
//数据库地址
@property(nonatomic,strong)NSString *dbPath;



@end

@implementation DataBaseManager
+(instancetype)sharedManager{

    static DataBaseManager *manager=nil;
    static dispatch_once_t token;//只执行一次
    dispatch_once(&token, ^{
        manager=[[DataBaseManager alloc]init];
        
    });
    
    return manager;

}
- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化数据库
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES)lastObject];
        NSString *dbPath=[path stringByAppendingPathComponent:@"myDB.sqlite"];
        _dataBase=[FMDatabase databaseWithPath:dbPath];
        //如果数据库打开就去创建表
        if ([_dataBase open]) {
            NSString  *sql=@"CREATE TABLE IF NOT EXISTS Shippers (ShipperCode TEXT PRIMARY KEY NOT NULL,ShipperName TEXT,ShipperBill TEXT)";
            
            if ([_dataBase executeUpdate:sql]) {
                NSLog(@"ok");
            }
        }
    }
    return self;
}


//增
-(void)insertShippers:(Shippers *)sender{
   
    
    NSString *sql2=@"INSERT INTO  Shippers(ShipperCode,ShipperName,ShipperBill) VALUES(?,?,?)";
    
    BOOL res= [self.dataBase executeUpdate:sql2,sender.ShipperCode,sender.ShipperName,sender.ShipperBill];
    
    if (res) {
        NSLog(@"插入成功");
    }

}

-(BOOL)deleteStudentByID:(NSString *)sender
{
    NSString *sql=@"DELETE FROM  Shippers WHERE ShipperCode=?";
    
    BOOL res=  [self.dataBase executeUpdate:sql,sender];
    if (res) {
        NSLog(@"删除");
    }
    
    return res;
}
//改
-(void)updateStudent:(Shippers *)sender andWithid:(NSString*)ShipperCode{
    NSString *sql=@"UPDATE  Shippers SET ShipperCode=?,ShipperName=?,ShipperBill=?  WHERE ShipperCode=?";
    BOOL res=  [self.dataBase executeUpdate:sql,sender.ShipperCode,sender.ShipperName,sender.ShipperBill,sender.ShipperCode];
    if (res) {
        NSLog(@"更新 成功");
    }

}
//查

-(NSMutableArray *)search{
    NSMutableArray *dataSource=[NSMutableArray new];
    NSString *sql=@"SELECT * FROM Shippers ";
    
    FMResultSet *set=  [self.dataBase executeQuery:sql];
    while ([set next]) {
        Shippers *shiper=[[Shippers alloc]init];
        shiper.ShipperCode=[set stringForColumn:@"ShipperCode"];
        shiper.ShipperName=[set stringForColumn:@"ShipperName"];
        shiper.ShipperBill=[set stringForColumn:@"ShipperBill"];
       
        [dataSource addObject:shiper];
    
    }
    return dataSource;

}




@end
