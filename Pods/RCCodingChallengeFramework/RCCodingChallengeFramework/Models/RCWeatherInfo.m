//
//  RCWeatherInfo.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/25/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCWeatherInfo.h"

@implementation RCWeatherInfo

/*
 Custom failable initializer returns nil if JSON doesn't contain expected data
 or has invalid format
*/
- (id)initWithJSON:(NSDictionary *)json {
    if (self = [super init]) {
        if (!json) {
            return nil;
        }
        
        NSString *cityName = json[@"name"];
        if (!cityName) {
            return nil;
        }
        
        self.cityName = cityName;
        
        NSDictionary *coordinates = json[@"coord"];
        if (!coordinates) {
            return nil;
        }
        
        NSNumber *longitude = coordinates[@"lon"];
        NSNumber *latitude = coordinates[@"lat"];
        self.location = [[CLLocation alloc] initWithLatitude:[longitude doubleValue]
                                                   longitude:[latitude doubleValue]];
        
        NSArray *weatherArray = json[@"weather"];
        if (!weatherArray) {
            return nil;
        }
        
        NSDictionary *weatherInfo = weatherArray[0];
        if (!weatherInfo) {
            return nil;
        }
        
        self.currentWeather = weatherInfo[@"main"];
        
        NSDictionary *temperatureInfo = json[@"main"];
        if (!temperatureInfo) {
            return nil;
        }
        
        self.temperature = temperatureInfo[@"temp"];
        self.maxTemperature = temperatureInfo[@"temp_max"];
        self.minTemperature = temperatureInfo[@"temp_min"];
        self.humidity = temperatureInfo[@"humidity"];
    }
    
    return self;
}

@end
