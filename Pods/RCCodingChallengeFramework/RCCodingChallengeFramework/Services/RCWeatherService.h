//
//  RCWeatherService.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCWeatherInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCWeatherService : NSObject

+ (void)getWeatherForLocation:(CLLocation *)location withHandler:(void (^_Nonnull)(RCWeatherInfo *weatherInfo, NSError *error))handler;

@end

NS_ASSUME_NONNULL_END
