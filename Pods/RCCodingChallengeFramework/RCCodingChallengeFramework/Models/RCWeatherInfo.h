//
//  RCWeatherInfo.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/25/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RCWeatherInfo: NSObject

@property (strong, nonatomic) NSString *cityName;
@property (strong, nonatomic) CLLocation *location;
@property (strong, nonatomic) NSString *currentWeather;
@property (strong, nonatomic) NSNumber *temperature;
@property (strong, nonatomic) NSNumber *maxTemperature;
@property (strong, nonatomic) NSNumber *minTemperature;
@property (strong, nonatomic) NSNumber *humidity;

- (id)initWithJSON:(NSDictionary *)json;

@end

NS_ASSUME_NONNULL_END
