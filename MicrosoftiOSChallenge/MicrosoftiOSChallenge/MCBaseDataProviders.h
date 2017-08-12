//
//  MCBaseDataProviders.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCRequestObjectProtocol.h"

@import Foundation;

#define kIsDemoMode NO

typedef void(^CompletionBlock)(id result);
typedef void (^ErrorBlock)(NSError *error);
/**
 *  LHBaseDataProviderDelegate is a protocol that needs to be implemented by the Server data provider class
 *  and the Dummy data provider class.Developer's as per their need will be able to switch class using an
 *  environment variable to switch between dummy data and server data for testing and deployment.
 */
@protocol MCBaseDataProviderProtocol <NSObject>

@optional

/**
 *  User  Outlook list of events for range of date Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
-(void)fetchOutlookEventsWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad;


/**
 *  Weather Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
-(void)fetchForecastWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad;

@end
