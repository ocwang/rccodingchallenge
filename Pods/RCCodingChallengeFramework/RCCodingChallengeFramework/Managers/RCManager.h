//
//  RCManager.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/25/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "RCWeatherInfo.h"

NS_ASSUME_NONNULL_BEGIN

/*
 Limit public interface of RCCodingChallengeFramework to RCManager
 singleton and the instance methods provided below
 */
@interface RCManager : NSObject

+ (id)sharedManager;

- (void)currentLocationWithHandler:(void (^_Nonnull)(CLLocation * _Nullable location, NSError * _Nullable error))handler;
- (void)batteryInfoWithHandler:(void (^_Nonnull)(BOOL isPluggedIn, float batteryLevel, NSError * _Nullable error))handler;
- (void)weatherForCurrentLocationWithHandler:(void (^_Nonnull)(RCWeatherInfo * _Nullable weatherInfo, NSError * _Nullable error))handler;

@end

NS_ASSUME_NONNULL_END
