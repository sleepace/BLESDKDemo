//
//  ConfigureWiFiViewController.m
//  WiFiSDKDemo
//
//  Created by San on 2018/1/25.
//  Copyright © 2018年 medica. All rights reserved.
//

#import "ConfigureWiFiViewController.h"
#import "ScanDeviceViewController.h"
#import "MBProgressHUD.h"

@interface ConfigureWiFiViewController ()<ScanDeviceDelegate,UITextFieldDelegate>
{
    SLPPeripheralInfo *currentPer;
    SLPBleWifiConfig *con;
}
@property (nonatomic,weak) IBOutlet UILabel *titleLabel;
@property (nonatomic,weak) IBOutlet UILabel *label1;
@property (nonatomic,weak) IBOutlet UILabel *label2;
@property (nonatomic,weak) IBOutlet UILabel *label3;
@property (nonatomic,weak) IBOutlet UILabel *label4;
@property (nonatomic,weak) IBOutlet UILabel *label5;
@property (nonatomic,weak) IBOutlet UILabel *label6;
@property (nonatomic,weak) IBOutlet UILabel *label7;
@property (nonatomic,weak) IBOutlet UILabel *label8;
@property (nonatomic,weak) IBOutlet UITextField *textfield1;
@property (nonatomic,weak) IBOutlet UITextField *textfield2;
@property (nonatomic,weak) IBOutlet UITextField *textfield3;
@property (nonatomic,weak) IBOutlet UITextField *textfield4;
@property (nonatomic,weak) IBOutlet UIButton *configureBT;
@property (nonatomic,weak) IBOutlet  UIView *view1;

@property (nonatomic,weak) IBOutlet UILabel *version;

@end

@implementation ConfigureWiFiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUI];
    
    con= [[SLPBleWifiConfig alloc]init];
}


- (void)setUI
{
    self.titleLabel.text =NSLocalizedString(@"demo_name_ble_wifi", nil);
    self.label1.text = NSLocalizedString(@"step1", nil);
    self.label2.text = NSLocalizedString(@"select_device", nil);
    self.label3.text = NSLocalizedString(@"select_device", nil);
    //    self.label4.text = @"设备连接的WiFi";
    self.label5.text = NSLocalizedString(@"step3", nil);
    self.label6.text = NSLocalizedString(@"select_wifi", nil);
    
    self.label7.text = NSLocalizedString(@"step2", nil);
    self.label8.text = NSLocalizedString(@"ip_address", nil);
    
    self.version.text = [NSString stringWithFormat:@"V %@",[[[NSBundle mainBundle]infoDictionary]objectForKey:@"CFBundleShortVersionString"]];
    
    [self.configureBT setTitle:NSLocalizedString(@"pair_wifi", nil) forState:UIControlStateNormal];
    self.configureBT.layer.cornerRadius =25.0f;
    
    self.view1.layer.cornerRadius = 4.0f;
    self.view1.layer.borderColor = [UIColor colorWithRed:195/255.0 green:203/255.0f blue:214/255.0f alpha:1.0].CGColor;
    self.view1.layer.borderWidth = 1.0f;
    
    self.textfield1.placeholder = NSLocalizedString(@"input_wifi_name", nil);
    self.textfield2.placeholder = NSLocalizedString(@"input_wifi_psw", nil);
    
    self.deviceType = SLPDeviceType_WIFIReston;
    //default
    self.textfield3.text = @"sensor.smt.dev.benesse-style-care.co.jp";
    self.textfield4.text = @"28070";
    
    self.textfield1.delegate = self;
    self.textfield2.delegate = self;
    self.textfield3.delegate = self;
    self.textfield4.delegate = self;
//        self.textfield1.text = @"SAN";
//        self.textfield2.text = @"l1234567890";
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"WiFiName"]) {
        self.textfield1.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"WiFiName"];
    }
    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"Passoword"]) {
        self.textfield2.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"Passoword"];
    }
    
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"IPAddress"]) {
//        self.textfield3.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"IPAddress"];
//    }
//    if ([[NSUserDefaults standardUserDefaults]objectForKey:@"port"]) {
//        self.textfield4.text = [[NSUserDefaults standardUserDefaults]objectForKey:@"port"];
//    }
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
//    else if ([devicename hasPrefix:@"M8"])
//    {
//        self.deviceType = SLPDeviceType_M800;
//    }
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
    else if ([devicename hasPrefix:@"M871W"])
    {
        self.deviceType = SLPDeviceType_M8701W_BSC;
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
    else if ([devicename hasPrefix:@"SDC"])
    {
        self.deviceType = SLPDeviceType_SDC100;
    }
//    else if ([devicename hasPrefix:@"BG02"])
//    {
//        self.deviceType = SLPDeviceType_BG002;
//    }
    else {
        self.deviceType = SLPDeviceType_WIFIReston;
    }
}

- (IBAction)pushToSelectDeviceView:(id)sender {
    [self resignTextfiled];
    ScanDeviceViewController *scanVC = [[ScanDeviceViewController alloc]initWithNibName:@"ScanDeviceViewController" bundle:nil];
    scanVC.delegate = self;
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (IBAction)configureAction:(id)sender {
    
    if (![SLPBLESharedManager blueToothIsOpen]) {
        NSString *message = NSLocalizedString(@"reminder_connect_ble", nil);
        UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
        [alertview show];
        return ;
    }
    if (!self.label4.text.length) {
        NSString *message = NSLocalizedString(@"select_device", nil);
        UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
        [alertview show];
        return ;
    }
    if (!self.textfield1.text.length) {
        NSString *message = NSLocalizedString(@"input_wifi_name", nil);
        UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
        [alertview show];
        return ;
    }
    
    if (self.textfield3.text.length == 0&&self.deviceType !=SLPDeviceType_NOX2_WiFi){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"service_nil", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil, nil];;
        [alertview show];
        return;
    }
    
    if (self.textfield4.text.length == 0&&self.deviceType !=SLPDeviceType_NOX2_WiFi){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"port_nil", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil, nil];;
        [alertview show];
        return;
    }
    //save service address
    [[NSUserDefaults standardUserDefaults] setObject:self.textfield3.text forKey:@"IPAddress"];
    [[NSUserDefaults standardUserDefaults] setObject:self.textfield4.text forKey:@"port"];
    [[NSUserDefaults standardUserDefaults] setObject:self.textfield1.text forKey:@"WiFiName"];
    [[NSUserDefaults standardUserDefaults] setObject:self.textfield2.text forKey:@"Passoword"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    if (self.deviceType == SLPDeviceType_NOX2_WiFi) {
        [con configPeripheral:currentPer.peripheral deviceType:self.deviceType wifiName:self.textfield1.text password:self.textfield2.text completion:^(SLPDataTransferStatus status, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *result=@"";
            if (status == SLPDataTransferStatus_Succeed) {
                NSLog(@"send succeed!");
                result = NSLocalizedString(@"reminder_configuration_success", nil);
            }
            else
            {
                NSLog(@"send failed!");
                result = NSLocalizedString(@"reminder_configuration_fail", nil);
            }

            UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:result delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
            [alertview show];
        }];
    }
    else
    {
        [con configPeripheral:currentPer.peripheral deviceType:self.deviceType serverAddress:self.textfield3.text port:[self.textfield4.text integerValue] wifiName:self.textfield1.text password:self.textfield2.text completion:^(SLPDataTransferStatus status, id data) {
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            NSString *result=@"";
            if (status == SLPDataTransferStatus_Succeed) {
                NSLog(@"send succeed!");
                result = NSLocalizedString(@"reminder_configuration_success", nil);
                //            SLPDeviceInfo *deviceInfo= (SLPDeviceInfo *)data;
                //            result =[NSString stringWithFormat:@"deviceId=%@,version=%@",deviceInfo.deviceID,deviceInfo.version];
            }
            else
            {
                NSLog(@"send failed!");
                result = NSLocalizedString(@"reminder_configuration_fail", nil);
            }

            UIAlertView *alertview =[[ UIAlertView alloc]initWithTitle:nil message:result delegate:self cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles: nil];
            [alertview show];
        }];
    }
}


- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.5 animations:^{
        CGRect rect=self.view.frame;
        CGFloat y_value=rect.origin.y-180;
        rect.origin.y=y_value;
        self.view.frame=rect;
    }];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:0.3 animations:^{
        CGRect rect=self.view.frame;
        CGFloat y_value=rect.origin.y+180;
        rect.origin.y=y_value;
        self.view.frame=rect;
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    CGRect rect=self.view.frame;
    CGFloat y_value=0;
    rect.origin.y=y_value;
    self.view.frame=rect;
}

- (IBAction)back:(id)sender {
    if (currentPer.peripheral) {
        [SLPBLESharedManager disconnectPeripheral:currentPer.peripheral timeout:0 completion:nil];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -ScanDeviceDelegate
- (void)didSelectPeripheal:(SLPPeripheralInfo *)peripheralInfo
{
    self.label4.text = peripheralInfo.name;
    currentPer = peripheralInfo;
    [self didSelectDeviceType:peripheralInfo.name];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self resignTextfiled];
}

- (void)resignTextfiled
{
    if (self.textfield1.isEditing) {
        [self.textfield1 resignFirstResponder];
    }
    if (self.textfield2.isEditing) {
        [self.textfield2 resignFirstResponder];
    }
    
    if (self.textfield3.isEditing) {
        [self.textfield3 resignFirstResponder];
    }
    if (self.textfield4.isEditing) {
        [self.textfield4 resignFirstResponder];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
