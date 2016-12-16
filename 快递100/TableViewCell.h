//
//  TableViewCell.h
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"
#define Main_Screen_Height      [[UIScreen mainScreen] bounds].size.height
#define Main_Screen_Width       [[UIScreen mainScreen] bounds].size.width

@interface TableViewCell : UITableViewCell
//单据状态图片
@property (nonatomic,strong)UIImageView * stateImage;
//时间
@property (nonatomic,strong)UILabel * time;
//信息
@property (nonatomic,strong)UILabel * message;

-(void)config:(Message*)mm;
-(void)configFirst:(Message *)mm;
@end
