//
//  ExpressHistoryViewController.m
//  Express
//
//  Created by LeeLom on 16/8/2.
//  Copyright © 2016年 LeeLom. All rights reserved.
//

#import "ExpressHistoryViewController.h"
#import "DataBaseManager.h"
#import "HttpEngine.h"
#import "ViewController.h"
#import <SVProgressHUD.h>
@interface ExpressHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataSource;

@end

@implementation ExpressHistoryViewController
NSMutableArray* expressHistory;
NSString* shipperCode2;//快递名称
NSString* logisticCode2;//快递单号
NSString* expressForUser2;//快递备注
NSArray* expressTraces2;//快递轨迹

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"历史记录";
    self.view.backgroundColor=[UIColor whiteColor];
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"top_bar_return@2x"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0,0, 30, 30);
    [backButton addTarget:self action:@selector(clcikBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backButtonItem;
    self.dataSource=[NSMutableArray new];
    self.dataSource =[[DataBaseManager sharedManager]search];

    self.tableView=[[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview: self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    expressHistory = [[NSMutableArray alloc]init];
    
}
- (void)clcikBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.dataSource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString* cellIdentifierHistory = @"cell";
    UITableViewCell* cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifierHistory];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifierHistory];
    }
    Shippers *shiper=self.dataSource[indexPath.row];
    
    cell.detailTextLabel.text = shiper.ShipperCode;
  
    //detailTextLabel自动换行
    cell.detailTextLabel.lineBreakMode = UILineBreakModeWordWrap;
    cell.detailTextLabel.numberOfLines = 0;
    
    cell.detailTextLabel.font = [UIFont fontWithName:@"Helvetica"  size:11];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    cell.textLabel.textColor = [UIColor colorWithRed:0.0 green:122.0/255.0 blue:1.0 alpha:1.0];
    cell.textLabel.text= [NSString stringWithFormat:@"%@(%@)", shiper.ShipperName,shiper.ShipperBill];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;    return
    cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [SVProgressHUD showWithStatus:@"请求数据中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];

    
    
  Shippers *shipers=self.dataSource[indexPath.row];
    [[HttpEngine shareEngine ]post:reqURL shipperCode:shipers.ShipperBill LogisticCode:shipers.ShipperCode success:^(id response) {
        if ([response[@"Success"] boolValue]==YES) {
            NSMutableArray * data= [Message arrayFromJsonData:response];
            if (data.count>0) {
                ViewController *vc=[[ViewController alloc]init];
                vc.dataSource=data;
                vc.ShipperName=shipers.ShipperName;
                vc.ShipperCode=shipers.ShipperCode;
                
                [self.navigationController pushViewController:vc animated:YES];
                [SVProgressHUD dismiss];
            }
            else{
                [SVProgressHUD showErrorWithStatus:@"没有获取到物流公司信息"];
               
            }
        }
        else{
            [SVProgressHUD showErrorWithStatus:@"运单号错误"];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接失败"];
       
    }];

}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath
{
    Shippers *shiper=self.dataSource[indexPath.row];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        [self.dataSource  removeObjectAtIndex:[indexPath row]];
        
        [self.tableView   deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath]withRowAnimation:UITableViewRowAnimationAutomatic];
        [[DataBaseManager sharedManager]deleteStudentByID:shiper.ShipperCode];
    }
    
}


@end
