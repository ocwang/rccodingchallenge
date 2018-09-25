//
//  RCErrors.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#ifndef RCErrors_h
#define RCErrors_h

typedef NS_ENUM(NSInteger, RCError) {
    kRCErrorBatteryInfoUnknown,
    kRCErrorOSVersionUnsupported,
    kRCErrorLocationPermissionDenied,
    kRCErrorLocationNotFound,
    kRCErrorNetworkError,
    kRCErrorJSONDecodingError,
    kRCErrorInvalidJSON,
    kRCErrorUnknown
};

#endif /* RCErrors_h */
