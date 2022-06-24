//
//  ConfigureAPNViewController.h
//  BLESDKDemo
//
//  Created by San on 24/6/2022.
//  Copyright © 2022 medica. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BLEWifiConfig/SLPBleWifiConfig.h>

NS_ASSUME_NONNULL_BEGIN

@interface ConfigureAPNViewController : UIViewController
@property (nonatomic, assign) SLPDeviceTypes deviceType;

@end

NS_ASSUME_NONNULL_END
