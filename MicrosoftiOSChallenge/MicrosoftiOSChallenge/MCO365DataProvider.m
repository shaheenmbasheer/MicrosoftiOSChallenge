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
 */
-(void)fetchForecastWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock{

    [MCNetworkConnection establishConnectionWithObject:request withCompletionBlock:completionBlock withErrorBlock:errorBlock];

}
@end
