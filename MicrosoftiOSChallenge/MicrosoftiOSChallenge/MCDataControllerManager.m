//
//  MCDataControllerManager.m
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCDataControllerManager.h"
#import "MCDataController.h"
#import "MCEventManager.h"

@implementation MCDataControllerManager

static MCDataControllerManager *currentInstance = nil;

/**
 *  Returns shared instance of LHDataControllerManager
 *
 *  @return LHDataControllerManager shared instance
 */
+ (instancetype)sharedInstance{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        currentInstance = [[MCDataControllerManager alloc] init];
        currentInstance.shortBurstOperationQueue = [MCDataControllerManager operationQueue];
        currentInstance.backgroundOperationQueue = [MCDataControllerManager operationQueue];
        // Set connectivity settings from settings bundle
    });
    return currentInstance;
}
+(NSOperationQueue *)operationQueue{
    NSOperationQueue *operationQueue = [[NSOperationQueue alloc] init];
    operationQueue.maxConcurrentOperationCount =  1;
    return operationQueue;
}

/**
 *  Connection Sequence for Events
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       specifies if data is to be forcefully loaded from server
 */
+ (void)initializeEventDataWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{

    NSOperationQueue *queue = [[MCDataControllerManager sharedInstance] backgroundOperationQueue];
    
    ErrorBlock __unused queueErrorBlock = ^(NSError *error){
        
        [queue cancelAllOperations];
        errorBlock(error);
        
    };
    
    // Event Data Loading
    NSOperation *eventsDataOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [MCDataController performUserEventsRequestWithCompletionBlock:^(id result) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [[MCEventManager sharedInstance] setEventArray:result];

            });
        } WithErrorBlock:errorBlock enableForceLoad:forceLoad];
        
          }];
    
    [queue addOperation:eventsDataOperation];
    
    NSOperation *totalCompletionOperation = [NSBlockOperation blockOperationWithBlock:^{
        // Finish Status
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            eventsDataOperation.isFinished?completionBlock(nil):errorBlock(nil);
        });
    }];
    
    [queue addOperation:totalCompletionOperation];

}

/**
 *  Connection Sequence for Weather Data
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       specifies if data is to be forcefully loaded from server
 */
+ (void)initializeWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad{

    NSOperationQueue *queue = [[MCDataControllerManager sharedInstance] backgroundOperationQueue];
    
    ErrorBlock __unused queueErrorBlock = ^(NSError *error){
        
        [queue cancelAllOperations];
        errorBlock(error);
        
    };
    
    // Event Data Loading
    
    __block id parsedResult;
    NSOperation *weatherDataOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        [MCDataController performWeatherRequestWithURL:request withCompletionBlock:^(id result) {
        
            parsedResult = result;
        } WithErrorBlock:errorBlock enableForceLoad:forceLoad];
        
    }];
    
    [queue addOperation:weatherDataOperation];
    
    NSOperation *totalCompletionOperation = [NSBlockOperation blockOperationWithBlock:^{
        // Finish Status
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            weatherDataOperation.isFinished?completionBlock(parsedResult):errorBlock(nil);
        });
    }];
    
    [queue addOperation:totalCompletionOperation];



}
@end
