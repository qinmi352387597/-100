//
//  ViewController.h
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
@interface ViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,copy)NSString *ShipperCode;
@property(nonatomic,copy)NSString *ShipperName;

@end

