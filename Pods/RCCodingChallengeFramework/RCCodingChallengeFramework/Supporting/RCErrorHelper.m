//
//  RCErrorHelper.m
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import "RCErrorHelper.h"

@implementation RCErrorHelper

+ (NSError *)errorWithCode:(RCError)code {
    NSDictionary *userInfo = [RCErrorHelper userInfoForCode:code];
    
    return [NSError errorWithDomain:@"com.ocwang.RCCodingChallengeFramework"
                               code:code
                           userInfo:userInfo];
}

+ (NSDictionary *)userInfoForCode:(RCError)code {
    switch (code) {
        case kRCErrorBatteryInfoUnknown:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Error reading battery information, please try again.", nil)};
        case kRCErrorOSVersionUnsupported:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Please update your operating system version and try again.", nil)};
        case kRCErrorLocationPermissionDenied:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Location permissions have been denied, please enable and try again.", nil)};
        case kRCErrorLocationNotFound:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Location couldn't be retrieved, please try again.", nil)};
        case kRCErrorNetworkError:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Network request unsuccessful, please try again.", nil)};
        case kRCErrorJSONDecodingError:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Error decoding JSON from HTTP response.", nil)};
        case kRCErrorInvalidJSON:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Invalid JSON data, please check API.", nil)};
        case kRCErrorUnknown:
            return @{NSLocalizedDescriptionKey: NSLocalizedString(@"Unknown error occurred, please try again.", nil)};
    }
}

@end
