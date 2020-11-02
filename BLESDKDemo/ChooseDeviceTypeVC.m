//
//  ChooseDeviceTypeVC.m
//  BLESDKDemo
//
//  Created by Martin on 14/9/18.
//  Copyright © 2018年 medica. All rights reserved.
//

#import "ChooseDeviceTypeVC.h"
#import <BLEWifiConfig/SLPBleWifiConfig.h>
#import "SetServerViewController.h"

@interface ChooseDeviceTypeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSArray<DeviceInfo *> *deviceInfoList;
@end

@implementation ChooseDeviceTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"选择设备种类"];
    self.deviceInfoList =
    @[
      [DeviceInfo deviceInfoWith:@"Z300" deviceType:SLPDeviceType_WIFIReston],
      [DeviceInfo deviceInfoWith:@"SA1001" deviceType:SLPDeviceType_Sal],
      [DeviceInfo deviceInfoWith:@"EW201W" deviceType:SLPDeviceType_EW201W],
      [DeviceInfo deviceInfoWith:@"M800" deviceType:SLPDeviceType_M800],
      [DeviceInfo deviceInfoWith:@"SN913E" deviceType:SLPDeviceType_SN913E],
      [DeviceInfo deviceInfoWith:@"BM8701-2" deviceType:SLPDeviceType_BM8701_2],
      [DeviceInfo deviceInfoWith:@"BG001A" deviceType:SLPDeviceType_BG001A],
      [DeviceInfo deviceInfoWith:@"M8701W" deviceType:SLPDeviceType_M8701W],
      [DeviceInfo deviceInfoWith:@"BM8701" deviceType:SLPDeviceType_BM8701],
      [DeviceInfo deviceInfoWith:@"FH601W" deviceType:SLPDeviceType_FH601W],
      ];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.deviceInfoList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    DeviceInfo *info = [self.deviceInfoList objectAtIndex:indexPath.row];
    [cell.textLabel setText:info.title];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DeviceInfo *info = [self.deviceInfoList objectAtIndex:indexPath.row];
    SetServerViewController *vc = [[SetServerViewController alloc] initWithNibName:@"SetServerViewController" bundle:nil];
    vc.deviceType = info.deviceType;
    [self.navigationController pushViewController:vc animated:YES];
}
@end

@implementation DeviceInfo
+ (DeviceInfo *)deviceInfoWith:(NSString *)title deviceType:(int)deviceType {
    DeviceInfo *info = [DeviceInfo new];
    [info setTitle:title];
    [info setDeviceType:deviceType];
    return info;
}
@end
