//
//  RCDeviceManager.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCDeviceManager.h"
#import <UIKit/UIDevice.h>
#import "../Supporting/RCErrorHelper.h"

@implementation RCDeviceManager

- (instancetype)init {
    if (self = [super init]) {
        UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    }
    
    return self;
}

- (void)getBatteryInfoWithHandler:(void (^_Nonnull)(BOOL isPluggedIn, float batteryLevel, NSError *error))handler {
    if (!UIDevice.currentDevice.batteryMonitoringEnabled) {
        UIDevice.currentDevice.batteryMonitoringEnabled = YES;
    }
    
    switch (UIDevice.currentDevice.batteryState) {
        case UIDeviceBatteryStateUnknown: {
            NSError *error = [RCErrorHelper errorWithCode:kRCErrorBatteryInfoUnknown];
            handler(nil, -1, error);
            break;
        }
        
        case UIDeviceBatteryStateUnplugged:
            handler(NO, UIDevice.currentDevice.batteryLevel, nil);
            break;
            
        case UIDeviceBatteryStateFull:
        case UIDeviceBatteryStateCharging:
            handler(YES, UIDevice.currentDevice.batteryLevel, nil);
            break;
            
        default:
            break;
    }
}

@end
