//
//  MCDataControllerManager.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 09/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MCBaseDataProviders.h"

/**
 *  Facade Interface to simplify MCDataController
 *  The requirement is to call multiple API's of MCDataController without any hassle.
 */
@interface MCDataControllerManager : NSObject

@property (strong, nonatomic) NSOperationQueue *shortBurstOperationQueue;
@property (strong, nonatomic) NSOperationQueue *backgroundOperationQueue;
/**
 *  Connection Sequence for Events
 *
 *  @param completionBlock completionBlock
 *  @param errorBlock      errorBlock
 *  @param forceLoad       specifies if data is to be forcefully loaded from server
 */
+ (void)initializeEventDataWithCompletionBlock:(CompletionBlock)completionBlock WithErrorBlock:(ErrorBlock)errorBlock enableForceLoad:(BOOL)forceLoad;
@end
