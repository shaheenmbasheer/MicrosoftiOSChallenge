//
//  MCDataController.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDataController.h"
#import "MCDummyDataProvider.h"
#import "MCO365DataProvider.h"
#import "MCBaseDataProviders.h"
#import "MCMappingData.h"
@implementation MCDataController
static id <MCBaseDataProviderProtocol>_dataProvider;

/**
 *  Initialize LHDataController as well as _dataProvider on factory method
 */

/**
 *  Switches between Demo and Data Provider
 *
 *  @return Demo or DataProvider Class
 */

+(Class)classForDemoMode{
    
    return (kIsDemoMode?[MCDummyDataProvider class]:[MCO365DataProvider class]);
}


+ (void)setDelegateForDemoMode{
    
    _dataProvider = [[[MCDataController classForDemoMode] alloc] init];
}

/**
 *  User Events Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
+(void)performUserEventsRequestWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{

    
    [[[MCDummyDataProvider alloc] init] fetchOutlookEventsWithCompletionBlock:^(id result) {

        completionBlock([MCMappingData mappedObjectForEventRequestWithEntriesDictionary:result]);
    } WithErrorBlock:errorBlock enableForceLoad:forceLoad];
}

/**
 *  Weather Request
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       forceLoad specifies if data should be forcefully loaded from server
 */
+(void)performWeatherRequestWithURL:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{

    [_dataProvider fetchForecastWeatherDataWithRequest:request withCompletionBlock:^(id result) {
        
        completionBlock([MCMappingData mappedObjectForWeatherRequestWithEntriesDictionary:result]);
    } WithErrorBlock:errorBlock enableForceLoad:forceLoad];
    
}

@end
