//
//  MCO365DataProvider.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCO365DataProvider.h"
#import "MCProtocolHeaders.h"
#import "MCNetworkConnection.h"

@implementation MCO365DataProvider

/**
 *  Weather Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
-(void)fetchForecastWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{

    [MCNetworkConnection establishConnectionWithObject:request withCompletionBlock:completionBlock WithErrorBlock:errorBlock];

}
@end
