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
 * MCDataController contains a weak reference to either MCDummyDataProvider or MCO365DataProvider as
 * per the value set for kLHDemoMode set to YES or NO.This controller is used for switching between data providers
 * as well as fetching the necessary data for network operations or imitate a network operation.
 */
@interface MCDataController : NSObject

+ (void)setDelegateForDemoMode;

/**
 *  User Events Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
+(void)performUserEventsRequestWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock;

/**
 *  Weather Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
+(void)performWeatherRequestWithURL:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock;
@end
