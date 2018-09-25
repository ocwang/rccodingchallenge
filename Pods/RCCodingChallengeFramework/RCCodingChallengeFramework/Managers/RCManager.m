//
//  RCManager.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/25/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCManager.h"
#import "RCLocationManager.h"
#import "RCDeviceManager.h"
#import "../Services/RCWeatherService.h"
#import "../Supporting/RCErrorHelper.h"

@interface RCManager ()

@property (nonatomic, strong) RCLocationManager *locationManager;
@property (nonatomic, strong) RCDeviceManager *deviceManager;

@end

@implementation RCManager

# pragma mark - Singleton

// use singleton to keep reference to shared state of location and
// device managers
+ (id)sharedManager {
    static RCManager *sharedInstance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
}

# pragma mark - Init

- (id)init {
    if (self = [super init]) {
        self.locationManager = [[RCLocationManager alloc] init];
        self.deviceManager = [[RCDeviceManager alloc] init];
    }
    
    return self;
}

# pragma mark - Methods

- (void)currentLocationWithHandler:(void (^_Nonnull)(CLLocation *location, NSError *error))handler {
    // user must have iOS 9 or above for requestLocations API
    if (@available(iOS 9.0, *)) {
        [self.locationManager getLocationWithHandler:handler];
    } else {
        NSError *error = [RCErrorHelper errorWithCode:kRCErrorOSVersionUnsupported];
        handler(nil, error);
    }
}

- (void)batteryInfoWithHandler:(void (^_Nonnull)(BOOL isPluggedIn, float batteryLevel, NSError *error))handler {
    [self.deviceManager getBatteryInfoWithHandler:handler];
}

- (void)weatherForCurrentLocationWithHandler:(void (^_Nonnull)(RCWeatherInfo *weatherInfo, NSError *error))handler {
    [self currentLocationWithHandler:^(CLLocation * _Nullable location, NSError * _Nullable error) {
        if (error) {
            handler(nil, error);
            return;
        }
        
        [RCWeatherService getWeatherForLocation:location withHandler:handler];
    }];
}

@end
