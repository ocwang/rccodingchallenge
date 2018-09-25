//
//  RCDeviceManager.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/*
 Encapsulate device-related functionality in RCDeviceManager.
 */
@interface RCDeviceManager : NSObject

- (void)getBatteryInfoWithHandler:(void (^_Nonnull)(BOOL isPluggedIn, float batteryLevel, NSError *error))handler;

@end

NS_ASSUME_NONNULL_END
