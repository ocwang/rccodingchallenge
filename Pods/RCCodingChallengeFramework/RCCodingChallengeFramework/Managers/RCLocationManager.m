//
//  RCLocationManager.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCLocationManager.h"
#import "../Supporting/RCErrorHelper.h"

@interface RCLocationManager () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign, getter=isInitialAuthorizationRequest) BOOL initialAuthorizationRequest;
@property (nonatomic, copy, nullable) void (^locationHandler)(CLLocation *location, NSError *error);

@end

@implementation RCLocationManager

- (instancetype)init {
    if (self = [super init]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        self.locationManager.delegate = self;
        
        self.initialAuthorizationRequest = [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined;
    }
    
    return self;
}

- (void)getLocationWithHandler:(void (^_Nonnull)(CLLocation *location, NSError *error))handler {
    self.locationHandler = handler;
    
    switch ([CLLocationManager authorizationStatus]) {
        case kCLAuthorizationStatusNotDetermined:
            [self.locationManager requestWhenInUseAuthorization];
            break;
            
        case kCLAuthorizationStatusDenied:
            [self handleErrorWithCode:kRCErrorLocationPermissionDenied];
            break;
            
        case kCLAuthorizationStatusAuthorizedAlways:
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            [self.locationManager requestLocation];
            break;
            
        default:
            [self handleErrorWithCode:kRCErrorUnknown];
            break;
    }
}

# pragma mark - CLLocationManagerDelegate Methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    if (!locations || !locations.count) {
        [self handleErrorWithCode:kRCErrorLocationNotFound];
        return;
    }
    
    if (self.locationHandler) {
        self.locationHandler([locations firstObject], nil);
        self.locationHandler = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if (self.locationHandler) {
        self.locationHandler(nil, error);
        self.locationHandler = nil;
    }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (self.isInitialAuthorizationRequest && status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self.locationManager requestLocation];
    }
}

# pragma mark - Error Handling

- (void)handleErrorWithCode:(RCError)code {
    if (self.locationHandler) {
        NSError *error = [RCErrorHelper errorWithCode:code];
        
        self.locationHandler(nil, error);
        self.locationHandler = nil;
    }
}

@end
