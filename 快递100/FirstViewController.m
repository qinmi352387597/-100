//
//  FirstViewController.m
//  快递100
//
//  Created by admin on 2016/12/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "FirstViewController.h"
#import "HttpEngine.h"
#import "Shippers.h"
#import "SelectedViewController.h"
#import "ViewController.h"
#import "ExpressPhoneNumViewController.h"
#import "QrcodeViewController.h"
#import "DataBaseManager.h"
#import "ExpressHistoryViewController.h"
@interface FirstViewController ()<ChooseShipperDelegate>
@property (weak, nonatomic) IBOutlet UITextField *TittleLabel;
@property (weak, nonatomic) IBOutlet UITextField *NumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *CompanyLabel;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn;
@property (weak, nonatomic) IBOutlet UIButton *erweimabTN;
@property (weak, nonatomic) IBOutlet UIButton *searchBtn1;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"快递查询";
    
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:19],
       NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.navigationController.navigationBar.barTintColor=[UIColor blackColor];
    

    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                             action:@selector(hiddenKeyboard)];
    gesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:gesture];
    
    //美化查询按钮
    [_searchBtn.layer setMasksToBounds:YES];
    [_searchBtn.layer setCornerRadius:10.0];//设置矩形的四个圆角半径
    [_searchBtn.layer setBorderWidth:1.0];//设置边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 122.0/255.0, 1.0, 1.0 });
    [_searchBtn.layer setBorderColor:colorref];
    _searchBtn.backgroundColor = [UIColor clearColor];

    self.erweimabTN.hidden=YES;
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

}

#pragma mark 关闭键盘
-(void) hiddenKeyboard{
    [self.TittleLabel resignFirstResponder];
    [self.NumberLabel resignFirstResponder];
    [self.CompanyLabel resignFirstResponder];
}
- (IBAction)searchCompany:(id)sender {
    
    [self hiddenKeyboard];
    
    [SVProgressHUD showWithStatus:@"请求数据中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    if (self.NumberLabel.text.length>5) {
        [self search];
    }else{
     [SVProgressHUD showErrorWithStatus:@"单号有误,请重新输入"];
    }

}
-(void)respenseShiper:(Shippers *)ship{
    self.TittleLabel.text=ship.ShipperName;
    self.CompanyLabel.text=ship.ShipperCode;
}

-(void)search{
    
    [[HttpEngine shareEngine ]post:reqURL LogisticCode:self.NumberLabel.text success:^(id response) {
        if ([response[@"Success"] boolValue]==YES) {
          NSMutableArray * data= [Shippers arrayFromJsonData:response];
            if (data.count>0) {
                SelectedViewController *vc=[[SelectedViewController alloc]init];
                vc.dataSource=data;
                vc.delegate=self;
                [self.navigationController pushViewController:vc animated:YES];
                [SVProgressHUD dismiss];
            }
            else{
             [SVProgressHUD showErrorWithStatus:@"没有获取到物流公司信息"];
            }
            
        }
        else{
          [SVProgressHUD showErrorWithStatus:@"单号错误"];
    
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"网络连接错误"];
        
    }];
}
- (IBAction)searched:(id)sender {
    
    ExpressPhoneNumViewController *vc=[[ExpressPhoneNumViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)saomiao:(id)sender {
    
    QrcodeViewController *vc=[[QrcodeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)history:(id)sender {
    
    
    ExpressHistoryViewController *vc=[[ExpressHistoryViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)searchNumber:(id)sender {
    [self hiddenKeyboard];
    [SVProgressHUD showWithStatus:@"请求数据中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeBlack];
    
    if (self.NumberLabel.text.length>5&&self.CompanyLabel.text.length>1) {
        [self search1];
    }else{
        [SVProgressHUD showErrorWithStatus:@"单号有误,请重新输入"];
        
    }
    
    
}
-(void)search1{

[[HttpEngine shareEngine ]post:reqURL shipperCode:self.CompanyLabel.text LogisticCode:self.NumberLabel.text success:^(id response) {
    
    NSLog(@"%@",response);
    
    if ([response[@"Success"] boolValue]==YES) {
        NSMutableArray * data= [Message arrayFromJsonData:response];
    if (data.count>0) {
        ViewController *vc=[[ViewController alloc]init];
        vc.dataSource=data;
        vc.ShipperName=self.TittleLabel.text;
        vc.ShipperCode=self.NumberLabel.text;
        
        Shippers *shiper=[[Shippers alloc]init];
        DataBaseManager *manager =[DataBaseManager sharedManager];
        shiper.ShipperName=self.TittleLabel.text;
        shiper.ShipperBill=self.CompanyLabel.text;
        shiper.ShipperCode=self.NumberLabel.text;
        [manager insertShippers:shiper];
        
        [manager updateStudent:shiper andWithid:self.NumberLabel.text];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
