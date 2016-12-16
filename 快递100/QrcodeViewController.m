//
//  QrcodeViewController.m
//  EP-T
//
//  Created by 刘锐 on 15-1-21.
//  Copyright (c) 2015年 刘锐. All rights reserved.
//

#import "QrcodeViewController.h"
#import "UIViewExt.h"
@interface QrcodeViewController ()

@end

@implementation QrcodeViewController
{
    UIImageView * imageView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor lightGrayColor];

    self.title =@"扫描";
    //设置返回键
    UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
    [backButton setBackgroundImage:[UIImage imageNamed:@"top_bar_return@2x"] forState:UIControlStateNormal];
    backButton.frame=CGRectMake(0,0, 30, 30);
    [backButton addTarget:self action:@selector(clcikBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem=backButtonItem;
    
    
    imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 300, 300)];
    imageView.image = [UIImage imageNamed:@"pick_bg"];
    imageView.center = CGPointMake(self.view.center.x, self.view.center.y);
    [self.view addSubview:imageView];
    
    upOrdown = NO;
    num =0;
    _line = [[UIImageView alloc] initWithFrame:CGRectMake(imageView.frame.origin.x+40,imageView.frame.origin.y+10, 220, 2)];
    _line.image = [UIImage imageNamed:@"line.png"];
    [self.view addSubview:_line];
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.02 target:self selector:@selector(animation1) userInfo:nil repeats:YES];
}

-(void)animation1
{
    if (upOrdown == NO) {
        num ++;
        _line.frame = CGRectMake(imageView.frame.origin.x+40, imageView.frame.origin.y+10+2*num, 220, 2);
        if (2*num == 280) {
            upOrdown = YES;
        }
    }
    else {
        num --;
        _line.frame = CGRectMake(imageView.frame.origin.x+40, imageView.frame.origin.y+10+2*num, 220, 2);
        if (num == 0) {
            upOrdown = NO;
        }
    }
    
}
-(void)backAction
{
    
    [self dismissViewControllerAnimated:YES completion:^{
        [timer invalidate];
    }];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setupCamera];
}
- (void)setupCamera
{
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    if ([_output.availableMetadataObjectTypes containsObject:
         AVMetadataObjectTypeQRCode]||
        [_output.availableMetadataObjectTypes containsObject:
         AVMetadataObjectTypeCode128Code]) {
            _output.metadataObjectTypes =[NSArray arrayWithObjects:
                                          AVMetadataObjectTypeQRCode,
                                          AVMetadataObjectTypeCode39Code,
                                          AVMetadataObjectTypeCode128Code,
                                          AVMetadataObjectTypeCode39Mod43Code, 
                                          AVMetadataObjectTypeEAN13Code, 
                                          AVMetadataObjectTypeEAN8Code, 
                                          AVMetadataObjectTypeCode93Code, nil]; 
        }
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:self.session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
//    _preview.frame =CGRectMake((self.view.frame.size.width-280)/2,(self.view.frame.size.height-280)/2,280,280);
    _preview.frame = CGRectMake(imageView.frame.origin.x+10, imageView.frame.origin.y+10, 280, 280);
    [self.view.layer insertSublayer:self.preview atIndex:0];
    
    
    // Start
    [_session startRunning];
}
#pragma mark AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    
    NSString *stringValue;
    
    if ([metadataObjects count] >0)
    {
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"%@",stringValue);
        NSArray * array = [stringValue componentsSeparatedByString:@"@"];
        if (array.count==3) {
            NSString *WebServerName,*WcfServerName,*SoftName;
         
            WebServerName = [array objectAtIndex:0];
            WcfServerName = [array objectAtIndex:1];
            SoftName = [array objectAtIndex:2];
            [self.delegate QrOver:WebServerName :WcfServerName :SoftName];
        }
    }
    [_session stopRunning];
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^
     {
         [timer invalidate];
         
     }];
}

//点击返回按键
- (void)clcikBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
