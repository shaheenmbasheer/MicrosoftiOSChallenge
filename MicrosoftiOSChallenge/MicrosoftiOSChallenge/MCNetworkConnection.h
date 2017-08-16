//
//  MCNetworkConnection.h
//  MicrosoftiOSChallenge
//
//  Created by Shaheen M on 12/08/17.
//  Copyright © 2017 Shaheen M Basheer. All rights reserved.
//

#import "MCProtocolHeaders.h"

@import Foundation;


/**
 Class handles all network operations
 */
@interface MCNetworkConnection : NSObject


/**
 Connects to server and returns parsed json response or encountered error.

 @param request requestObject contains request body and url information
 @param completionBlock completionBlock is called with parsed json on successful network connection
 @param errorBlock encountered error
 */
+(void)establishConnectionWithObject:(id<MCRequestObjectProtocol>)request withCompletionBlock:(CompletionBlock)completionBlock withErrorBlock:(ErrorBlock)errorBlock;

@end
