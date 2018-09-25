//
//  RCErrorHelper.h
//  RCCodingChallengeFramework
//
//  Created by Chase Wang on 9/24/18.
//  Copyright © 2018 ocw. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCErrors.h"

NS_ASSUME_NONNULL_BEGIN

@interface RCErrorHelper : NSObject

+ (NSError *)errorWithCode:(RCError)code;

@end

NS_ASSUME_NONNULL_END
