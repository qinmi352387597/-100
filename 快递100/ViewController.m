//
//  ViewController.m
//  快递100
//
//  Created by admin on 2016/12/15.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "HttpEngine.h"



@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
}
- (void)clcikBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)initUI{
    self.title=@"物流详情";
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"top_bar_return@2x"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0,0, 30, 30);
    [backButton addTarget:self action:@selector(clcikBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backButtonItem;
    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    [self.view addSubview: self.tableView];
    
}

-(TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cellid"];
    if (!cell) {
        cell=[[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellid"];
        
    }
    if (indexPath.row==0) {
        [cell configFirst:self.dataSource[self.dataSource.count-1- indexPath.row]];
    }
    else
        [cell config:self.dataSource[self.dataSource.count-1- indexPath.row]];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, Main_Screen_Width, 60)];
    
    UILabel* yundanhao = [[UILabel alloc] initWithFrame:CGRectMake(20,10,Main_Screen_Width-20,20)];
    yundanhao.font = [UIFont systemFontOfSize:14];
    yundanhao.textAlignment = NSTextAlignmentLeft;
    [view addSubview:yundanhao];
    yundanhao.text=self.ShipperCode;
    
    UILabel * name = [[UILabel alloc] initWithFrame:CGRectMake(20,35,Main_Screen_Width-20,20)];
    name.font = [UIFont systemFontOfSize:14];
    name.textAlignment = NSTextAlignmentLeft;
    [view addSubview:name];
    
    name.text=self.ShipperName;

    return view;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70;

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 100;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
