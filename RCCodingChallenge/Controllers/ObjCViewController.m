//
//  ObjCViewController.m
//  RCCodingChallenge
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "ObjCViewController.h"
#import <RCCodingChallengeFramework/RCCodingChallengeFramework.h>

@interface ObjCViewController ()

@property (nonatomic, strong) RCManager *sharedManager;

@property (strong, nonatomic) IBOutlet UILabel *displayLabel;

@end

@implementation ObjCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.sharedManager = [RCManager sharedManager];
}

- (IBAction)getLocationButtonTapped:(UIButton *)sender {
    // use weak self to prevent retain cycles on escaping block
    __weak typeof(self) weakSelf = self;
    [self.sharedManager currentLocationWithHandler:^(CLLocation * _Nullable location, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
            strongSelf.displayLabel.text = error.localizedDescription;
            return;
        }
        
        strongSelf.displayLabel.text = [[NSString alloc] initWithFormat:@"Lng: %f Lat: %f", location.coordinate.longitude, location.coordinate.latitude];
    }];
}

- (IBAction)getBatteryInfoButtonTapped:(UIButton *)sender {
    // technically doesn't need weak-strong dance because block never escapes
    // but usually we wouldn't know implementation details of framework
    __weak typeof(self) weakSelf = self;
    [self.sharedManager batteryInfoWithHandler:^(BOOL isPluggedIn, float batteryLevel, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
            strongSelf.displayLabel.text = error.localizedDescription;
            return;
        }
        
        strongSelf.displayLabel.text = [[NSString alloc] initWithFormat:@"Is Plugged In: %@ Battery Level: %f", isPluggedIn ? @"Yes" : @"No", batteryLevel];
    }];
}

- (IBAction)getWeatherButtonTapped:(UIButton *)sender {
    // technically doesn't need weak-strong dance because block never escapes
    // but usually we wouldn't know implementation details of framework
    __weak typeof(self) weakSelf = self;
    [self.sharedManager weatherForCurrentLocationWithHandler:^(RCWeatherInfo * _Nullable weatherInfo, NSError * _Nullable error) {
        __strong typeof(self) strongSelf = weakSelf;
        if (error) {
            NSLog(@"Error %@", error.localizedDescription);
            dispatch_async(dispatch_get_main_queue(), ^{
                strongSelf.displayLabel.text = error.localizedDescription;
            });
            return;
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            strongSelf.displayLabel.text = [[NSString alloc] initWithFormat:@"%@ has a current forecast of %@ with a temperature of %@.", weatherInfo.cityName, weatherInfo.currentWeather, weatherInfo.temperature];
        });
        
    }];
}

@end
