//
//  SelectedViewController.h
//  快递100
//
//  Created by admin on 2016/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Shippers.h"
@protocol ChooseShipperDelegate <NSObject>

-(void)respenseShiper:(Shippers *)ship;

@end

@interface SelectedViewController : UIViewController
@property(nonatomic,strong)NSMutableArray *dataSource;
@property(nonatomic,weak) id<ChooseShipperDelegate>delegate;
@end
