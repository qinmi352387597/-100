//
//  QrcodeViewController.h
//  EP-T
//
//  Created by 刘锐 on 15-1-21.
//  Copyright (c) 2015年 刘锐. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@protocol QrcodeViewControllerDelegate <NSObject>

- (void)QrOver:(NSString*)web :(NSString*)wcf :(NSString*)softName;

@end

@interface QrcodeViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    int num;
    BOOL upOrdown;
    NSTimer * timer;
}
@property (assign,nonatomic)id<QrcodeViewControllerDelegate>delegate;
@property (strong,nonatomic)AVCaptureDevice * device;
@property (strong,nonatomic)AVCaptureDeviceInput * input;
@property (strong,nonatomic)AVCaptureMetadataOutput * output;
@property (strong,nonatomic)AVCaptureSession * session;
@property (strong,nonatomic)AVCaptureVideoPreviewLayer * preview;
@property (nonatomic, strong) UIImageView * line;
@end
