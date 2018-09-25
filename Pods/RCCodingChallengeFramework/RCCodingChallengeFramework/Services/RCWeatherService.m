//
//  RCWeatherService.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCWeatherService.h"
#import "../Supporting/RCErrorHelper.h"
#import "../Supporting/RCConstants.h"

@implementation RCWeatherService

+ (void)getWeatherForLocation:(CLLocation *)location withHandler:(void (^_Nonnull)(RCWeatherInfo *weatherInfo, NSError *error))handler {
    NSURL *weatherURL = [self weatherURLForLongitude:location.coordinate.longitude
                                            latitude:location.coordinate.latitude];
    
    // for more complex service layer, create network manager to manage shared
    // state between network requests
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:weatherURL
            completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                if (error) {
                    NSError *error = [RCErrorHelper errorWithCode:kRCErrorNetworkError];
                    handler(nil, error);
                    return;
                }
                
                NSError *jsonError;
                NSDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&jsonError];
                if (jsonError) {
                    NSError *error = [RCErrorHelper errorWithCode:kRCErrorJSONDecodingError];
                    handler(nil, error);
                    return;
                }
                
                RCWeatherInfo *weatherInfo = [[RCWeatherInfo alloc] initWithJSON: jsonDict];
                if (!weatherInfo) {
                    NSError *error = [RCErrorHelper errorWithCode:kRCErrorInvalidJSON];
                    handler(nil, error);
                    return;
                }
                
                handler(weatherInfo, nil);
            }] resume];
}

/*
 Private helper to generate NSURL for service; abstract into a router if more
 routes are added.
 */
+ (NSURL *)weatherURLForLongitude:(float)lon latitude:(float)lat {
    // use NSURLComponents and NSURLQueryItem to construct NSURL with it's parameters
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:OpenWeatherBaseURL];
    
    NSString *lonStr = [NSString stringWithFormat:@"%f", lon];
    NSURLQueryItem *lonQuery = [[NSURLQueryItem alloc] initWithName:@"lon" value:lonStr];
    
    NSString *latStr = [NSString stringWithFormat:@"%f", lat];
    NSURLQueryItem *latQuery = [[NSURLQueryItem alloc] initWithName:@"lat" value:latStr];
    
    NSURLQueryItem *unitsQuery = [[NSURLQueryItem alloc] initWithName:@"units" value:@"imperial"];
    
    NSURLQueryItem *appIDQuery = [[NSURLQueryItem alloc] initWithName:@"appid" value:OpenWeatherAppID];
    
    components.queryItems = @[lonQuery, latQuery, unitsQuery, appIDQuery];
    
    return components.URL;
}

@end
