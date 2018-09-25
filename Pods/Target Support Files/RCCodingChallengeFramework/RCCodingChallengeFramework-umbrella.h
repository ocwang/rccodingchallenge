#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "RCCodingChallengeFramework.h"
#import "RCDeviceManager.h"
#import "RCLocationManager.h"
#import "RCManager.h"
#import "RCWeatherInfo.h"
#import "RCWeatherService.h"
#import "RCConstants.h"
#import "RCErrorHelper.h"
#import "RCErrors.h"

FOUNDATION_EXPORT double RCCodingChallengeFrameworkVersionNumber;
FOUNDATION_EXPORT const unsigned char RCCodingChallengeFrameworkVersionString[];

