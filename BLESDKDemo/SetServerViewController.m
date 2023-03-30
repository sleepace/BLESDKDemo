//
//  SetServerViewController.m
//  BLESDKDemo
//
//  Created by Martin on 14/9/18.
//  Copyright © 2018年 medica. All rights reserved.
//

#import "SetServerViewController.h"
#import <BLEWifiConfig/SLPBleWifiConfig.h>
#import "ConfigureWiFiViewController.h"

@interface SetServerViewController ()
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *serverLabel;
@property (nonatomic, weak) IBOutlet UITextField *serverTextfield;
@property (nonatomic, weak) IBOutlet UILabel *portLabel;
@property (nonatomic, weak) IBOutlet UITextField *portTextField;

@end

@implementation SetServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"Set Server"];
    [self setUI];
}

- (BOOL)needPort {
    BOOL needPort = YES;
    switch (self.deviceType) {
        case SLPDeviceType_WIFIReston:
        case SLPDeviceType_Sal:
            needPort = NO;
            break;
        default:
            break;
    }
    return needPort;
}

- (void)setUI {
    BOOL showPort = [self needPort];
    [self.portLabel setHidden:!showPort];
    [self.portTextField setHidden:!showPort];
    
    self.serverLabel.text = @"Server Address";
    self.serverTextfield.text = @"120.24.169.204";
    self.portLabel.text = @"Port";
    self.portTextField.keyboardType = UIKeyboardTypeNumberPad;
    self.portTextField.text = @"9010";
    if ([[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"]&&[[NSUserDefaults standardUserDefaults] objectForKey:@"port"]) {
        self.serverTextfield.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"IPAddress"];
        self.portTextField.text = [[NSUserDefaults standardUserDefaults] objectForKey:@"port"];
    }
    
    if (!showPort) {
        self.serverTextfield.text = @"https://webapi.test.sleepace.net";
        self.portTextField.text = @"0";
    }
}

- (IBAction)back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)next:(id)sender {
    if (self.serverTextfield.text.length == 0){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"service_nil", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil, nil];;
        [alertview show];
        return;
    }
    
    if (self.portTextField.text.length == 0){
        UIAlertView *alertview = [[UIAlertView alloc] initWithTitle:nil message:NSLocalizedString(@"port_nil", nil) delegate:nil cancelButtonTitle:NSLocalizedString(@"btn_ok", nil) otherButtonTitles:nil, nil];;
        [alertview show];
        return;
    }
    //save service address
    [[NSUserDefaults standardUserDefaults] setObject:self.serverTextfield.text forKey:@"IPAddress"];
    [[NSUserDefaults standardUserDefaults] setObject:self.portTextField.text forKey:@"port"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    ConfigureWiFiViewController *vc = [[ConfigureWiFiViewController alloc] initWithNibName:@"ConfigureWiFiViewController" bundle:nil];
    [vc setDeviceType:self.deviceType];
    [vc setServerAddress:self.serverTextfield.text];
    [vc setPort:self.portTextField.text.intValue];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.serverTextfield resignFirstResponder];
    [self.portTextField resignFirstResponder];
}
@end
