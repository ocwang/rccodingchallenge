//
//  RCLocationManager.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN\

/*
 Encapsulate location-related functionality in RCLocationManager.
 */
@interface RCLocationManager : NSObject

- (void)getLocationWithHandler:(void (^_Nonnull)(CLLocation *location, NSError *error))handler;

@end

NS_ASSUME_NONNULL_END
