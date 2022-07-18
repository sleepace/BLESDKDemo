//
//  ConfigureAPNViewController.m
//  BLESDKDemo
//
//  Created by San on 24/6/2022.
//  Copyright © 2022 medica. All rights reserved.
//

#import "ConfigureAPNViewController.h"
#import "ScanDeviceViewController.h"
#import "MBProgressHUD.h"

@interface ConfigureAPNViewController ()<ScanDeviceDelegate,UITextFieldDelegate>
{
    SLPPeripheralInfo *currentPer;
    SLPBleWifiConfig *con;
}
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *label1;
@property (nonatomic,weak) IBOutlet UILabel *label2;
@property (nonatomic,weak) IBOutlet UILabel *label3;
@property (nonatomic,weak) IBOutlet UILabel *label4;
@property (nonatomic,weak) IBOutlet UILabel *label5;
@property (nonatomic,weak) IBOutlet UITextField *textfield1;
@property (nonatomic,weak) IBOutlet UIButton *configureBT;


@end

@implementation ConfigureAPNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    
    con= [[SLPBleWifiConfig alloc]init];
}

- (void)setUI{
    self.titleLabel.text = @"设置APN";
    self.label1.text = NSLocalizedString(@"select_device", nil);
    self.label2.text = NSLocalizedString(@"select_device", nil);
    self.label4.text = NSLocalizedString(@"请联系SIM卡提供商提供APN", nil);
    self.label5.text = NSLocalizedString(@"若您使用的SIM卡是定向卡，需要将APN设置给设备", nil);
    
    self.textfield1.placeholder = NSLocalizedString(@"APN", nil);
    self.textfield1.delegate = self;
    
    [self.configureBT setTitle:NSLocalizedString(@"设置", nil) forState:UIControlStateNormal];
    self.configureBT.layer.cornerRadius =25.0f;
}

- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -ScanDeviceDelegate
- (void)didSelectPeripheal:(SLPPeripheralInfo *)peripheralInfo
{
    self.label3.text = peripheralInfo.name;
    currentPer = peripheralInfo;
    [self didSelectDeviceType:peripheralInfo.name];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTextfiled];
}

- (IBAction)pushToSelectDeviceView:(id)sender {
    [self resignTextfiled];
    ScanDeviceViewController *scanVC = [[ScanDeviceViewController alloc]initWithNibName:@"ScanDeviceViewController" bundle:nil];
    scanVC.delegate = self;
    [self.navigationController pushViewController:scanVC animated:YES];
}



- (IBAction)configureAction:(id)sender {
    
//    if (self.textfield1.text.length == 0){
//        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:@"APN不能为空" delegate:nil cancelButtonTitle:@"Confirm" otherButtonTitles:nil, nil];;
//        [alertview show];
//        return;
//    }
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [con configPeripheral:currentPer.peripheral deviceType:self.deviceType apn:self.textfield1.text user:nil password:nil completion:^(SLPDataTransferStatus status, id data) {
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        NSString *result=@"";
        if (status == SLPDataTransferStatus_Succeed) {
            NSLog(@"send succeed!");
            result = NSLocalizedString(@"APN设置成功", nil);
        }
        else
        {
            NSLog(@"send failed!");
            result = NSLocalizedString(@"APN设置失败", nil);
        }

        UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:result delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
        [alertview show];
        
    }];
}

- (void)didSelectDeviceType:(NSString *)devicename{
    if ([devicename hasPrefix:@"SA11"])
    {
        self.deviceType = SLPDeviceType_Sal;
    }
    else if ([devicename hasPrefix:@"EW1W"])
    {
        self.deviceType = SLPDeviceType_EW201W;
    }
    else if ([devicename hasPrefix:@"M8"])
    {
        self.deviceType = SLPDeviceType_M800;
    }
    else if ([devicename hasPrefix:@"SN91E"])
    {
        self.deviceType = SLPDeviceType_SN913E;
    }
    else if ([devicename hasPrefix:@"BM8721"])
    {
        self.deviceType = SLPDeviceType_BM8701;
    }
    else if ([devicename hasPrefix:@"BM8722"])
    {
        self.deviceType = SLPDeviceType_BM8701_2;
    }
    else if ([devicename hasPrefix:@"BM871W"])
    {
        self.deviceType = SLPDeviceType_M8701W;
    }
    else if ([devicename hasPrefix:@"FH61W"])
    {
        self.deviceType = SLPDeviceType_FH601W;
    }
    else if ([devicename hasPrefix:@"BG01A"])
    {
        self.deviceType = SLPDeviceType_BG001A;
    }
    else if ([devicename hasPrefix:@"SN22"])
    {
        self.deviceType = SLPDeviceType_NOX2_WiFi;
    }
    else if ([devicename hasPrefix:@"EW22W"])
    {
        self.deviceType = SLPDeviceType_EW202W;
    }
    else if ([devicename hasPrefix:@"Z40TWP"])
    {
        self.deviceType = SLPDeviceType_TWP2;
    }
    else if ([devicename hasPrefix:@"ZTW3"])
    {
        self.deviceType = SLPDeviceType_TWP3;
    }
    else if ([devicename hasPrefix:@"SM100"])
    {
        self.deviceType = SLPDeviceType_SM100;
    }
    else if ([devicename hasPrefix:@"SM200"])
    {
        self.deviceType = SLPDeviceType_SM200;
    }
    else if ([devicename hasPrefix:@"SM300"])
    {
        self.deviceType = SLPDeviceType_SM300;
    }
    else if ([devicename hasPrefix:@"M901"])
    {
        self.deviceType = SLPDeviceType_M901L;
    }
//    else if ([devicename hasPrefix:@"BG02"])
//    {
//        self.deviceType = SLPDeviceType_BG002;
//    }
    else {
        self.deviceType = SLPDeviceType_WIFIReston;
    }
}


- (void)resignTextfiled
{
    if (self.textfield1.isEditing) {
        [self.textfield1 resignFirstResponder];
    }
}

@end
