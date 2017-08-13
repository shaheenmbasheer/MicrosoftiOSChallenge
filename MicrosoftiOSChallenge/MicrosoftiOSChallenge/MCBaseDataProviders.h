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


/**
 Data source completionBlock.

 @param result data from data source.
 */
typedef void(^CompletionBlock)(id result);

/**
 Error from data source.

 @param error encountered error details.
 */
typedef void (^ErrorBlock)(NSError *error);
/**
   MCBaseDataProviderDelegate is a protocol that needs to be implemented by the Server data provider class
   and the Dummy data provider class.Developer's as per their need will be able to switch class using an
   environment variable to switch between dummy data and server data for testing and deployment.
 */
@protocol MCBaseDataProviderProtocol <NSObject>

@optional
/**
 Outlook request for list of events.

 @param completionBlock list of events from data source
 @param errorBlock encountered error with details
 */
-(void)fetchOutlookEventsWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock;

/**
 Weather request for daily weather details.

 @param request contains weather request object
 @param completionBlock daily weather details
 @param errorBlock encountered error
 */
-(void)fetchForecastWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock;

@end
