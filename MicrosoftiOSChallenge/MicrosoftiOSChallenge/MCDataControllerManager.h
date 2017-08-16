//
//  MCDataControllerManager.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCProtocolHeaders.h"
@import Foundation;
/**
 Facade Interface to simplify MCDataController
 The requirement is to call multiple API's of MCDataController without any hassle.
 */
@interface MCDataControllerManager : NSObject

@property (strong, nonatomic) NSOperationQueue *shortBurstOperationQueue;
@property (strong, nonatomic) NSOperationQueue *backgroundOperationQueue;
/**
 Connection Sequence for Events
 
 @param completionBlock completionBlock
 @param errorBlock      errorBlock
 */
+ (void)initializeEventDataWithCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock;

/**
 Connection Sequence for Weather Data
 
 @param completionBlock completionBlock
 @param errorBlock      errorBlock
 */
+ (void)initializeWeatherDataWithRequest:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock;

@end
