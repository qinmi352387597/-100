//
//  TableViewCell.m
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "TableViewCell.h"
#import<QuartzCore/QuartzCore.h>



@implementation TableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setNeedsDisplay];
        self.stateImage = [[UIImageView  alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        
        [self.contentView addSubview:self.stateImage];
        
        self.stateImage.layer.masksToBounds=YES;
        self.stateImage.layer.cornerRadius=20/2.0f; //设置为图片宽度的一半出来为圆形
        self.stateImage.layer.borderWidth=2.0f; //边框宽度
        self.stateImage.layer.borderColor=[[UIColor redColor] CGColor];//边框颜色
        
        
        self.time = [[UILabel alloc] initWithFrame:CGRectMake(40,5,Main_Screen_Width-40,25)];
        self.time.font = [UIFont systemFontOfSize:14];
        self.time.textAlignment = NSTextAlignmentLeft;
        
        [self.contentView addSubview:self.time];
        
        
        self.message = [[UILabel alloc] initWithFrame:CGRectMake(40,35,Main_Screen_Width-70,60)];
        self.message.font = [UIFont systemFontOfSize:14];
        self.message.textAlignment = NSTextAlignmentLeft;
       
        self.message.numberOfLines=0;
        [self.contentView addSubview:self.message];



    }
    return self;
}
-(void)config:(Message *)mm{
    self.stateImage.backgroundColor=[UIColor redColor];
    self.time.textColor = [UIColor blackColor];
    self.message.textColor = [UIColor blackColor];
    self.time.text=mm.time;
    self.message.text=mm.messgae;

}
-(void)configFirst:(Message *)mm{
    self.stateImage.backgroundColor=[UIColor whiteColor];
    self.time.textColor = [UIColor redColor];
    self.message.textColor = [UIColor redColor];

    self.time.text=mm.time;
    self.message.text=mm.messgae;

}
- (void)drawRect:(CGRect)rect {
    CGContextRef context =UIGraphicsGetCurrentContext();
    // 样式
    CGContextSetLineCap(context, kCGLineCapRound);
    // 宽度
    CGContextSetLineWidth(context, 1.0);
    // 颜色
    CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
    // 开始绘制
    CGContextBeginPath(context);
    // 虚线起点 设置（x, y）控制横竖、位置
    CGContextMoveToPoint(context, 30, 1);
    // 虚线宽度，间距宽度
    CGFloat lengths[] = {2, 2};
    // 虚线的起始点
    CGContextSetLineDash(context, 0, lengths, 2);
    // 虚线终点 设置（x, y）控制横竖、位置
    CGContextAddLineToPoint(context, 30, CGRectGetMaxY(self.bounds));
    // 绘制
    CGContextStrokePath(context);
    // 关闭图像
    //CGContextClosePath(context);
}
@end
