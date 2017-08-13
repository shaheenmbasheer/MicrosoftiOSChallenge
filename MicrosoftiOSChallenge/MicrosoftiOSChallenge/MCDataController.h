//
//  MCDataController.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCBaseDataProviders.h"
#import "MCProtocolHeaders.h"

@import Foundation;
/**
 MCDataController contains a weak reference to either MCDummyDataProvider or MCO365DataProvider as
 per the value set for kLHDemoMode set to YES or NO.This controller is used for switching between data providers
 as well as fetching the necessary data for network operations or imitate a network operation.
 */
@interface MCDataController : NSObject

+ (void)setDelegateForDemoMode;

/**
 User Events Request.
 
 @param completionBlock completionBlock with result.
 @param errorBlock      errorBlock
 */
+(void)performUserEventsRequestWithCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock;

/**
 Weather Request.
 
 @param completionBlock completionBlock
 @param errorBlock      errorBlock
 */
+(void)performWeatherRequestWithURL:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock;
@end
